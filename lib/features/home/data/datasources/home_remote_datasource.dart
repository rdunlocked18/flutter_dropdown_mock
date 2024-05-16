import 'package:flutter_dropdown_mock/features/home/data/models/place.dart';

abstract class HomeRemoteDatasource {
  List<Place> getAllCountries();
  List<Place> getStates({required int placeId});
}

class HomeRemoteDatasourceImpl extends HomeRemoteDatasource {
  @override
  List<Place> getAllCountries() {
    // TODO: implement getAllCountries
    throw UnimplementedError();
  }

  @override
  List<Place> getStates({required int placeId}) {
    // TODO: implement getStates
    throw UnimplementedError();
  }
}
