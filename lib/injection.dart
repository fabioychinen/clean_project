import 'package:clean_project/application/pages/advicer/cubit/advicer_cubit.dart';
import 'package:clean_project/data/data_sources/advice_remote_datasource.dart';
import 'package:clean_project/data/repositories/advice_repo_impl.dart';
import 'package:clean_project/domain/repositories/advice_repo.dart';
import 'package:clean_project/domain/usecases/advicer_usecases.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.I;

Future<void> init() async {
  //! Application layer
  sl.registerFactory(() => AdvicerCubit(adviceUseCases: sl()));
//! Domain layer

  sl.registerFactory(() => AdvicerUseCases(adviceRepo: sl()));

  //! Data layer
  sl.registerFactory<AdviceRepo>(
      () => AdviceRepoImpl(adviceRemoteDatasource: sl()));
  sl.registerFactory<AdviceRemoteDatasource>(
      () => AdviceRemoteDatasourceImpl(client: sl()));
  //! Externs
  sl.registerFactory(() => http.Client());
}
