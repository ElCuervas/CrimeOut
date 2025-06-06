class LoginRequest {
  final String rut;
  final String contrasena;

  LoginRequest({required this.rut, required this.contrasena});

  Map<String, dynamic> toJson() => {
        'rut': rut,
        'password': contrasena,
      };
}

class LoginResponse {

  final String token;
  final int idUsuario;

  LoginResponse({

    required this.token,
    required this.idUsuario,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
  return LoginResponse(
    token: json['token'] as String,
    idUsuario: int.tryParse(json['idUsuario'].toString()) ?? -1,
  );
}
}
class RegisterRequest {
  final String nombre;
  final String rut;
  final String correo;
  final String password;

  RegisterRequest({
    required this.nombre,
    required this.rut,
    required this.correo,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        'nombre': nombre,
        'rut': rut,
        'correo': correo,
        'password': password,
      };
}