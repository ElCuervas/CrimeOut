import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/register_provider.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/auth_submit_button.dart';
import '../widgets/auth_header.dart';
import 'package:frontend/core/utils/rut_validator.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  static const routeName = '/registro';
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _nombreCtrl = TextEditingController();
  final _rutCtrl = TextEditingController();
  final _correoCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _obscure = true;
  final RutValidator _rutValidator = RutValidator();
  void _toggleObscure() => setState(() => _obscure = !_obscure);

  Future<void> _onRegister() async {
    final nombre = _nombreCtrl.text.trim();
    final rut = _rutCtrl.text.trim().replaceAll('.', '');
    final correo = _correoCtrl.text.trim();
    final password = _passCtrl.text.trim();

    if (nombre.isEmpty || rut.isEmpty || correo.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor completa todos los campos')),
      );
      return;
    }

    print(RutValidator.Check(rut));
    if (!RutValidator.Check(rut)) {
      ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Rut inválido')),
      );
      return;
    }

    final emailRegex = RegExp( r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");;
    if (!emailRegex.hasMatch(correo)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Correo electrónico inválido')),
      );
      return;
    }

    final notifier = ref.read(registerProvider.notifier);
    await notifier.register(
      correo: correo,
      password: password,
      nombre: nombre,
      rut: rut,
    );

    final state = ref.read(registerProvider);

    state.when(
      data: (_) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Cuenta creada exitosamente')),
          );
          Navigator.pushReplacementNamed(context, '/login');
        }
      },
      error: (err, _) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al registrar: \$err')),
        );
      },
      loading: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loading = ref.watch(registerProvider).isLoading;

    return Scaffold(
      body: Column(
        children: [
          const AuthHeader(title: 'Registro'),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 32),
                    AuthTextField(hintText: 'Nombre completo', controller: _nombreCtrl,icon: Icons.person),
                    const SizedBox(height: 16),
                    AuthTextField(hintText: 'RUT', controller: _rutCtrl,icon: Icons.badge),
                    const SizedBox(height: 16),
                    AuthTextField(hintText: 'Correo electrónico', controller: _correoCtrl,icon: Icons.email),
                    const SizedBox(height: 16),
                    AuthTextField(
                      hintText: 'Contraseña',
                      controller: _passCtrl,
                      icon: Icons.lock,
                      obscureText: _obscure,
                      isPassword: true,
                      onToggleVisibility: _toggleObscure,
                    ),
                    
                    const SizedBox(height: 24),
                    AuthSubmitButton(
                      text: 'Registrarse',
                      onPressed: loading ? null : _onRegister,
                      showLoading: loading,
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
                      child: const Text('¿Ya tienes cuenta? Inicia sesión'),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

