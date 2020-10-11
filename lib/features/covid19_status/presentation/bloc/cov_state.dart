import 'package:covid19_app/features/covid19_status/domain/entities/cov.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CovState extends Equatable {
  @override
  List<Object> get props => [];
}

class Empty extends CovState {}

class Loading extends CovState {}

class Loaded extends CovState {
  final CovStatus cov;

  Loaded({@required this.cov});

  @override
  List<Object> get props => [cov];
}

class Error extends CovState {
  final String message;

  Error({@required this.message});

  @override
  List<Object> get props => [message];
}
