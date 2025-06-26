import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/crear_municipal/domain/entities/registro_municipal.dart';
import 'package:frontend/features/crear_municipal/presentation/providers/registrar_municipal_provider.dart';
import 'package:frontend/core/constants/admin_global_widgets/admin_banner_header.dart';
import 'package:frontend/core/constants/admin_global_widgets/admin_bottom_navigation.dart';

class CrearCuentaMunicipalScreen extends ConsumerStatefulWidget {
  const CrearCuentaMunicipalScreen({super.key});

  @override
  ConsumerState<CrearCuentaMunicipalScreen> createState() => _CrearCuentaMunicipalScreenState();
}

class _CrearCuentaMunicipalScreenState extends ConsumerState<CrearCuentaMunicipalScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nombreCtrl = TextEditingController();
  final _correoCtrl = TextEditingController();
  final _rutCtrl = TextEditingController();
  final _contrasenaCtrl = TextEditingController();
  bool _isSubmitting = false;

  void _registrarUsuarioMunicipal() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);
    final usecase = ref.read(registrarMunicipalProvider);

    final nuevoUsuario = RegistroMunicipal(
      nombre: _nombreCtrl.text.trim(),
      correo: _correoCtrl.text.trim(),
      rut: _rutCtrl.text.trim(),
      contrasena: _contrasenaCtrl.text.trim(),
      rol: 'ROL_MUNICIPAL',
    );

    try {
      await usecase.execute(nuevoUsuario);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('✅ Cuenta creada exitosamente')),
      );
      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('❌ Error: ${e.toString()}')),
      );
    } finally {
      setState(() => _isSubmitting = false);
    }
  }

    @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const AdminBannerHeader(titulo: 'Administración'),
          const SizedBox(height: 24),

          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _nombreCtrl,
                  decoration: const InputDecoration(labelText: 'Nombre'),
                  validator: (value) => value == null || value.isEmpty ? 'Ingrese el nombre' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _correoCtrl,
                  decoration: const InputDecoration(labelText: 'Correo'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) => value == null || !value.contains('@') ? 'Ingrese un correo válido' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _rutCtrl,
                  decoration: const InputDecoration(labelText: 'RUT'),
                  validator: (value) => value == null || value.isEmpty ? 'Ingrese el RUT' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _contrasenaCtrl,
                  decoration: const InputDecoration(labelText: 'Contraseña'),
                  obscureText: true,
                  validator: (value) => value == null || value.length < 6 ? 'Debe tener al menos 6 caracteres' : null,
                ),
                const SizedBox(height: 32),
                ElevatedButton.icon(
                  onPressed: _isSubmitting ? null : _registrarUsuarioMunicipal,
                  icon: const Icon(Icons.person_add),
                  label: const Text('Registrar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const AdminBottomNavigationBar(currentIndex:-1),
    );
  }
}