import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../data/services/perfil_service.dart';
import '../../domain/entities/usuario.dart';

// Estado para manejar la información del perfil
class PerfilState {
  final Usuario? usuario;
  final bool isLoading;
  final String? error;
  final String? currentUserId;

  const PerfilState({
    this.usuario,
    this.isLoading = false,
    this.error,
    this.currentUserId,
  });

  PerfilState copyWith({
    Usuario? usuario,
    bool? isLoading,
    String? error,
    String? currentUserId,
  }) {
    return PerfilState(
      usuario: usuario ?? this.usuario,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      currentUserId: currentUserId ?? this.currentUserId,
    );
  }
}

// StateNotifier para manejar el estado del perfil
class PerfilNotifier extends StateNotifier<PerfilState> {
  PerfilNotifier() : super(const PerfilState());
  
  static const storage = FlutterSecureStorage();

  Future<void> cargarUsuarioActual({bool force = false}) async {
    try {
      // Obtener el ID del usuario actual del storage
      final userIdString = await storage.read(key: 'user_id');
      
      // Si no hay cambio en el ID del usuario y no es forzado, no hacer nada
      if (!force && state.currentUserId == userIdString && state.usuario != null) {
        return;
      }

      state = state.copyWith(isLoading: true, error: null);

      if (userIdString == null) {
        state = state.copyWith(
          isLoading: false,
          error: 'No se encontró el ID del usuario en sessionStorage',
          usuario: null,
          currentUserId: null,
        );
        return;
      }

      final userId = int.tryParse(userIdString);
      if (userId == null) {
        state = state.copyWith(
          isLoading: false,
          error: 'ID de usuario inválido en sessionStorage',
          usuario: null,
          currentUserId: userIdString,
        );
        return;
      }

      final usuario = await PerfilService.obtenerUsuario(userId);
      state = state.copyWith(
        isLoading: false,
        usuario: usuario,
        error: null,
        currentUserId: userIdString,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
        usuario: null,
      );
    }
  }

  Future<void> refrescarUsuario() async {
    await cargarUsuarioActual(force: true);
  }

  Future<void> actualizarUsuario({
    required String nombre,
    required String correo,
    required String contrasena,
  }) async {
    try {
      final userIdString = await storage.read(key: 'user_id');
      if (userIdString == null) {
        throw Exception('No se encontró el ID del usuario');
      }
      
      final userId = int.tryParse(userIdString);
      if (userId == null) {
        throw Exception('ID de usuario inválido');
      }

      await PerfilService.actualizarUsuario(
        userId: userId,
        nombre: nombre,
        correo: correo,
        contrasena: contrasena,
      );

      // Después de actualizar, refrescar los datos del usuario
      await cargarUsuarioActual(force: true);
    } catch (e) {
      throw Exception('Error al actualizar usuario: $e');
    }
  }

  void limpiarDatos() {
    state = const PerfilState();
  }
}

// Provider principal para el perfil del usuario actual
final perfilProvider = StateNotifierProvider<PerfilNotifier, PerfilState>((ref) {
  return PerfilNotifier();
});

// Provider para obtener un usuario específico por ID (mantener para compatibilidad)
final perfilUsuarioProvider = FutureProvider.family<Usuario, int>((ref, userId) async {
  return await PerfilService.obtenerUsuario(userId);
});

// Provider que monitorea cambios en el ID del usuario
final userIdWatcherProvider = StreamProvider<String?>((ref) async* {
  const storage = FlutterSecureStorage();
  
  // Emitir el valor inicial
  String? currentUserId = await storage.read(key: 'user_id');
  yield currentUserId;
  
  // Monitorear cambios cada segundo (puedes ajustar el intervalo)
  while (true) {
    await Future.delayed(const Duration(seconds: 1));
    final newUserId = await storage.read(key: 'user_id');
    if (newUserId != currentUserId) {
      currentUserId = newUserId;
      yield currentUserId;
    }
  }
});

// Provider que escucha cambios en el user ID y actualiza el perfil automáticamente
final autoRefreshPerfilProvider = Provider<void>((ref) {
  ref.listen(userIdWatcherProvider, (previous, next) {
    next.whenData((newUserId) {
      final previousUserId = previous?.asData?.value;
      if (newUserId != previousUserId) {
        // El user ID cambió, refrescar el perfil
        ref.read(perfilProvider.notifier).cargarUsuarioActual(force: true);
      }
    });
  });
});
