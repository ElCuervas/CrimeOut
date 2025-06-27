import '../../domain/entities/estado_sistema.dart';
import '../../domain/entities/usuario_admin.dart';
import '../../domain/repositories/admin_repository.dart';
import '../datasources/admin_remote_data_source.dart';
import '../models/estado_sistema_model.dart';
import '../models/usuario_admin_model.dart';

class AdminRepositoryImpl implements AdminRepository {
  final AdminRemoteDataSource remoteDataSource;

  AdminRepositoryImpl(this.remoteDataSource);

  @override
  Future<EstadoSistema> obtenerEstadoSistema() async {
    final EstadoSistemaModel data = await remoteDataSource.fetchEstadoSistema();
    return data;
  }

  @override
  Future<List<UsuarioAdmin>> obtenerUsuariosPorRol(String rol) async {
    final List<UsuarioAdminModel> data = await remoteDataSource.fetchUsuariosPorRol(rol);
    return data;
  }

  @override
  Future<List<UsuarioAdminModel>> getUsuarioPorNombre(String nombre) {
    return remoteDataSource.fetchUsuarioPorNombre(nombre);
  }
}