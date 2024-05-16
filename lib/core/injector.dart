import 'package:dio/dio.dart';
import 'package:flutter_dropdown_mock/features/home/presentation/cubit/home_cubit.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(
    () => HomeCubit(),
  );

  sl.registerFactory(
    () => Dio(),
  );
}
