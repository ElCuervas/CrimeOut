class Usuario {
  final int id;
  final String nombre;
  final String rol;

  Usuario({
    required this.id,
    required this.nombre,
    required this.rol
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'],
      nombre: json['nombre'],
      rol: json['rol']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'rol': rol
    };
  }
}
