import 'package:dio/dio.dart';
import 'package:flutter_dropdown_mock/core/error/failures.dart';
import 'package:flutter_dropdown_mock/core/utils/constants.dart';
import 'package:flutter_dropdown_mock/features/home/data/models/place.dart';

abstract class HomeRemoteDatasource {
  Future<List<Place>> getAllCountries();
  Future<List<Place>> getStates({required int placeId});
}

class HomeRemoteDatasourceImpl extends HomeRemoteDatasource {
  final Dio networkClient;

  HomeRemoteDatasourceImpl({required this.networkClient});

  @override
  Future<List<Place>> getAllCountries() async {
    try {
      var response = await networkClient.get(
        "${Constants.baseUrl}/${Constants.countries}",
      );
      List data = response.data;
      List<Place> actu =
          data.map((element) => Place.fromJson(element)).toList();
      return actu;
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<List<Place>> getStates({required int placeId}) async {
    // TODO: implement getStates
    throw UnimplementedError();
  }
}
