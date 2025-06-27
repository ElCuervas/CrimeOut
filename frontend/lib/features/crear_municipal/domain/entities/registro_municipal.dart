class RegistroMunicipal {
  final String nombre;
  final String correo;
  final String rut;
  final String password;
  final String rol;

  RegistroMunicipal({
    required this.nombre,
    required this.correo,
    required this.rut,
    required this.password,
    this.rol = 'ROL_MUNICIPAL',
  });
}