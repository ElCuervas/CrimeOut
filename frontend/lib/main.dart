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
import 'package:frontend/features/municipal_reports/presentation/screens/municipal_report_list_screen.dart';
import 'package:frontend/features/municipal_reports/presentation/screens/municipal_home_screen.dart';
import 'package:frontend/features/grafico_reportes/presentation/screens/municipal_grafico_screen.dart';
import 'package:frontend/features/admin_landing/presentation/screens/admin_home_screen.dart';
import 'package:frontend/features/crear_municipal/presentation/screens/crear_cuenta_municipal_screen.dart';
import 'package:frontend/features/admin_reportes/presentation/screens/admin_reportes_sospechosos_screen.dart';
import 'package:frontend/features/municipal_reports/presentation/screens/municipal_mapa_reportes_screen.dart';
import 'package:frontend/features/perfil/presentation/screens/perfil_usuario_municipal_screen.dart';
import 'package:intl/date_symbol_data_local.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('es');
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
    '/lista-reportes-municipal': (context) =>  MunicipalListaReportesScreen(),
    '/municipal-reportes': (context) => const MunicipalHomeScreen(),
    '/municipal-grafico': (context) => const MunicipalGraficoScreen(),
    '/reporte-mapa-municipal': (context) => const MunicipalMapaReportesScreen(),
    '/admin-home': (context) => const AdminHomeScreen(),
    '/admin-create-municipal': (context) => const CrearCuentaMunicipalScreen(),
    '/admin-reportes': (context) => const AdminReportesSospechososScreen(),
    '/perfil-usuario-municipal': (context) => const PerfilUsuarioMunicipalScreen(),
  },
);
  }
}