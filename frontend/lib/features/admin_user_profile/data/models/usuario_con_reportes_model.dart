import '../../domain/entities/usuario_con_reportes.dart';
import 'reporte_usuario_model.dart';

class UsuarioConReportesModel extends UsuarioConReportes {
  UsuarioConReportesModel({
    required super.idUsuario,
    required super.nombreUsuario,
    required super.roles,
    required super.reportes,
  });

  factory UsuarioConReportesModel.fromJson(Map<String, dynamic> json) {
    return UsuarioConReportesModel(
      idUsuario: json['idUsuario'],
      nombreUsuario: json['nombreUsuario'],
      roles: List<String>.from(json['roles']),
      reportes: (json['reportes'] as List)
          .map((e) => ReporteUsuarioModel.fromJson(e).toEntity())
          .toList(),
    );
  }
}