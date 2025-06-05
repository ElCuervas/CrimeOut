import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/auth/domain/repositories/auth_repository.dart';
import 'package:frontend/features/auth/domain/usecases/login_usecase.dart';
import 'package:frontend/features/auth/domain/usecases/register_user_usecase.dart';
import 'package:frontend/features/auth/data/datasources/auth_service.dart';


// Proveedor del AuthRepository (AuthService actúa como implementación)
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthService(); // debe implementar AuthRepository
});

// Proveedor del caso de uso de Login
final loginUserUseCaseProvider = Provider<LoginUseCase>((ref) {
  final repository = ref.read(authRepositoryProvider);
  return LoginUseCase(repository);
});

// Proveedor del caso de uso de Registro
final registerUserUseCaseProvider = Provider<RegisterUseCase>((ref) {
  final repository = ref.read(authRepositoryProvider);
  return RegisterUseCase(repository);
});