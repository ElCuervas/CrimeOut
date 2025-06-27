import '../../domain/entities/grafico_reporte.dart';

class GraficoReporteModel extends GraficoReporte {
  GraficoReporteModel({
    required super.microtrafico,
    required super.actividadIlicita,
    required super.maltratoAnimal,
    required super.basural,
  });

  factory GraficoReporteModel.fromJson(Map<String, dynamic> json) {
    return GraficoReporteModel(
      microtrafico: json['microtrafico'] as int,
      actividadIlicita: json['actividad_ilicita'] as int,
      maltratoAnimal: json['maltrato_animal'] as int,
      basural: json['basural'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'microtrafico': microtrafico,
      'actividad ilicita': actividadIlicita,
      'maltrato animal': maltratoAnimal,
      'basural': basural,
    };
  }
}