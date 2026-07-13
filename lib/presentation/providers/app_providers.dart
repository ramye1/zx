import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:masra_al_dokhail/data/datasources/canvas_local_datasource.dart';
import 'package:masra_al_dokhail/data/repositories/canvas_repository_impl.dart';
import 'package:masra_al_dokhail/domain/repositories/canvas_repository.dart';
import 'canvas_provider.dart';
import 'selection_provider.dart';
import 'transform_provider.dart';
import 'history_provider.dart';

final getItProvider = Provider<GetIt>((ref) {
  final getIt = GetIt.instance;

  if (!getIt.isRegistered<CanvasLocalDataSource>()) {
    getIt.registerSingleton<CanvasLocalDataSource>(
      CanvasLocalDataSourceImpl(),
    );
  }

  if (!getIt.isRegistered<CanvasRepository>()) {
    getIt.registerSingleton<CanvasRepository>(
      CanvasRepositoryImpl(
        localDataSource: getIt<CanvasLocalDataSource>(),
      ),
    );
  }

  return getIt;
});

final canvasRepositoryProvider = Provider<CanvasRepository>((ref) {
  final getIt = ref.watch(getItProvider);
  return getIt<CanvasRepository>();
});
