import 'package:dio/dio.dart';
import '../../domain/entities/usuario_con_reportes.dart';
import '../../domain/repositories/usuario_con_reportes_repository.dart';
import '../models/usuario_con_reportes_model.dart';

class UsuarioConReportesRepositoryImpl implements UsuarioConReportesRepository {
  final Dio dio;

  UsuarioConReportesRepositoryImpl(this.dio);

  @override
  Future<UsuarioConReportes> fetchUsuarioConReportes(int id) async {
    try {
      final res = await dio.get('/api/v1/crimeout/list/user/$id/reportes');
      return UsuarioConReportesModel.fromJson(res.data);
    } on DioError catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Error al cargar usuario');
    }
  }

  @override
  Future<void> eliminarUsuario(int id) async {
    try {
      final res = await dio.delete('/api/v1/crimeout/user/$id');
      if (res.statusCode != 201) {
        throw Exception('No se pudo eliminar el usuario');
      }
    } on DioError catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Error al eliminar usuario');
    }
  }
}