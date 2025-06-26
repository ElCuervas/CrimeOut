class RegistroMunicipal {
  final String nombre;
  final String correo;
  final String rut;
  final String contrasena;
  final String rol;

  RegistroMunicipal({
    required this.nombre,
    required this.correo,
    required this.rut,
    required this.contrasena,
    this.rol = 'ROL_MUNICIPAL',
  });
}