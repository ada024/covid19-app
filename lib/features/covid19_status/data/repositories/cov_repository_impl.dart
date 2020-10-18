import 'package:covid19_app/features/covid19_status/data/models/cov_model.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/network.dart';
import '../../domain/entities/cov.dart';
import '../../domain/repositories/cov_repository.dart';
import '../datasources/covid_local_source.dart';
import '../datasources/covid_remote_source.dart';



typedef Future<CovStatus> _CountryOrWorldStatus();

@LazySingleton(as: CovRepository)
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
  Future<Either<Failure, CovStatus>> getCountryStatus(String country) async {
    return await _getResult(() {
      return remoteSrc.getCountryStatus(country);
    });
  }

  @override
  Future<Either<Failure, CovStatus>> getWorldStatus() async {
    return await _getResult(() {
      return remoteSrc.getWorldStatus();
    });
  }

  Future<Either<Failure, CovStatus>> _getResult(_CountryOrWorldStatus countryOrWorldStatus) async {
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
