import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/admin_global_widgets/admin_banner_header.dart';
import '../providers/get_usuario_con_reportes_provider.dart';
import '../widgets/reporte_historial_item.dart';

class AdminUserProfileScreen extends ConsumerWidget {
  const AdminUserProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int idUsuario = ModalRoute.of(context)!.settings.arguments as int;
    final usuarioAsync = ref.watch(usuarioConReportesProvider(idUsuario));

    return Scaffold(
      body: usuarioAsync.when(
        data: (usuario) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const AdminBannerHeader(titulo: 'Perfil de Usuario'),
            const SizedBox(height: 16),

            // Datos del usuario
            Card(
              elevation: 2,
              child: ListTile(
                title: Text(usuario.nombreUsuario, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                subtitle: Text(usuario.roles.join(', ')),
              ),
            ),
            const SizedBox(height: 16),

            // Botón eliminar usuario
            ElevatedButton.icon(
              onPressed: () async {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text('Eliminar usuario'),
                    content: const Text('¿Estás seguro que deseas eliminar este usuario?'),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancelar')),
                      TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Eliminar')),
                    ],
                  ),
                );

                if (confirm == true) {
                  final deleteUseCase = ref.read(eliminarUsuarioProvider);
                  try {
                    await deleteUseCase.execute(idUsuario);
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('✅ Usuario eliminado')));
                      Navigator.pop(context);
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('❌ Error: $e')));
                  }
                }
              },
              icon: const Icon(Icons.delete),
              label: const Text('Eliminar usuario'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            ),
            const SizedBox(height: 24),

            // Lista de reportes
            const Text('Reportes generados', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            ...usuario.reportes.map((r) => ReporteHistorialItem(reporte: r)).toList(),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error al cargar datos: $e')),
      ),
    );
  }
}