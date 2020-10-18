import 'package:auto_route/auto_route_annotations.dart';
import 'package:covid19_app/features/covid19_status/presentation/app/app.dart';

@MaterialAutoRouter(
    generateNavigationHelperExtension: true,

  routes: <AutoRoute>[
    MaterialRoute<void>(page: AppRoot, initial: true)
  ],



)
class $Router {}
