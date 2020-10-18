import 'dart:convert';
import 'dart:io';

import 'package:covid19_app/env.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/exceptions.dart';
import '../models/cov_model.dart';

abstract class CovidRemoteSrc {
  Future<CovstatusModel> getCountryStatus(String country);

  Future<CovstatusModel> getWorldStatus();
}

@LazySingleton(as: CovidRemoteSrc)
class CovidRemoteDataSourceImpl implements CovidRemoteSrc {
  final http.Client client;
  final baseUrl = EnvConfig.BASE_URL;
  final token = EnvConfig.TOKEN;

  CovidRemoteDataSourceImpl({@required this.client});

  @override
  Future<CovstatusModel> getCountryStatus(String country) => _getCovidStatusFromApi('$baseUrl+country?country=$country');

  @override
  Future<CovstatusModel> getWorldStatus() => _getCovidStatusFromApi(baseUrl+"/world");

  Future<CovstatusModel> _getCovidStatusFromApi(String url) async {



    final res = await client.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (res.statusCode == 200) {
      final dynamic resData = json.decode(res.body);
      return CovstatusModel.fromJson(resData[0]['data']);
    } else {
      throw ServerException();
    }
  }
}
