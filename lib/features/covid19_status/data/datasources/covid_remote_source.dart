import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

import '../../../../core/error/exceptions.dart';
import '../models/cov_model.dart';

abstract class CovidRemoteSrc {

  Future<CovModel> getCountryStatus(String country);
  Future<CovModel> getWorldStatus();
}

class CovidRemoteDataSourceImpl implements CovidRemoteSrc {
  final http.Client client;

  CovidRemoteDataSourceImpl({@required this.client});

  @override
  Future<CovModel> getCountryStatus(String country) =>
      _getCovidStatusFromApi('http://numbersapi.com/$country');

  @override
  Future<CovModel> getWorldStatus() =>
      _getCovidStatusFromApi('http://numbersapi.com/world');

  Future<CovModel> _getCovidStatusFromApi(String url) async {
    final res = await client.get(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (res.statusCode == 200) {
      return CovModel.fromJson(json.decode(res.body));
    } else {
      throw ServerException();
    }
  }
}
