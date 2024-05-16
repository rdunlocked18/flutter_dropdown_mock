import 'package:flutter_dropdown_mock/features/home/data/datasources/home_remote_datasource.dart';
import 'package:flutter_dropdown_mock/features/home/data/models/place.dart';
import 'package:flutter_dropdown_mock/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl extends HomeRepository {
  final HomeRemoteDatasource remoteDatasource;
  HomeRepositoryImpl({required this.remoteDatasource});

  @override
  List<Place> getCountries() {
    // TODO: implement getCountries
    throw UnimplementedError();
  }

  @override
  List<Place> getStates({required int placeId}) {
    // TODO: implement getStates
    throw UnimplementedError();
  }
}
