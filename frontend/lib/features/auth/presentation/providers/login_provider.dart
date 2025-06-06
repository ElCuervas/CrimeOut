import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../data/models/auth_models.dart';
import '../providers/auth_provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/features/reports_history/presentation/providers/report_history_provider.dart';
import 'userIdProvider.dart';

final loginProvider = StateNotifierProvider<LoginNotifier, AsyncValue<LoginResponse>>(
  (ref) => LoginNotifier(
    ref.read(loginUserUseCaseProvider),
    ref, // ✅ pasamos el ref al notifier
  ),
);

class LoginNotifier extends StateNotifier<AsyncValue<LoginResponse>> {
  final LoginUseCase _useCase;
  final Ref _ref; // ✅ lo almacenamos aquí

  LoginNotifier(this._useCase, this._ref)
      : super( AsyncData(LoginResponse(token: '', idUsuario: 0)));

  final _storage = FlutterSecureStorage();

  Future<void> login({
    required String rut,
    required String contrasena,
  }) async {
    state = const AsyncLoading();
    try {
      final response = await _useCase.execute(LoginRequest(rut: rut, contrasena: contrasena));

      await _storage.write(key: 'jwt_token', value: response.token);
      await _storage.write(key: 'user_id', value: response.idUsuario.toString());

      _ref.invalidate(reportHistoryProvider);
      _ref.invalidate(userIdProvider); // ✅ ahora sí puedes usarlo

      state = AsyncData(response);
    } catch (e, stack) {
      print("🔥 Error en login: $e");
      state = AsyncError(e, stack);
    }
  }
}