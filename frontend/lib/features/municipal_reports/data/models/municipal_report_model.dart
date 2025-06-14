import '../../domain/entities/municipal_report.dart';

class ReporteMunicipalModel extends ReporteMunicipal {
  ReporteMunicipalModel({
    required super.idReporte,
    required super.tipoReporte,
    required super.ubicacion,
    required super.fecha,
    required super.imagenUrl,
    required super.detalles,
    required super.confiable,
    required super.solucionado,
  });

  factory ReporteMunicipalModel.fromJson(Map<String, dynamic> json) {
    return ReporteMunicipalModel(
      idReporte: json['idReporte'], // 👈 debe venir desde el backend
      tipoReporte: json['tipoReporte'],
      ubicacion: json['ubicacion'],
      fecha: DateTime.parse(json['fecha']),
      imagenUrl: json['imagenUrl'],
      detalles: json['detalles'],
      confiable: json['confiable'],
      solucionado: json['solucionado'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idReporte': idReporte, // 👈 opcional si se necesita enviar
      'tipoReporte': tipoReporte,
      'ubicacion': ubicacion,
      'fecha': fecha.toIso8601String(),
      'imagenUrl': imagenUrl,
      'detalles': detalles,
      'confiable': confiable,
      'solucionado': solucionado,
    };
  }
}