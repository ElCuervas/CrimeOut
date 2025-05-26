class UserModel {
  final String email;
  final String password;
  final String name;
  final String rut;

  UserModel({
    required this.email,
    required this.password,
    required this.name,
    required this.rut,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        'name': name,
        'rut': rut,
      };

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        email: json['email'],
        password: json['password'],
        name: json['name'],
        rut: json['rut'],
      );
}