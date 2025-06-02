import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class IconosReportes {
  static Future<Map<String, BitmapDescriptor>> cargarIconos() async {
    return {
      'ACTIVIDAD_ILICITA': await _cargar('assets/icons/actividad_ilicita.png'),
      'MALTRATO_ANIMAL': await _cargar('assets/icons/maltrato_animal.png'),
      'BASURAL': await _cargar('assets/icons/basural.png'),
      'MICROTRAFICO': await _cargar('assets/icons/microtrafico.png'),
    };
  }

  static Future<BitmapDescriptor> _cargar(String path) async {
    return await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(64, 64)),
      path,
    );
  }
}