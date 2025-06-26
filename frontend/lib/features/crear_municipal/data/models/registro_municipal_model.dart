import '../../domain/entities/registro_municipal.dart';

class RegistroMunicipalModel extends RegistroMunicipal {
  RegistroMunicipalModel({
    required super.correo,
    required super.nombre,
    required super.rut,
    required super.contrasena,
    required super.rol,
  });

  factory RegistroMunicipalModel.fromJson(Map<String, dynamic> json) {
    return RegistroMunicipalModel(
      correo: json['correo'],
      nombre: json['nombre'],
      rut: json['rut'],
      contrasena: json['contrasena'],
      rol: json['rol'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'correo': correo,
      'nombre': nombre,
      'rut': rut,
      'contrasena': contrasena,
      'rol': rol,
    };
  }

  /// 🔧 Método que permite crear un modelo desde la entidad
  factory RegistroMunicipalModel.fromEntity(RegistroMunicipal entity) {
    return RegistroMunicipalModel(
      correo: entity.correo,
      nombre: entity.nombre,
      rut: entity.rut,
      contrasena: entity.contrasena,
      rol: entity.rol,
    );
  }
}