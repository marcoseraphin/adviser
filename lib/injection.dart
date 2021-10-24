import 'package:adviser/application/advicer/advicer_bloc.dart';
import 'package:adviser/domain/repositories/advicer_repository.dart';
import 'package:adviser/domain/usescases/advicer_usecases.dart';
import 'package:adviser/infrastructure/datasources/advicer_remote_datasource.dart';
import 'package:adviser/infrastructure/datasources/theme_local_datasource.dart';
import 'package:adviser/infrastructure/repositories/advicer_repository_impl.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final serviceLocator = GetIt.instance; // ServiceLocator

Future<void> init() async {
  //! Blocs register
  serviceLocator
      .registerFactory(() => AdvicerBloc(usescases: serviceLocator()));

  /// UseCases
  serviceLocator.registerLazySingleton(
      () => AdvicerUsecases(advicerRepository: serviceLocator()));

  //! Repository

  serviceLocator.registerLazySingleton<AdvicerRepository>(
      () => AdvicerRepositoryImpl(advicerRemoteDatasource: serviceLocator()));

  //! DataSources
  serviceLocator.registerLazySingleton<AdvicerRemoteDatasource>(
      () => AdvicerRemoteDataSourceImpl(client: serviceLocator()));

  serviceLocator.registerLazySingleton<ThemeLocalDatasorce>(
      () => ThemeLocalDatasourceImpl(sharedPreferences: serviceLocator()));

  //! extern
  serviceLocator.registerLazySingleton(() => http.Client());
  final sharedPreferences = await SharedPreferences.getInstance();
  serviceLocator.registerLazySingleton(() => sharedPreferences);
}
