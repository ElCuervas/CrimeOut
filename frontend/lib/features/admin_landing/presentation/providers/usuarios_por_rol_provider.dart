import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/usuario_admin.dart';
import '../../data/repositories/admin_repository_impl.dart';
import '../../data/datasources/admin_remote_data_source.dart';
import '../../domain/usecases/get_usuarios_por_rol_usecase.dart';

final usuariosPorRolProvider = FutureProvider.family<List<UsuarioAdmin>, String>((ref, rol) async {
  final usecase = GetUsuariosPorRolUseCase(AdminRepositoryImpl(AdminRemoteDataSource()));
  return await usecase.execute(rol);
});