import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Provider que obtiene el ID del usuario desde el almacenamiento seguro
final userIdProvider = FutureProvider<int>((ref) async {
  const storage = FlutterSecureStorage();
  final idStr = await storage.read(key: 'user_id');
  if (idStr == null) throw Exception('Usuario no autenticado');
  return int.parse(idStr);
});