import '../../domain/entities/usuario_admin.dart';

class UsuarioAdminModel extends UsuarioAdmin {
  UsuarioAdminModel({
    required super.id,
    required super.nombre,
    required super.rol,
    super.confiable,
  });

  factory UsuarioAdminModel.fromJson(Map<String, dynamic> json) {
    return UsuarioAdminModel(
      id: json['id'],
      nombre: json['nombre'],
      rol: json['rol'],
      confiable: json['confiable'], // puede venir null
    );
  }
}