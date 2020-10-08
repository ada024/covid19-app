import 'package:covid19_app/features/covid19_status/domain/entities/cov.dart';
import 'package:meta/meta.dart';

class CovModel extends Cov {
  CovModel({
    @required dynamic confirmed,
    @required dynamic deaths,
    @required dynamic recovered,
    @required dynamic active,
  }) : super(confirmed: confirmed, deaths: deaths,recovered: recovered, active: active);

  factory CovModel.fromJson(Map<String, dynamic> json) {
    return CovModel(
      confirmed: json['confirmed'],
      deaths: json['deaths'],
      recovered: json['recovered'],
      active: json['active'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'confirmed': confirmed,
      'deaths': deaths,
      'recovered': recovered,
      'active': active,
    };
  }
}

