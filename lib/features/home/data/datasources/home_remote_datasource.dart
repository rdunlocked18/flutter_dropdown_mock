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

  /// [getAllCountries]
  /// uses networkClient current : [Dio]
  /// GET API call to get response of AllCountries
  @override
  Future<List<Place>> getAllCountries() async {
    try {
      var response = await networkClient.get(
        "${Constants.baseUrl}/${Constants.countries}",
      );
      List placesList = response.data;
      List<Place> result = placesList
          .map(
            (place) => Place.fromJson(place),
          )
          .toList();
      return result;
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  /// [getStates]
  /// uses networkClient current : [Dio]
  /// GET API call to get response of all states for one [countryId]/[placeId]
  @override
  Future<List<Place>> getStates({required int placeId}) async {
    try {
      var response = await networkClient.get(
        "${Constants.baseUrl}/${Constants.countries}/$placeId/${Constants.states}",
      );
      List placesList = response.data;
      List<Place> result = placesList
          .map(
            (place) => Place.fromJson(place),
          )
          .toList();
      return result;
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }
}
