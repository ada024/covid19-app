import 'package:covid19_app/features/covid19_status/data/models/cov_model.dart';
import 'package:covid19_app/features/covid19_status/domain/entities/cov.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

abstract class CovRepository {
  Future<Either<Failure, Cov>> getCountryStatus(String country);
  Future<Either<Failure, Cov>> getWorldStatus();
}
