import 'package:dartz/dartz.dart';
import 'package:flutter_dropdown_mock/core/error/failures.dart';
import 'package:flutter_dropdown_mock/core/network/network_info.dart';
import 'package:flutter_dropdown_mock/core/utils/constants.dart';
import 'package:flutter_dropdown_mock/features/home/data/datasources/home_remote_datasource.dart';
import 'package:flutter_dropdown_mock/features/home/data/models/place.dart';
import 'package:flutter_dropdown_mock/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl extends HomeRepository {
  final HomeRemoteDatasource remoteDatasource;
  final NetworkInfo networkInfo;

  HomeRepositoryImpl({
    required this.remoteDatasource,
    required this.networkInfo,
  });

  /// [getCountries]
  /// checks network connection
  /// if network.IsConnected calls remoteDatasource to get all countries
  /// otherwise throws [ServerFailure]/[DioException]
  @override
  Future<Either<Failure, List<Place>>> getCountries() async {
    if (await networkInfo.isConnected) {
      try {
        var result = await remoteDatasource.getAllCountries();
        return Right(result);
      } catch (e) {
        return Left(ServerFailure('Error : $e'));
      }
    } else {
      return const Left(ServerFailure(Constants.pleaseConnectToInternet));
    }
  }

  /// [getStates]
  /// checks network connection
  /// if network.IsConnected calls remoteDatasource to get states for [placeId]
  /// otherwise throws [ServerFailure]/[DioException]
  @override
  Future<Either<Failure, List<Place>>> getStates({required int placeId}) async {
    if (await networkInfo.isConnected) {
      try {
        var result = await remoteDatasource.getStates(placeId: placeId);
        return Right(result);
      } catch (e) {
        return Left(ServerFailure('Error : $e'));
      }
    } else {
      return const Left(ServerFailure(Constants.pleaseConnectToInternet));
    }
  }
}
