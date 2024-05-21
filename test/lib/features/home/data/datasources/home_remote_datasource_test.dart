import 'package:dio/dio.dart';
import 'package:flutter_dropdown_mock/core/error/failures.dart';
import 'package:flutter_dropdown_mock/core/utils/constants.dart';
import 'package:flutter_dropdown_mock/features/home/data/models/place.dart';
import 'package:flutter_dropdown_mock/features/home/data/datasources/home_remote_datasource.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_remote_datasource_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  late HomeRemoteDatasourceImpl datasource;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    datasource = HomeRemoteDatasourceImpl(networkClient: mockDio);
  });

  group('[Test] getAllCountries', () {
    final tCountriesJson = [
      {"id": 1, "value": "Antarctica"},
      {"id": 2, "value": "India"},
    ];
    final tCountries =
        tCountriesJson.map((place) => Place.fromJson(place)).toList();

    test(
        '[Dio][Remote Datasource] should return list of Place when the response code is 200',
        () async {
      when(mockDio.get(any)).thenAnswer(
        (_) async => Response(
          data: tCountriesJson,
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        ),
      );

      final result = await datasource.getAllCountries();

      expect(result, equals(tCountries));
      verify(mockDio.get("${Constants.baseUrl}/${Constants.countries}"));
      verifyNoMoreInteractions(mockDio);
    });

    test(
        '[Dio][Remote Datasource] should throw ServerFailure when the response code is not 200',
        () async {
      when(mockDio.get(any)).thenThrow(DioException(
        requestOptions: RequestOptions(path: ''),
        response: Response(
          statusCode: 404,
          requestOptions: RequestOptions(path: ''),
        ),
      ));
      final call = datasource.getAllCountries();
      expect(() => call, throwsA(isA<ServerFailure>()));
      verify(mockDio.get("${Constants.baseUrl}/${Constants.countries}"));
      verifyNoMoreInteractions(mockDio);
    });
  });

  group('[Test] getStates', () {
    final tStatesJson = [
      {"id": 1, "value": "Maharashtra"},
      {"id": 2, "value": "GOA"},
    ];

    test(
        '[Dio][States] should return a list of Place when getStates is successful',
        () async {
      // [placeId][subpath]
      const placeId = 1;
      when(mockDio.get(any)).thenAnswer(
        (_) async => Response(
          data: tStatesJson,
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        ),
      );

      final result = await datasource.getStates(placeId: placeId);

      expect(result, isA<List<Place>>());
      expect(result.length, 2);
      expect(result[0].id, 1);
      expect(result[0].value, 'Maharashtra');
      verify(mockDio.get(
              "${Constants.baseUrl}/${Constants.countries}/$placeId/${Constants.states}"))
          .called(1);
    });

    test(
        '[Dio][States] should throw ServerFailure when the response code is not 200',
        () async {
      when(mockDio.get(any)).thenThrow(DioException(
        requestOptions: RequestOptions(path: ''),
        response: Response(
          statusCode: 404,
          requestOptions: RequestOptions(path: ''),
        ),
      ));
      final call = datasource.getAllCountries();
      expect(() => call, throwsA(isA<ServerFailure>()));
      verify(mockDio.get("${Constants.baseUrl}/${Constants.countries}"));
      verifyNoMoreInteractions(mockDio);
    });
  });
}
