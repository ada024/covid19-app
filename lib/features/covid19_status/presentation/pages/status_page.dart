import 'package:covid19_app/features/covid19_status/presentation/bloc/cov_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class StatusPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Covid19 world summary'),
      ),
      body: SingleChildScrollView(
        child: buildBody(context),
      ),
    );
  }

  BlocProvider<CovBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<CovBloc>(),
      child: const Text("Covid19 statusPage"),
    );
  }
}
