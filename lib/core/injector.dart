import 'package:dio/dio.dart';
import 'package:flutter_dropdown_mock/core/network/client_interceptor.dart';
import 'package:flutter_dropdown_mock/core/network/network_info.dart';
import 'package:flutter_dropdown_mock/features/home/data/datasources/home_remote_datasource.dart';
import 'package:flutter_dropdown_mock/features/home/data/repositories/home_repository_impl.dart';
import 'package:flutter_dropdown_mock/features/home/domain/repositories/home_repository.dart';
import 'package:flutter_dropdown_mock/features/home/presentation/cubit/home_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(
    () => HomeCubit(homeRepository: sl()),
  );

  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(
      remoteDatasource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<HomeRemoteDatasource>(
    () => HomeRemoteDatasourceImpl(
      networkClient: sl(),
    ),
  );

  sl.registerFactory<NetworkInfo>(
    () => NetworkInfoImpl(sl()),
  );

  sl.registerFactory<InternetConnectionChecker>(
    () => InternetConnectionChecker(),
  );

  sl.registerFactory<Dio>(
    () => Dio()
      ..interceptors.add(
        ClientInterceptor(),
      ),
  );
}
