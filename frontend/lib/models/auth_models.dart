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
  final String role;
  final String token;
  final int idUsuario;

  LoginResponse({
    required this.role,
    required this.token,
    required this.idUsuario,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      role: json['role'] as String,
      token: json['token'] as String,
      idUsuario: json['idUsuario'] as int,
    );
  }
}