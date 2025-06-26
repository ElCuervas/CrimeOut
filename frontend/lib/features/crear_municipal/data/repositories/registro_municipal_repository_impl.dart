import '../../domain/entities/registro_municipal.dart';
import '../../domain/repositories/registro_municipal_repository.dart';
import '../datasources/registro_municipal_remote_data_source.dart';
import '../models/registro_municipal_model.dart';

class RegistroMunicipalRepositoryImpl implements RegistroMunicipalRepository {
  final RegistroMunicipalRemoteDataSource remoteDataSource;

  RegistroMunicipalRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> registrarUsuarioMunicipal(RegistroMunicipal registro) {
    final model = RegistroMunicipalModel.fromEntity(registro);
    return remoteDataSource.registrarUsuarioMunicipal(model);
  }
}