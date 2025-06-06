import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/auth_models.dart';
import '../providers/login_provider.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/auth_submit_button.dart';
import '../widgets/auth_header.dart';
import 'package:frontend/core/utils/jwt_utils.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static const routeName = '/login';
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _rutCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _obscure = true;
  bool _keepSigned = false;

  @override
  void initState() {
    super.initState();
  }

  void _toggleObscure() => setState(() => _obscure = !_obscure);
  void _toggleKeepSigned(bool? v) => setState(() => _keepSigned = v ?? false);

  Future<void> _handleLogin() async {
    final rut = _rutCtrl.text.trim();
    final pass = _passCtrl.text.trim();

    if (rut.isEmpty || pass.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('RUT y contraseña son obligatorios')),
      );
      return;
    }

    await ref.read(loginProvider.notifier).login(
          rut: rut,
          contrasena: pass,
        );
  }

  @override
Widget build(BuildContext context) {
  final theme = Theme.of(context);
  final loginState = ref.watch(loginProvider);
  final isLoading = loginState is AsyncLoading;

  // ✅ Ejecuta después del primer frame (seguro para Navigator y SnackBar)
  WidgetsBinding.instance.addPostFrameCallback((_) async {
    loginState.whenOrNull(
      data: (_) async {
        final rol = await JwtUtils.getRol();

        if (!context.mounted) return;

        switch (rol.toUpperCase()) {
          case 'USUARIO':
          case 'JEFE_VECINAL':
            Navigator.pushReplacementNamed(context, '/reporte-mapa');
            break;
          case 'MUNICIPAL':
            Navigator.pushReplacementNamed(context, '/vista-policia');
            break;
          case 'ADMIN':
            Navigator.pushReplacementNamed(context, '/vista-admin');
            break;
          default:
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Rol desconocido: $rol')),
            );
        }
      },
      error: (err, _) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al iniciar sesión: $err')),
        );
      },
    );
  });

    return Scaffold(
      body: Column(
        children: [
          const AuthHeader(title: 'Inicio Sesión'),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 32),
                    AuthTextField(
                      hintText: 'RUT',
                      controller: _rutCtrl,
                      icon: Icons.person
                    ),
                    const SizedBox(height: 24),
                    AuthTextField(
                      hintText: 'Contraseña',
                      controller: _passCtrl,
                      icon: Icons.lock,
                      obscureText: _obscure,
                      isPassword: true,
                      onToggleVisibility: _toggleObscure,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Checkbox(
                          value: _keepSigned,
                          onChanged: _toggleKeepSigned,
                        ),
                        const Text('No Cerrar Sesión'),
                        const Spacer(),
                        
                      ],
                    ),
                    const SizedBox(height: 24),
                    AuthSubmitButton(
                      text: 'Iniciar sesión',
                      onPressed: isLoading ? null : _handleLogin,
                      showLoading: isLoading,
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/registro');
                        },
                        child: const Text('¿No tienes cuenta? Regístrate'),
                      ),
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

