import 'package:covid19_app/features/covid19_status/presentation/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'loading.dart';

class StatsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CovBloc, CovState>(
      builder: (context, state) {
        if (state is Loading) {
          return const LoadingWidget();
        } else if (state is Loaded) {
          return  Container(
            height: MediaQuery.of(context).size.height * 0.25,
            child: Column(
              children: <Widget>[
                Flexible(
                  child: Row(
                    children: <Widget>[
                      _buildStatCard('Total Cases', state.cov.active, Colors.orange),
                      _buildStatCard('Deaths', state.cov.deaths, Colors.red),
                    ],
                  ),
                ),
                Flexible(
                  child: Row(
                    children: <Widget>[
                      _buildStatCard('Recovered', state.cov.recovered, Colors.green),
                    //  _buildStatCard('Active', state.cov.active, Colors.lightBlue),
                      _buildStatCard('Critical', 'N/A', Colors.purple),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else if (state is Error) {
          return const Text("Error");
        }
        return const LoadingWidget();
      },
    );
  }

  Expanded _buildStatCard(String title, String count, MaterialColor color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              count,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
