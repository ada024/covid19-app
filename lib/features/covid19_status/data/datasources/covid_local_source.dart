import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';
import '../models/cov_model.dart';

abstract class CovidLocalDataSrc {
  Future<CovstatusModel> getLastData();

  Future<void> cacheData(CovstatusModel dataToCache);
}

const CACHED_DATA = 'CACHED_DATA';

class CovidLocalDataSrceImpl implements CovidLocalDataSrc {
  final SharedPreferences sharPref;

  CovidLocalDataSrceImpl({@required this.sharPref});

  @override
  Future<CovstatusModel> getLastData() {
    final cachedData = sharPref.getString(CACHED_DATA);
    if (cachedData != null){
      return Future.value(CovstatusModel.fromJson(json.decode(cachedData)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheData(CovstatusModel dataToCache) {
    return sharPref.setString(
      CACHED_DATA,
      json.encode(dataToCache.toJson()),
    );
  }
}
