import 'package:flutter/material.dart';
import '../../domain/entities/usuario_admin.dart';

class UsuarioItemTile extends StatelessWidget {
  final UsuarioAdmin usuario;

  const UsuarioItemTile({super.key, required this.usuario});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.person),
      title: Text(usuario.nombre),
      subtitle: Text(usuario.rol),
    );
  }
}