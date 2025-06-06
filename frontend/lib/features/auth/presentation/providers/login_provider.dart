import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../data/models/auth_models.dart';
import '../providers/auth_provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final loginProvider = StateNotifierProvider<LoginNotifier, AsyncValue<LoginResponse>>(
  (ref) => LoginNotifier(ref.read(loginUserUseCaseProvider)),
);

class LoginNotifier extends StateNotifier<AsyncValue<LoginResponse>> {
  final LoginUseCase _useCase;

  LoginNotifier(this._useCase) : super( AsyncData(LoginResponse(role: '', token: '', idUsuario: 0)));
  final _storage = FlutterSecureStorage();
  Future<void> login({
  required String rut,
  required String contrasena,
}) async {
  state = const AsyncLoading();
  try {
    final response = await _useCase.execute(LoginRequest(rut: rut, contrasena: contrasena));

    // ✅ Guardar token ,user_id y role
    await _storage.write(key: 'jwt_token', value: response.token);
    await _storage.write(key: 'user_id', value: response.idUsuario.toString());
    await _storage.write(key: 'role', value: response.role);

    state = AsyncData(response);
  } catch (e, st) {
    state = AsyncError(e, st);
  }
}
}