import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../providers/perfil_provider.dart';
import '../../data/services/perfil_service.dart';
import 'package:frontend/core/global_widgets/popup_sugerencia_desarrolladores.dart';

class PerfilUsuarioScreen extends ConsumerWidget {
  const PerfilUsuarioScreen({super.key});

  Future<void> _handleLogout(BuildContext context, WidgetRef ref) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Cerrar sesión'),
        content: const Text('¿Estás seguro de que deseas cerrar sesión?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Cerrar sesión'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      const storage = FlutterSecureStorage();
      await storage.deleteAll();
      // Limpiar el estado del provider
      ref.read(perfilProvider.notifier).limpiarDatos();
      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
      }
    }
  }

  Future<void> _enviarSugerencia(String mensaje) async {
    try {
      await PerfilService.enviarSugerencia(mensaje);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final perfilState = ref.watch(perfilProvider);
    
    // Inicializar el auto-refresh provider para detectar cambios en user ID
    ref.watch(autoRefreshPerfilProvider);

    // Cargar los datos del usuario cuando se monta el widget
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(perfilProvider.notifier).cargarUsuarioActual();
    });

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: _buildBody(context, ref, perfilState),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        selectedItemColor: const Color(0xFF6B49F6),
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/reporte-mapa');
              break;
            case 1:
              Navigator.pushReplacementNamed(context, '/historial-reportes');
              break;
            case 2:
              // Ya estamos en perfil
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.place), label: "Reportar"),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "Historial"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Perfil"),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context, WidgetRef ref, PerfilState perfilState) {
    if (perfilState.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (perfilState.error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red[400],
            ),
            const SizedBox(height: 16),
            Text(
              'Error al cargar el perfil',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                perfilState.error!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => ref.read(perfilProvider.notifier).refrescarUsuario(),
              icon: const Icon(Icons.refresh),
              label: const Text('Reintentar'),
            ),
          ],
        ),
      );
    }

    if (perfilState.usuario == null) {
      return const Center(
        child: Text('No se pudo cargar la información del usuario'),
      );
    }

    return RefreshIndicator(
      onRefresh: () => ref.read(perfilProvider.notifier).refrescarUsuario(),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Header con información del usuario
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    perfilState.usuario!.nombre,
                    style: const TextStyle(
                      fontSize: 24,
                          fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'demo@email.com', // Email hardcodeado como en la imagen
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Opciones del menú
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildMenuOption(
                    icon: Icons.code,
                    iconColor: const Color(0xFF8B7CF6),
                    title: 'Sugerencias a desarrolladores',
                    onTap: () {
                      showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) => PopupSugerenciaDesarrolladores(
                          onGuardarSugerencia: _enviarSugerencia,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 8),
                  const Divider(height: 1, thickness: 1, color: Color(0xFFF0F0F0)),
                  const SizedBox(height: 8),
                  _buildMenuOption(
                    icon: Icons.edit,
                    iconColor: Colors.grey[600]!,
                    title: 'Editar datos de perfil',
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Funcionalidad en desarrollo'),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 8),
                  const Divider(height: 1, thickness: 1, color: Color(0xFFF0F0F0)),
                  const SizedBox(height: 8),
                  _buildMenuOption(
                    icon: Icons.logout,
                    iconColor: const Color(0xFF4A90E2),
                    title: 'Cerrar sesión',
                    onTap: () => _handleLogout(context, ref),
                  ),
                  const SizedBox(height: 8),
                  const Divider(height: 1, thickness: 1, color: Color(0xFFF0F0F0)),
                  const SizedBox(height: 8),
                  _buildMenuOption(
                    icon: Icons.delete_forever,
                    iconColor: const Color(0xFFE53E3E),
                    title: 'Borrar cuenta',
                    onTap: () {
                      _showDeleteAccountDialog(context);
                    },
                    isDestructive: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuOption({
    required IconData icon,
    required Color iconColor,
    required String title,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return ListTile(
      leading: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: iconColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          color: iconColor,
          size: 24,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: isDestructive ? const Color(0xFFE53E3E) : Colors.black87,
        ),
      ),
      trailing: Icon(
        Icons.chevron_right,
        color: Colors.grey[400],
        size: 24,
      ),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
    );
  }

  Future<void> _showDeleteAccountDialog(BuildContext context) async {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text(
          'Borrar cuenta',
          style: TextStyle(color: Color(0xFFE53E3E)),
        ),
        content: const Text(
          '¿Estás seguro de que deseas borrar tu cuenta? Esta acción no se puede deshacer.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Funcionalidad en desarrollo'),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE53E3E),
              foregroundColor: Colors.white,
            ),
            child: const Text('Borrar'),
          ),
        ],
      ),
    );
  }
}
