import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CovEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetStatusForCountry extends CovEvent {
  final String country;

  GetStatusForCountry(this.country);

  @override
  List<Object> get props => [country];
}

class GetStatusForWorld extends CovEvent {}
