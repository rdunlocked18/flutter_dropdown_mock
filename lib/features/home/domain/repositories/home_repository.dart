import 'package:flutter_dropdown_mock/core/error/failures.dart';
import 'package:flutter_dropdown_mock/features/home/data/models/place.dart';
import 'package:dartz/dartz.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<Place>>> getCountries();
  Future<Either<Failure, List<Place>>> getStates({required int placeId});
}
