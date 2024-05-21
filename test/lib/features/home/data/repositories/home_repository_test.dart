import 'package:dartz/dartz.dart';
import 'package:flutter_dropdown_mock/core/error/failures.dart';
import 'package:flutter_dropdown_mock/core/network/network_info.dart';
import 'package:flutter_dropdown_mock/features/home/data/datasources/home_remote_datasource.dart';
import 'package:flutter_dropdown_mock/features/home/data/models/place.dart';
import 'package:flutter_dropdown_mock/features/home/data/repositories/home_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockHomeRemoteDatasource extends Mock implements HomeRemoteDatasource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late HomeRepositoryImpl repository;
  late MockHomeRemoteDatasource mockRemoteDatasource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDatasource = MockHomeRemoteDatasource();
    mockNetworkInfo = MockNetworkInfo();
    repository = HomeRepositoryImpl(
      remoteDatasource: mockRemoteDatasource,
      networkInfo: mockNetworkInfo,
    );
  });

  group('getCountries', () {
    final countries = [
      const Place(id: 1, value: 'Austria'),
      const Place(id: 2, value: 'United States Of America')
    ];

    test('should check if the device is online', () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockRemoteDatasource.getAllCountries())
          .thenAnswer((_) async => countries);

      await repository.getCountries();

      verify(() => mockNetworkInfo.isConnected).called(1);
    });

    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockRemoteDatasource.getAllCountries())
          .thenAnswer((_) async => countries);

      final result = await repository.getCountries();

      verify(() => mockRemoteDatasource.getAllCountries()).called(1);
      expect(result, equals(Right(countries)));
    });

    test(
        'should return ServerFailure when the call to remote data source is unsuccessful',
        () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockRemoteDatasource.getAllCountries())
          .thenThrow(Exception('Server error'));

      final result = await repository.getCountries();

      verify(() => mockRemoteDatasource.getAllCountries()).called(1);
      expect(result,
          equals(const Left(ServerFailure('Error : Exception: Server error'))));
    });

    test('should return ServerFailure when the device is offline', () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      final result = await repository.getCountries();

      expect(result,
          equals(const Left(ServerFailure("Please Connect to Internet"))));
    });
  });

  group('getStates', () {
    final states = [
      const Place(id: 1, value: 'Maharashtra'),
      const Place(id: 2, value: 'GOA')
    ];
    const placeId = 1;

    test('should check if the device is online', () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockRemoteDatasource.getStates(placeId: placeId))
          .thenAnswer((_) async => states);

      await repository.getStates(placeId: placeId);

      verify(() => mockNetworkInfo.isConnected).called(1);
    });

    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockRemoteDatasource.getStates(placeId: placeId))
          .thenAnswer((_) async => states);

      final result = await repository.getStates(placeId: placeId);

      verify(() => mockRemoteDatasource.getStates(placeId: placeId)).called(1);
      expect(result, equals(Right(states)));
    });

    test(
        'should return ServerFailure when the call to remote data source is unsuccessful',
        () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockRemoteDatasource.getStates(placeId: placeId))
          .thenThrow(Exception('Server error'));

      final result = await repository.getStates(placeId: placeId);

      verify(() => mockRemoteDatasource.getStates(placeId: placeId)).called(1);
      expect(result,
          equals(const Left(ServerFailure('Error : Exception: Server error'))));
    });

    test('should return ServerFailure when the device is offline', () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      final result = await repository.getStates(placeId: placeId);

      expect(result,
          equals(const Left(ServerFailure("Please Connect to Internet"))));
    });
  });
}
