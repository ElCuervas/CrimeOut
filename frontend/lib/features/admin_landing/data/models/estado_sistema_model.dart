import '../../domain/entities/estado_sistema.dart';

class EstadoSistemaModel extends EstadoSistema {
  EstadoSistemaModel({
    required super.totalUsuarios,
    required super.totalReportes,
    required super.reportesSospechosos,
  });

  factory EstadoSistemaModel.fromJson(Map<String, dynamic> json) {
    return EstadoSistemaModel(
      totalUsuarios: json['total_usuarios'],
      totalReportes: json['total_reportes'],
      reportesSospechosos: json['reportes_sospechosos'],
    );
  }
}