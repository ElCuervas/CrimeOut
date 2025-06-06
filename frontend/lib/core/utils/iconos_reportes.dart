import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// Clase utilitaria para cargar íconos personalizados para marcadores en Google Maps.
/// Los íconos representan diferentes tipos de reportes (actividad ilícita, maltrato animal, etc.)
class IconosReportes {
  /// Carga un conjunto de íconos desde los assets y los asocia con una clave identificadora.
  ///
  /// Devuelve un [Future] que contiene un [Map] con las claves de tipo de reporte
  /// y sus respectivos [BitmapDescriptor] que pueden ser utilizados como iconos de marcador.
  ///
  /// Ejemplo de uso:
  /// ```dart
  /// final iconos = await IconosReportes.cargarIconos();
  /// final iconoBasural = iconos['BASURAL'];
  /// ```
  static Future<Map<String, BitmapDescriptor>> cargarIconos() async {
    return {
      'ACTIVIDAD_ILICITA': await _cargar('icons/actividad_ilicita.png'),
      'MALTRATO_ANIMAL': await _cargar('icons/maltrato_animal.png'),
      'BASURAL': await _cargar('icons/basural.png'),
      'MICROTRAFICO': await _cargar('icons/microtrafico.png'),
    };
  }

  /// Carga un ícono desde los assets como un [BitmapDescriptor] que puede ser usado en Google Maps.
  ///
  /// [path] es la ruta relativa del asset de imagen dentro del proyecto.
  ///
  /// Retorna un [Future] que contiene el [BitmapDescriptor] correspondiente.
  static Future<BitmapDescriptor> _cargar(String path) async {
    return await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(256, 256)),
      path,
    );
  }

  static Future<Map<String, AssetImage>> cargarIconosUI() async {
  final tipos = ['ACTIVIDAD_ILICITA', 'MALTRATO_ANIMAL', 'BASURAL', 'MICROTRAFICO'];
  return {
    for (final tipo in tipos)
      tipo: AssetImage('icons/${tipo.toLowerCase()}.png'),
  };
}
}