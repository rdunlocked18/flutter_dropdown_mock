import 'package:dartz/dartz.dart';
import 'package:flutter_dropdown_mock/core/error/failures.dart';
import 'package:flutter_dropdown_mock/core/network/network_info.dart';
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

  @override
  Future<Either<Failure, List<Place>>> getCountries() async {
    try {
      var result = await remoteDatasource.getAllCountries();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure('Error : $e'));
    }
  }

  @override
  Future<Either<Failure, List<Place>>> getStates({required int placeId}) {
    // TODO: implement getStates
    throw UnimplementedError();
  }
}
