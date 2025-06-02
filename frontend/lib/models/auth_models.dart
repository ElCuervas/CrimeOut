class LoginRequest {
  final String rut;
  final String contrasena;

  LoginRequest({required this.rut, required this.contrasena});

  Map<String, dynamic> toJson() => {
        'rut': rut,
        'contrasena': contrasena,
      };
}

class LoginResponse {
  final List<String> roles;
  final String token;
  final int idUsuario;

  LoginResponse({
    required this.roles,
    required this.token,
    required this.idUsuario,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      roles: List<String>.from(json['roles'] ?? []),
      token: json['token'] as String,
      idUsuario: json['idUsuario'] as int,
    );
  }
}