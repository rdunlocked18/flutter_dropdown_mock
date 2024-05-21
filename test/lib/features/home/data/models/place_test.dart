import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_dropdown_mock/features/home/data/models/place.dart';

void main() {
  group('Place Model [Test]', () {
    test('Place should be a subclass of Equatable', () {
      expect(const Place(), isA<Equatable>());
    });

    test('Place.[fromJson] should return a valid model', () {
      final Map<String, dynamic> jsonMap = {
        'id': 1,
        'value': 'Austria',
      };

      final result = Place.fromJson(jsonMap);

      expect(result, isA<Place>());
      expect(result.id, 1);
      expect(result.value, 'Austria');
    });

    test('Place.[toJson] should return a JSON map containing the proper data',
        () {
      const place = Place(id: 1, value: 'Austria');

      final result = place.toJson();

      final expectedJsonMap = {
        'id': 1,
        'value': 'Austria',
      };
      expect(result, expectedJsonMap);
    });

    test('Place props should return the correct list of properties [Equatable]',
        () {
      const place = Place(id: 1, value: 'Austria');

      final result = place.props;

      expect(result, [1, 'Austria']);
    });
  });
}
