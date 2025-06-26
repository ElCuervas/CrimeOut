import '../../domain/entities/usuario_perfil.dart';

class UsuarioPerfilModel extends UsuarioPerfil {
  UsuarioPerfilModel({
    required super.id,
    required super.nombre,
    required super.rol,
    required super.confiable,
  });

  factory UsuarioPerfilModel.fromJson(Map<String, dynamic> json) {
    return UsuarioPerfilModel(
      id: json['id'],
      nombre: json['nombre'],
      rol: json['rol'],
      confiable: json['confiable'],
    );
  }

  UsuarioPerfil toEntity() {
    return UsuarioPerfil(
      id: id,
      nombre: nombre,
      rol: rol,
      confiable: confiable,
    );
  }
}