import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:covid19_app/core/error/failures.dart';
import 'package:covid19_app/core/usecases/usecase.dart';
import 'package:covid19_app/features/covid19_status/domain/entities/cov.dart';
import 'package:covid19_app/features/covid19_status/domain/usecases/get_country_status_.dart';
import 'package:covid19_app/features/covid19_status/domain/usecases/get_world_status.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import './bloc.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String ACCESS_DENIED_MESSAGE = 'Access denied';
const String CACHE_FAILURE_MESSAGE = 'Cache Error';

@injectable
class CovBloc extends Bloc<CovEvent, CovState> {
  final GetCountryStatus getCountryStatus;
  final GetWorldStatus getWorldStatus;

  CovBloc({
    @required GetCountryStatus countryStatus,
    @required GetWorldStatus worldStatus,})  : assert(countryStatus != null),
        assert(worldStatus != null),
        getCountryStatus = countryStatus,
        getWorldStatus = worldStatus, super( Loading());



  @override
  Stream<CovState> mapEventToState(CovEvent event,) async* {
    if (event is GetStatusForCountry) {
          yield Loading();
          final errorOrStatus = await getCountryStatus(Params(country: event.country));
          yield* _eitherLoadedOrErrorState(errorOrStatus);
    } else if (event is GetStatusForWorld) {
      yield Loading();
      final errorOrStatus = await getWorldStatus(NoParams());
      yield* _eitherLoadedOrErrorState(errorOrStatus);
    }
  }

  Stream<CovState> _eitherLoadedOrErrorState(
    Either<Failure, CovStatus> failureOrStatus,
  ) async* {
    yield failureOrStatus.fold(
      (failure) => Error(message: _mapFailureToMessage(failure)),
      (status) => Loaded(cov: status),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
        case AccessDeniedFailure:
        return ACCESS_DENIED_MESSAGE;
      default:
        return 'Something unexpected happened d:0|';
    }
  }
}
