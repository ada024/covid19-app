import 'package:covid19_app/features/covid19_status/domain/entities/cov.dart';
import 'package:meta/meta.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

// part 'cov_model.freezed.dart';
//part 'cov_models.g.dart';


class CovstatusModel  extends CovStatus {



  CovstatusModel({
    @required String confirmed,
    @required String deaths,
    @required String recovered,
    @required String active,
  }) : super(confirmed: confirmed, deaths: deaths,recovered: recovered, active: active);

  factory CovstatusModel.fromJson(Map<String, dynamic> json) {
    return CovstatusModel(
      confirmed: json['confirmed'] as String,
      deaths: json['deaths'] as String,
      recovered: json['recovered'] as String,
      active: json['active'] as String,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'confirmed': confirmed,
      'deaths': deaths,
      'recovered': recovered,
      'active': active
    };
  }
}

