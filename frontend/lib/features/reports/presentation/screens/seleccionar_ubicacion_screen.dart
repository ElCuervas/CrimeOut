import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../providers/reporte_providers.dart';
import 'package:frontend/features/auth/presentation/providers/userIdProvider.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter/foundation.dart';
import '../widgets/ubicacion_mapa_widget.dart';
import '../widgets/detalles_popup_dialog.dart';

import '../widgets/botones_inferiores_reporte.dart';

class SeleccionarUbicacion extends ConsumerStatefulWidget {
  const SeleccionarUbicacion({super.key});

  @override
  ConsumerState<SeleccionarUbicacion> createState() => _SeleccionarUbicacionState();
}

class _SeleccionarUbicacionState extends ConsumerState<SeleccionarUbicacion> {
  GoogleMapController? _mapController;
  LatLng? _ubicacionUsuario;    // Ubicación actual del dispositivo
  LatLng? _ubicacionSeleccionada; // Ubicación elegida dentro del radio
  final Circle _circle = Circle(
    circleId: CircleId('radio_50m'),
    center: LatLng(0, 0),       // se ajustará al obtener ubicación
    radius: 50,                 // 50 metros
    fillColor: Colors.blue.withOpacity(0.2),
    strokeColor: Colors.blueAccent.withOpacity(0.5),
    strokeWidth: 2,
  );

  @override
  void initState() {
    super.initState();
    _obtenerUbicacionActual();
  }
  late final String modo;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    modo = ModalRoute.of(context)!.settings.arguments as String;
  }

  Future<void> _obtenerUbicacionActual() async {
    // 1) Verificar permisos
    bool servicioActivo = await Geolocator.isLocationServiceEnabled();
    if (!servicioActivo) {
      // Podrías mostrar un diálogo indicando que active la ubicación
      return;
    }

    LocationPermission permiso = await Geolocator.checkPermission();
    if (permiso == LocationPermission.denied) {
      permiso = await Geolocator.requestPermission();
      if (permiso == LocationPermission.deniedForever) {
        // Permiso denegado permanentemente
        return;
      }
    }

    // 2) Obtener posición
    Position pos = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _ubicacionUsuario = LatLng(pos.latitude, pos.longitude);
      // Inicialmente, la posición seleccionada coincide con la del usuario
      _ubicacionSeleccionada = LatLng(pos.latitude, pos.longitude);
    });

    // Actualizamos el provider con la ubicación inicial
    ref.read(ubicacionSeleccionadaProvider.notifier).state =
        [pos.latitude, pos.longitude];
  }

  void _onMapaCreado(GoogleMapController controller) {
    _mapController = controller;
    if (_ubicacionUsuario != null) {
      // Centrar el mapa en la posición del usuario
      _mapController!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: _ubicacionUsuario!, zoom: 17),
        ),
      );
    }
  }

  /// Cada vez que el usuario mueva el marcador, validamos que esté dentro de los 50m.
  void _onMarcadorMovido(LatLng nuevaPos) {
  if (_ubicacionUsuario == null) return;

  final distancia = Geolocator.distanceBetween(
    _ubicacionUsuario!.latitude,
    _ubicacionUsuario!.longitude,
    nuevaPos.latitude,
    nuevaPos.longitude,
  );

  if (modo == 'vecino' || distancia <= 50) {
    setState(() {
      _ubicacionSeleccionada = nuevaPos;
    });
    ref.read(ubicacionSeleccionadaProvider.notifier).state =
        [nuevaPos.latitude, nuevaPos.longitude];
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Debes seleccionar un punto dentro de los 50 metros.')),
    );
  }
}

  /// Abre el popup para agregar detalles e imagen
  Future<void> _mostrarPopupDetalles() async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => DetallesPopupDialog(), // sin const
    );
}

  /// Envía el reporte al backend (invoca al provider FutureProvider)
  void _enviarReporte() async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    try {
      // Crear el reporte
      await ref.read(crearReporteProvider.future);

      ref.invalidate(crearReporteProvider);
      // Forzar recarga del mapa al volver
      ref.invalidate(reportesMapaProvider);
      ref.invalidate(tipoReporteSeleccionadoProvider);
      ref.invalidate(detallesReporteProvider);
      ref.invalidate(imagenReporteProvider);
      ref.invalidate(ubicacionSeleccionadaProvider);


      Navigator.pushNamedAndRemoveUntil(
          context,
          '/reporte-mapa',
              (route) => false,
      );

      // Mostrar confirmación (opcional)
      scaffoldMessenger.showSnackBar(
        const SnackBar(content: Text('Reporte enviado con éxito')),
      );

    } catch (e) {
      // Mostrar error si algo falla
      scaffoldMessenger.showSnackBar(
        SnackBar(content: Text('Error al enviar reporte: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Mientras no tengamos la ubicación del usuario, mostramos loading
    if (_ubicacionUsuario == null || _ubicacionSeleccionada == null) {
      return Scaffold(
        appBar: AppBar(title: Text('Selecciona Ubicación')),
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      body: Stack(
        children: [
          UbicacionMapaWidget(
            ubicacionUsuario: _ubicacionUsuario!,
            ubicacionSeleccionada: _ubicacionSeleccionada!,
            onDragEnd: _onMarcadorMovido,
            onMapCreated: _onMapaCreado,
          ),

          // Botón “Agregar Detalles” (parte inferior, texto oscuro + ícono)
            BotonesInferioresReporte(
            onAgregarDetalles: _mostrarPopupDetalles,
            onEnviarReporte: _enviarReporte,
          ),
        ],
      ),

      // Barra inferior (mismo estilo que en las otras vistas)
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, // Ajusta según cómo manejes navegación
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.place), label: "Reportar"),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "Historial"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Perfil"),
        ],
        onTap: (index) {
          //– Navegación a otras vistas (historial, perfil, etc.)
        },
      ),
    );
  }
}