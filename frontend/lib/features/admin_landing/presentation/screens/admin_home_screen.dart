import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/usuario_admin.dart';
import '../providers/estado_sistema_provider.dart';
import '../providers/usuario_por_nombre_provider.dart';
import '../providers/usuarios_por_rol_provider.dart';
import '../widgets/admin_info_card.dart';
import '../widgets/usuario_item_tile.dart';
import 'package:frontend/core/constants/admin_global_widgets/admin_banner_header.dart';
import 'package:frontend/core/constants/admin_global_widgets/admin_bottom_navigation.dart';

class AdminHomeScreen extends ConsumerStatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  ConsumerState<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends ConsumerState<AdminHomeScreen> {
  String _rolSeleccionado = 'municipal';
  String _nombreBuscado = '';
  final _nombreController = TextEditingController();

  void _buscarPorNombre() {
    setState(() {
      _nombreBuscado = _nombreController.text.trim();
    });
  }

  @override
Widget build(BuildContext context) {
  final estadoAsync = ref.watch(estadoSistemaProvider);
  final usuariosAsync = _nombreBuscado.isNotEmpty
      ? ref.watch(usuarioPorNombreProvider(_nombreBuscado))
      : ref.watch(usuariosPorRolProvider(_rolSeleccionado));

  return Scaffold(
    body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🟪 Banner de administración
          const AdminBannerHeader(titulo: 'Administración'),
          const SizedBox(height: 16),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🟦 Estado del sistema
                estadoAsync.when(
                  data: (estado) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      AdminInfoCard(
                        titulo: 'Usuarios',
                        valor: estado.totalUsuarios,
                        color: Colors.indigo,
                      ),
                      AdminInfoCard(
                        titulo: 'Reportes',
                        valor: estado.totalReportes,
                        color: Colors.deepPurple,
                      ),
                      AdminInfoCard(
                        titulo: 'Sospechosos',
                        valor: estado.reportesSospechosos,
                        color: Colors.red,
                      ),
                    ],
                  ),
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (e, _) => Text('Error: $e'),
                ),
                const SizedBox(height: 24),

                // 🟩 Filtro por rol
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DropdownButton<String>(
                      value: _rolSeleccionado,
                      items: const [
                        DropdownMenuItem(value: 'municipal', child: Text('Municipales')),
                        DropdownMenuItem(value: 'común', child: Text('Usuarios Comunes')),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _rolSeleccionado = value;
                            _nombreBuscado = '';
                            _nombreController.clear();
                          });
                        }
                      },
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(context, '/admin-create-municipal');
                      },
                      icon: const Icon(Icons.add),
                      label: const Text('Nueva cuenta municipal'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6B49F6),
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // 🟦 Buscador por nombre
                TextField(
                  controller: _nombreController,
                  decoration: InputDecoration(
                    hintText: 'Buscar por nombre...',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: _buscarPorNombre,
                    ),
                  ),
                  onSubmitted: (_) => _buscarPorNombre(),
                ),
                const SizedBox(height: 16),

                // 🟨 Lista de usuarios
                usuariosAsync.when(
                  data: (usuarios) {
                    if (usuarios is List<UsuarioAdmin>) {
                      return Column(
                        children: usuarios.map((u) => UsuarioItemTile(usuario: u)).toList(),
                      );
                    } else if (usuarios is UsuarioAdmin) {
                      return UsuarioItemTile(usuario: usuarios);
                    } else {
                      return const Text('Sin resultados');
                    }
                  },
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (e, _) => Text('Error: $e'),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
    bottomNavigationBar: const AdminBottomNavigationBar(currentIndex: 0),
  );
}
}