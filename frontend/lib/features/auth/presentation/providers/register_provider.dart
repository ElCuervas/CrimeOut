import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/auth/domain/usecases/register_user_usecase.dart';
import 'package:frontend/features/auth/data/models/auth_models.dart';
import '../providers/auth_provider.dart'; 

final registerProvider = StateNotifierProvider<RegisterNotifier, AsyncValue<void>>(
  (ref) => RegisterNotifier(ref.read(registerUserUseCaseProvider)),
);

class RegisterNotifier extends StateNotifier<AsyncValue<void>> {
  final RegisterUseCase _useCase;

  RegisterNotifier(this._useCase) : super(const AsyncData(null));

  Future<void> register({
    required String correo,
    required String password,
    required String nombre,
    required String rut,
  }) async {
    state = const AsyncLoading();
    try {
      final request = RegisterRequest(
        correo: correo,
        password: password,
        nombre: nombre,
        rut: rut,
      );
      await _useCase.execute(request);
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}