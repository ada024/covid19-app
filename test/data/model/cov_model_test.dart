import 'dart:convert';

import 'package:covid19_app/features/covid19_status/data/models/cov_model.dart';
import 'package:covid19_app/features/covid19_status/domain/entities/cov.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../test/fictive/fictive_loader.dart';

void main() {
  final tCovStatusModel = CovstatusModel (active: "320",confirmed: "150",deaths: "7",recovered: "180");

  test(
    'should be a subclass of CovStatus entity',
        () async {
      // assert
      expect(tCovStatusModel, isA<CovStatus>());
    },
  );

  group('fromJson', () {
    test(
      'should return a valid model for world status',
          () async {
        // arrange
        final Map<String, dynamic> jsonMap =
        json.decode(fictive("cov_status_world.json"));
        // act
        final result = tCovStatusModel.fromJson(jsonMap);
        // assert
        expect(result, tCovStatusModel);
      },
    );
  });

  group('toJson', () {
    test(
      'should return a JSON map with the right data',
          () async {
        // act
        final res = tCovStatusModel.toJson();
        // assert
        final expectedRes = {
          "confirmed": "405",
          "deaths": "23",
          "recovered": "200",
          "active": "102"
        };
        expect(res, expectedRes);
      },
    );
  });
}
