import 'package:dio/dio.dart';
import '../../domain/entities/reporte_usuario.dart';
import '../../domain/repositories/usuario_reportes_repository.dart';
import '../models/reporte_usuario_model.dart';

class UsuarioReportesRepositoryImpl implements UsuarioReportesRepository {
  final Dio dio;

  UsuarioReportesRepositoryImpl(this.dio);

  @override
  Future<ReporteUsuario> getReportesDeUsuario(int idUsuario) async {
    try {
      final response = await dio.get('/api/v1/crimeout/list/user/$idUsuario/reportes');
      return ReporteUsuarioModel.fromJson(response.data);
    } on DioError catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Error al obtener reportes del usuario');
    }
  }
}