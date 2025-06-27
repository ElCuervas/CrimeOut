import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/services/perfil_service.dart';
import '../../domain/entities/usuario.dart';

final perfilProvider = FutureProvider<Usuario>((ref) async {
  return await PerfilService.obtenerUsuarioActual();
});

final perfilUsuarioProvider = FutureProvider.family<Usuario, int>((ref, userId) async {
  return await PerfilService.obtenerUsuario(userId);
});
