import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class CovStatus extends Equatable {
  final String confirmed;
  final String deaths;
  final String recovered;
  final String active;

  CovStatus({
    @required this.confirmed,
    @required this.deaths,
    @required this.recovered,
    @required this.active,
  });
  List<Object> get props => [confirmed, deaths,recovered,active];
}
