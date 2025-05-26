import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/auth/domain/usecases/register_user_usecase.dart';

final registerProvider = StateNotifierProvider<RegisterNotifier, AsyncValue<void>>(
  (ref) => RegisterNotifier(ref.read(registerUserUseCaseProvider)),
);

class RegisterNotifier extends StateNotifier<AsyncValue<void>> {
  final RegisterUserUseCase _useCase;

  RegisterNotifier(this._useCase) : super(const AsyncData(null));

  Future<void> register({
    required String email,
    required String password,
    required String name,
    required String rut,
  }) async {
    state = const AsyncLoading();
    try {
      await _useCase.execute(
        email: email,
        password: password,
        name: name,
        rut: rut,
      );
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}