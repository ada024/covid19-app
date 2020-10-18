import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/cov.dart';
import '../repositories/cov_repository.dart';

@LazySingleton()
class GetWorldStatus implements UseCase<CovStatus, NoParams> {
  final CovRepository repository;

  GetWorldStatus(this.repository);

  @override
  Future<Either<Failure, CovStatus>> call(NoParams params) async {
    return await repository.getWorldStatus();
  }
}
