import '../../domain/entities/reporte_sospechoso.dart';

class ReporteSospechosoModel extends ReporteSospechoso {
  ReporteSospechosoModel({
    required int idUsuario,
    required String tipoReporte,
    required String imagenUrl,
    required String detalles,
  }) : super(
          idUsuario: idUsuario,
          tipoReporte: tipoReporte,
          imagenUrl: imagenUrl,
          detalles: detalles,
        );

  factory ReporteSospechosoModel.fromJson(Map<String, dynamic> json) {
    return ReporteSospechosoModel(
      idUsuario: json['id_usuario'],
      tipoReporte: json['tipoReporte'],
      imagenUrl: json['imagenUrl'],
      detalles: json['detalles'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_usuario': idUsuario,
      'tipoReporte': tipoReporte,
      'imagenUrl': imagenUrl,
      'detalles': detalles,
    };
  }

  factory ReporteSospechosoModel.fromEntity(ReporteSospechoso entity) {
    return ReporteSospechosoModel(
      idUsuario: entity.idUsuario,
      tipoReporte: entity.tipoReporte,
      imagenUrl: entity.imagenUrl,
      detalles: entity.detalles,
    );
  }
}