import 'package:covid19_app/features/covid19_status/data/models/cov_model.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/cov.dart';
import '../../domain/repositories/cov_repository.dart';
import '../datasources/covid_local_source.dart';
import '../datasources/covid_remote_source.dart';



typedef Future<Cov> _CountryOrWorldStatus();


class CovRepositoryImpl implements CovRepository {
  final CovidRemoteSrc remoteSrc;
  final CovidLocalDataSrc localsrc;
  final NetworkInfo networkInfo;

  CovRepositoryImpl({
    @required this.remoteSrc,
    @required this.localsrc,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, Cov>> getCountryStatus(String country) async {
    return await _getResult(() {
      return remoteSrc.getCountryStatus(country);
    });
  }

  @override
  Future<Either<Failure, Cov>> getWorldStatus() async {
    return await _getResult(() {
      return remoteSrc.getWorldStatus();
    });
  }

  Future<Either<Failure, Cov>> _getResult(_CountryOrWorldStatus countryOrWorldStatus) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteResult = await countryOrWorldStatus();
        localsrc.cacheData(remoteResult);
        return Right(remoteResult);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localData = await localsrc.getLastData();
        return Right(localData);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }



}
