import '../../domain/entities/registro_municipal.dart';

class RegistroMunicipalModel extends RegistroMunicipal {
  RegistroMunicipalModel({
    required super.correo,
    required super.nombre,
    required super.rut,
    required super.password,
    required super.rol,
  });

  factory RegistroMunicipalModel.fromJson(Map<String, dynamic> json) {
    return RegistroMunicipalModel(
      correo: json['correo'],
      nombre: json['nombre'],
      rut: json['rut'],
      password: json['password'],
      rol: json['rol'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'correo': correo,
      'nombre': nombre,
      'rut': rut,
      'password': password,
      'rol': rol,
    };
  }

  /// 🔧 Método que permite crear un modelo desde la entidad
  factory RegistroMunicipalModel.fromEntity(RegistroMunicipal entity) {
    return RegistroMunicipalModel(
      correo: entity.correo,
      nombre: entity.nombre,
      rut: entity.rut,
      password: entity.password,
      rol: entity.rol,
    );
  }
}