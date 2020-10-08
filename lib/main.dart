import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'features/covid19_status/presentation/pages/status_page.dart';
import 'injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await di.init();
  runApp(Covid19App());
}

class Covid19App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'COVID-19 status app',
      theme: ThemeData(
        primaryColor: Colors.green.shade800,
        accentColor: Colors.green.shade600,
      ),
      home: StatusPage(),
    );
  }
}
