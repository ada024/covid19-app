import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:http/http.dart' as http;

import 'injection.config.dart';

final GetIt getIt = GetIt.instance;

@injectableInit
void configureInjection(String env) {
  getIt.registerLazySingleton(() => http.Client());
  getIt.registerLazySingleton(() => DataConnectionChecker());
  $initGetIt(getIt, environment: env);
}
