import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/usuario_perfil.dart';
import '../../domain/usecases/get_usuario_by_id_usecase.dart';
import '../../data/repositories/usuario_repository_impl.dart';

import 'package:dio/dio.dart';

final getUsuarioByIdProvider = FutureProvider.family<UsuarioPerfil, int>((ref, idUsuario) {
  final dio = Dio(); 
  final repository = UsuarioRepositoryImpl(dio);
  final usecase = GetUsuarioByIdUseCase(repository);

  return usecase.execute(idUsuario);
});