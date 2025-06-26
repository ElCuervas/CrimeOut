import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/registro_municipal_remote_data_source.dart';
import '../../data/repositories/registro_municipal_repository_impl.dart';
import '../../domain/usecases/registrar_municipal_usecase.dart';

/// Proveedor para registrar un nuevo usuario municipal
final registrarMunicipalProvider = Provider<RegistrarMunicipalUseCase>((ref) {
  return RegistrarMunicipalUseCase(
    RegistroMunicipalRepositoryImpl(
      RegistroMunicipalRemoteDataSource(),
    ),
  );
});