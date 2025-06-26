import '../../domain/entities/reporte_usuario.dart';

class ReporteUsuarioModel extends ReporteUsuario {
  ReporteUsuarioModel({
    required super.tipoReporte,
    required super.ubicacion,
    required super.fecha,
    required super.imagenUrl,
    required super.detalles,
    required super.confiable,
    required super.solucionado,
  });

  factory ReporteUsuarioModel.fromJson(Map<String, dynamic> json) {
    return ReporteUsuarioModel(
      tipoReporte: json['tipoReporte'],
      ubicacion: json['ubicacion'],
      fecha: DateTime.parse(json['fecha']),
      imagenUrl: json['imagenUrl'],
      detalles: json['detalles'],
      confiable: json['confiable'],
      solucionado: json['solucionado'],
    );
  }

  ReporteUsuario toEntity() {
    return ReporteUsuario(
      tipoReporte: tipoReporte,
      ubicacion: ubicacion,
      fecha: fecha,
      imagenUrl: imagenUrl,
      detalles: detalles,
      confiable: confiable,
      solucionado: solucionado,
    );
  }
}