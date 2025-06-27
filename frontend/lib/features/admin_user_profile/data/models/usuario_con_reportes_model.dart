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
  print("🔥 JSON roles: ${json['roles']}");
  print("🔥 JSON reportes: ${json['reportes']}");

  final roles = json['roles'] is String
      ? (json['roles'] as String).split(',').map((r) => r.trim()).toList()
      : List<String>.from(json['roles']);

  final reportes = (json['reportes'] as List)
      .map((e) => ReporteUsuarioModel.fromJson(e).toEntity())
      .toList();

  return UsuarioConReportesModel(
    idUsuario: json['idUsuario'],
    nombreUsuario: json['nombreUsuario'],
    roles: roles,
    reportes: reportes,
  );
}
}