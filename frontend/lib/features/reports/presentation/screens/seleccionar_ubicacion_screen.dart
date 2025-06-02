import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../providers/reporte_providers.dart';
import 'package:frontend/screens/providers/userIdProvider.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter/foundation.dart';

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
    print('Intentando mover marcador a: $nuevaPos');
    if (_ubicacionUsuario == null) return;

    final distancia = Geolocator.distanceBetween(
      _ubicacionUsuario!.latitude,
      _ubicacionUsuario!.longitude,
      nuevaPos.latitude,
      nuevaPos.longitude,
    );

    if (distancia <= 50) {
      // Dentro del radio permitido
      setState(() {
        _ubicacionSeleccionada = nuevaPos;
      });
      ref.read(ubicacionSeleccionadaProvider.notifier).state =
          [nuevaPos.latitude, nuevaPos.longitude];
    } else {
      // Fuera del radio: podrías mostrar un SnackBar o mensaje de advertencia
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Debes seleccionar un punto dentro de los 50 metros.')),
      );
    }
  }

  /// Abre el popup para agregar detalles e imagen
  Future<void> _mostrarPopupDetalles() async {
    final TextEditingController _textoController = TextEditingController(
      text: ref.read(detallesReporteProvider) ?? '',
    );

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Consumer(
          builder: (context, ref, child) {
            // Obtenemos el estado actual de la imagen (si ya se cargó)
            final imagenBase64 = ref.watch(imagenReporteProvider);

            return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Añadir Imagen', style: TextStyle(fontWeight: FontWeight.bold)),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    // Botón para seleccionar imagen
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2E2E3E),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      ),
                      onPressed: () async {
                        final picker = ImagePicker();
                        final XFile? foto = await picker.pickImage(source: ImageSource.camera);
                        if (foto != null) {
                          try {
                            final base64Img = await compute(_comprimirYCodificar, foto.path);
                            ref.read(imagenReporteProvider.notifier).state = base64Img;
                          } catch (e) {
                            print('Error al procesar la imagen: $e');
                          }
                        }
                      },
                      icon: const Icon(Icons.image),
                      label: const Text('Añadir Imagen'),
                    ),

                    const SizedBox(height: 20),

                    // Campo de texto para detalles
                    TextField(
                      controller: _textoController,
                      maxLines: 4,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        hintText: 'Describe los detalles del incidente...',
                      ),
                      onChanged: (value) {
                        ref.read(detallesReporteProvider.notifier).state = value;
                      },
                    ),
                  ],
                ),
              ),

              actions: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF6B49F6),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  ),
                  onPressed: () {
                    // Simplemente cerramos el dialog y guardamos los estados
                    Navigator.pop(context);
                  },
                  child: Text('Guardar Detalles'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  /// Envía el reporte al backend (invoca al provider FutureProvider)
  void _enviarReporte() async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    try {
      // Crear el reporte
      await ref.read(crearReporteProvider.future);

      // Forzar recarga del mapa al volver
      ref.invalidate(reportesMapaProvider);

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

    // Creamos el Marker “draggeable” para la ubicación seleccionada
    final Marker marcadorSeleccionable = Marker(
      markerId: MarkerId('marcador_${_ubicacionSeleccionada!.latitude}_${_ubicacionSeleccionada!.longitude}'),
      position: _ubicacionSeleccionada!,
      draggable: true,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      onDragEnd: (nuevaPos) => _onMarcadorMovido(nuevaPos),
    );

    // Creamos el Circle de 50m alrededor de la ubicación del usuario
    final Circle circle50m = _circle.copyWith(
      centerParam: _ubicacionUsuario,
    );

    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _ubicacionUsuario!,
              zoom: 17,
            ),
            onMapCreated: _onMapaCreado,
            markers: {marcadorSeleccionable},
            circles: {circle50m},
            myLocationEnabled: false,
            myLocationButtonEnabled: false,
          ),

          // Botón “Agregar Detalles” (parte inferior, texto oscuro + ícono)
          Positioned(
            bottom: 100,
            left: 16,
            right: 16,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF2E2E3E),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: _mostrarPopupDetalles,
              icon: Icon(Icons.image, color: Colors.white),
              label: Text(
                'Agregar Detalles',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),

          // Botón “Enviar Reporte” (parte inferior, color principal)
          Positioned(
            bottom: 32,
            left: 16,
            right: 16,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF6B49F6),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                padding: EdgeInsets.symmetric(vertical: 20),
              ),
              onPressed: _enviarReporte,
              child: Text(
                'Enviar Reporte',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
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
  Future<String> _comprimirYCodificar(String path) async {
    final compressedBytes = await FlutterImageCompress.compressWithFile(
      path,
      quality: 60,
      format: CompressFormat.jpeg,
    );

    if (compressedBytes == null) throw Exception('Error al comprimir imagen');

    return base64Encode(compressedBytes);
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }
}