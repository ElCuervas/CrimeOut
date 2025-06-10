import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'features/auth/presentation/screens/register_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/features/reports/presentation/screens/reporte_mapa_screen.dart';
import 'package:frontend/features/reports/presentation/screens/seleccionar_reporte_screen.dart';
import 'package:frontend/features/reports/presentation/screens/seleccionar_ubicacion_screen.dart';
import 'package:frontend/features/auth/presentation/screens/login_screen.dart';
import 'package:frontend/features/reports_history/presentation/screens/report_history_screen.dart';
import 'package:frontend/core/utils/jwt_utils.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  // Leer keepSigned y para verificar si se debe mantener los datos almacenados
  await JwtUtils.getKeepSigned().then((value) async {
  print('🔄 guardar secion al inicio de la app: $value');
    if (!value) {
      final storage = FlutterSecureStorage();
      await storage.deleteAll();
    }
  });

  print('✅ API Key cargada: ${dotenv.env['GOOGLE_MAPS_API_KEY']}');

  runApp(const ProviderScope(child: CrimeOutApp()));
}

class CrimeOutApp extends StatelessWidget {
  const CrimeOutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
  debugShowCheckedModeBanner: false,
  title: 'CrimeOut',
  theme: ThemeData(primarySwatch: Colors.deepPurple),
  initialRoute: '/login',
  routes: {
    '/login': (context) => const LoginScreen(),
    '/registro': (context) => const RegisterScreen(),
    '/reporte-mapa': (context) => const ReporteMapaScreen(),
    '/seleccionar-tipo': (context) => const SeleccionarReporteScreen(),
    '/seleccionar-ubicacion': (context) => const SeleccionarUbicacion(),
    '/historial-reportes': (context) =>  HistorialReportesScreen(),
  },
);
  }
}