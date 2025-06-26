import '../entities/registro_municipal.dart';

abstract class RegistroMunicipalRepository {
  Future<void> registrarUsuarioMunicipal(RegistroMunicipal registro);
}