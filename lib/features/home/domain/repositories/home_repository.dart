import 'package:flutter_dropdown_mock/features/home/data/models/place.dart';

abstract class HomeRepository {
  List<Place> getCountries();
  List<Place> getStates({required int placeId});
}
