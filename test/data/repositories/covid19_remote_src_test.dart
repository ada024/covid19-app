import 'dart:convert';
import 'package:covid19_app/core/error/exceptions.dart';
import 'package:covid19_app/features/covid19_status/data/datasources/covid_remote_source.dart';
import 'package:covid19_app/features/covid19_status/data/models/cov_model.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';
import 'package:http/http.dart' as http;

import '../../fictive/fictive_loader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  CovidRemoteDataSourceImpl remoteSrc;
  MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    remoteSrc = CovidRemoteDataSourceImpl(client: mockHttpClient);
  });

  void setUpMockHttpClientSuccess200() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(fictive('cov_status_world.json'), 200));
  }

  void setUpMockHttpClientFailure404() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Resource not found', 404));
  }

  group('getCountryStatus', () {
    final tCountry = "NOR";
    final tCovStatusModel =
    CovstatusModel.fromJson(json.decode(fictive('cov_status_country.json')));

    test(
      '''should perform a GET request on a URL with country NOR
       being the endpoint and with application/json header''',
          () async {
        // arrange
        setUpMockHttpClientSuccess200();
        // act
        remoteSrc.getCountryStatus(tCountry);
        // assert
        verify(mockHttpClient.get(
          '{API.baseUrl}+/country/+$tCountry',
          headers: {
            'Content-Type': 'application/json',
          },
        ));
      },
    );

    test(
      'should return country status when the code is 200 OK',
          () async {
        // arrange
        setUpMockHttpClientSuccess200();
        // act
        final result = await remoteSrc.getCountryStatus(tCountry);
        // assert
        expect(result, equals(tCovStatusModel));
      },
    );

    test(
      'should throw a ServerException when the code is 404 or other',
          () async {
        // arrange
        setUpMockHttpClientFailure404();
        // act
        final call = remoteSrc.getCountryStatus;
        // assert
        expect(() => call(tCountry), throwsA(const TypeMatcher<ServerException>()));
      },
    );
  });

  group('getWorldStatus', () {
    final tCovStatusModel = CovstatusModel.fromJson(fictive('cov_status_world.json'));

    test(
      '''should perform a GET request on endpoint world
       being the endpoint and with application/json header''',
          () async {
        // arrange
        setUpMockHttpClientSuccess200();
        // act
        remoteSrc.getWorldStatus();
        // assert
        verify(mockHttpClient.get(
          '{API.baseUrl}+/world',
          headers: {
            'Content-Type': 'application/json',
          },
        ));
      },
    );

    test(
      'should return World-status when the code is 200 OK',
          () async {
        // arrange
        setUpMockHttpClientSuccess200();
        // act
        final res = await remoteSrc.getWorldStatus();
        // assert
        expect(res, equals(tCovStatusModel));
      },
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
          () async {
        // arrange
        setUpMockHttpClientFailure404();
        // act
        final call = remoteSrc.getWorldStatus();
        // assert
        expect(() => call(), throwsA(const TypeMatcher<ServerException>()));
      },
    );
  });
}
