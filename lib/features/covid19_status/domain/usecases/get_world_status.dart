import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/cov.dart';
import '../repositories/cov_repository.dart';

class GetWorldStatus implements UseCase<Cov, NoParams> {
  final CovRepository repository;

  GetWorldStatus(this.repository);

  @override
  Future<Either<Failure, Cov>> call(NoParams params) async {
    return await repository.getWorldStatus();
  }
}
