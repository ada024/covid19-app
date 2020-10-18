import 'package:covid19_app/features/covid19_status/presentation/core/app_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'features/covid19_status/presentation/bloc/bloc.dart';
import 'features/covid19_status/presentation/pages/screens.dart';
import 'features/covid19_status/simple_bloc_observer.dart';
import 'injection.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  String env = Environment.prod;
  assert(() {
    env = Environment.dev;
    Bloc.observer = SimpleBlocObserver();
    return true;
  }());
  configureInjection(env);
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<CovBloc>(
        create: (context) => getIt<CovBloc>()..add(GetStatusForWorld()),
      ),
    ],
    child: const Covid19App(),
  ));
}
