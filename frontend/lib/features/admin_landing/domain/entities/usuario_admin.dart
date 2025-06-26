class UsuarioAdmin {
  final int id;
  final String nombre;
  final String rol;
  final bool? confiable; // puede ser null si se obtiene por rol

  UsuarioAdmin({
    required this.id,
    required this.nombre,
    required this.rol,
    this.confiable,
  });
}