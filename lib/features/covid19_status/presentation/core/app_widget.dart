import 'package:auto_route/auto_route.dart';
import 'package:covid19_app/features/covid19_status/presentation/routes/router.gr.dart';
import 'package:flutter/material.dart' hide Router;

class Covid19App extends StatelessWidget {
  const Covid19App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'COVID-19 status app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      builder: ExtendedNavigator(router: Router()),
      debugShowCheckedModeBanner: false,
    );
  }
}