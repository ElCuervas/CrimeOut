import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

import '../../../reports/presentation/providers/reporte_providers.dart';
import '../../../reports/domain/entities/ubicacion_reporte.dart';
import 'package:frontend/core/utils/iconos_reportes.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/core/utils/jwt_utils.dart';
import 'package:frontend/core/global_widgets/popup_info_reportes.dart';

class MunicipalMapaReportesScreen extends ConsumerStatefulWidget {
  const MunicipalMapaReportesScreen({super.key});

  @override
  ConsumerState<MunicipalMapaReportesScreen> createState() => _MunicipalMapaReportesScreenState();
}

class _MunicipalMapaReportesScreenState extends ConsumerState<MunicipalMapaReportesScreen> {
  GoogleMapController? _mapController;
  LatLng? _ubicacionUsuario;
  Map<String, BitmapDescriptor>? _iconos;
  String? _userRole;

  @override
  void initState() {
    super.initState();
    _obtenerUbicacionUsuario();
    _cargarIconos();
    _initUserRole();
  }

  Future<void> _initUserRole() async {
    final role = await JwtUtils.getRol();
    debugPrint('ROL OBTENIDO DESDE JWT: $role');
    if (mounted) {
      setState(() {
        _userRole = role;
      });
    }
  }

  Future<void> _handleLogout(BuildContext context) async {
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
      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
      }
    }
  }

  Future<void> _cargarIconos() async {
    final iconos = await IconosReportes.cargarIconos();
    setState(() {
      _iconos = iconos;
    });
  }

  Future<void> _obtenerUbicacionUsuario() async {
    bool servicioActivo = await Geolocator.isLocationServiceEnabled();
    LocationPermission permiso = await Geolocator.checkPermission();
    if (permiso == LocationPermission.denied) {
      permiso = await Geolocator.requestPermission();
    }
    final pos = await Geolocator.getCurrentPosition();
    final double lat = pos.latitude;
    final double lng = pos.longitude;
    final bounds = LatLngBounds(
      southwest: LatLng(lat - 0.0045, lng - 0.0045),
      northeast: LatLng(lat + 0.0045, lng + 0.0045),
    );
    setState(() {
      _ubicacionUsuario = LatLng(pos.latitude, pos.longitude);
      _limitesMapa = bounds;
    });
  }

  LatLngBounds? _limitesMapa;

  Marker _crearMarkerDesdeReporte(UbicacionReporte r, int index) {
    final position = LatLng(r.ubicacion[0], r.ubicacion[1]);
    final icono = _iconos?[r.tipoReporte] ?? BitmapDescriptor.defaultMarker;

    return Marker(
      markerId: MarkerId('reporte_$index'),
      position: position,
      icon: icono,
      infoWindow: InfoWindow(title: r.tipoReporte, snippet: r.detalles),
    );
  }

  @override
  Widget build(BuildContext context) {
    final reportesAsync = ref.watch(reportesMapaProvider);
    final iconosListos = _iconos != null;

    return Scaffold(
      body: Stack(
        children: [
          if (_ubicacionUsuario == null || !iconosListos)
            const Center(child: CircularProgressIndicator())
          else
            reportesAsync.when(
              data: (reportes) {
                final markers = {
                  Marker(
                    markerId: const MarkerId('usuario'),
                    position: _ubicacionUsuario!,
                    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
                    infoWindow: const InfoWindow(title: 'Tu ubicación'),
                  ),
                  ...reportes.asMap().entries.map(
                        (e) => _crearMarkerDesdeReporte(e.value, e.key),
                      ),
                };

                return GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: _ubicacionUsuario!,
                    zoom: 16,
                  ),
                  cameraTargetBounds: CameraTargetBounds(_limitesMapa),
                  myLocationEnabled: false,
                  myLocationButtonEnabled: false,
                  markers: markers,
                  onMapCreated: (controller) {
                    _mapController = controller;
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Error al cargar reportes: \$e')),
            ),
          
          // Botón de información (sin botones de generar reporte)
          Positioned(
            top: 32,
            right: 16,
            child: FloatingActionButton.small(
              heroTag: 'btnInfo',
              onPressed: () => PopupInfoReportes.mostrar(context),
              child: const Icon(Icons.lightbulb),
            ),
          ),
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        selectedItemColor: const Color(0xFF6B49F6),
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/municipal-reportes');
              break;
            case 1:
              break;
            case 2:
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Sección Perfil no disponible aún')),
              );
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Registros'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Mapa'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
    );
  }
}
