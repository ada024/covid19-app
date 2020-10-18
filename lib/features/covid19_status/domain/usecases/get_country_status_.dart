import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/cov.dart';
import '../repositories/cov_repository.dart';

@LazySingleton()
class GetCountryStatus implements UseCase<CovStatus, Params> {
  final CovRepository repository;

  GetCountryStatus(this.repository);

  @override
  Future<Either<Failure, CovStatus>> call(Params params) async {
    return await repository.getCountryStatus(params.country);
  }
}

class Params extends Equatable {
  final String country;

  const Params({@required this.country});

  @override
  List<Object> get props => [country];
}
