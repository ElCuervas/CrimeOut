import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _rutCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _obscure = true;
  bool _keepSigned = false;
  final bool _loading = false;
  String? _error;

  void _toggleObscure() => setState(() => _obscure = !_obscure);
  void _toggleKeepSigned(bool? v) => setState(() => _keepSigned = v ?? false);

  Future<void> _onLogin() async {
    
  }

  @override
  Widget build(BuildContext c) {
    final theme = Theme.of(c);
    return Scaffold(
      body: Column(
        children: [
          // Header curvo
          ClipPath(
            clipper: _WaveClipper(),
            child: Container(
              height: 250,
              color: theme.colorScheme.primary,
            ),
          ),

          // Contenido
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Inicio Sesión', style: theme.textTheme.headlineSmall),
                    const SizedBox(height: 32),

                    // RUT
                    TextField(
                      controller: _rutCtrl,
                      decoration: InputDecoration(
                        labelText: 'RUT',
                        prefixIcon: const Icon(Icons.account_circle),
                        border: const UnderlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Contraseña
                    TextField(
                      controller: _passCtrl,
                      obscureText: _obscure,
                      decoration: InputDecoration(
                        labelText: 'Contraseña',
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          icon: Icon(
                              _obscure ? Icons.visibility_off : Icons.visibility),
                          onPressed: _toggleObscure,
                        ),
                        border: const UnderlineInputBorder(),
                      ),
                    ),

                    const SizedBox(height: 16),
                    if (_error != null)
                      Text(_error!, style: const TextStyle(color: Colors.red)),
                    const SizedBox(height: 8),

                    // Opciones
                    Row(
                      children: [
                        Checkbox(
                          value: _keepSigned,
                          onChanged: _toggleKeepSigned,
                        ),
                        const Text('No Cerrar Sesión'),
                        const Spacer(),
                        TextButton(
                          onPressed: () {/* TODO: olvido */},
                          child: const Text('¿Olvidaste tu contraseña?'),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Botón principal
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _loading ? null : _onLogin,
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        child: _loading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : const Text('Inicia Sesión'),
                      ),
                    ),

                    const SizedBox(height: 16),
                    Center(
                      child: TextButton(
                        onPressed: () {/* TODO: registro */},
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


class _WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final p = Path()..lineTo(0, size.height - 60);
    p.quadraticBezierTo(
      size.width * 0.25, size.height,
      size.width * 0.5, size.height,
    );
    p.quadraticBezierTo(
      size.width * 0.75, size.height,
      size.width, size.height - 60,
    );
    p.lineTo(size.width, 0);
    return p..close();
  }

  @override
  bool shouldReclip(CustomClipper<Path> old) => false;
}