import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:covid19_app/features/covid19_status/presentation/bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'package:covid19_app/features/covid19_status/presentation/widgets/widgets.dart';
import 'package:covid19_app/features/covid19_status/presentation/config/palette.dart';
import 'package:covid19_app/features/covid19_status/presentation/config/styles.dart';
import 'package:covid19_app/features/covid19_status/data/data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StatusPage extends StatefulWidget {
  @override
  _StatusPageState createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {


  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      backgroundColor: Palette.primaryColor,
      appBar: CustomAppBar(),
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: <Widget>[
          _buildHeader(),
          _buildRegionTabBar(),
          //    _buildStatsTabBar(),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            sliver: SliverToBoxAdapter(
              child: StatsGrid(),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(top: 20.0),
            sliver: SliverToBoxAdapter(
              child: CovidBarChart(covidCases: covidUSADailyNewCases),
            ),
          ),
        ],
      ),
    );
  }

  SliverPadding _buildHeader() {
    return const SliverPadding(
      padding: EdgeInsets.all(20.0),
      sliver: SliverToBoxAdapter(
        child: Text(
          'Statistics',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildRegionTabBar() {
    return SliverToBoxAdapter(
      child: DefaultTabController(
        length: 2,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20.0),
          height: 50.0,
          decoration: BoxDecoration(
            color: Colors.white24,
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: TabBar(
            indicator: const BubbleTabIndicator(
              tabBarIndicatorSize: TabBarIndicatorSize.tab,
              indicatorHeight: 40.0,
              indicatorColor: Colors.white,
            ),
            labelStyle: Styles.tabTextStyle,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.white,
            tabs: const <Widget>[
              Text('World'),
              Text('My Country'),
            ],
            onTap: (index) {
              if(index !=0){
                //TODO change to world/country
              }else{

              }
            },
          ),
        ),
      ),
    );
  }

  SliverPadding _buildStatsTabBar() {
    return SliverPadding(
      padding: const EdgeInsets.all(20.0),
      sliver: SliverToBoxAdapter(
        child: DefaultTabController(
          length: 3,
          child: TabBar(
            indicatorColor: Colors.transparent,
            labelStyle: Styles.tabTextStyle,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white60,
            tabs: const <Widget>[
              Text('Total'),
              Text('Today'),
              Text('Yesterday'),
            ],
            onTap: (index) {},
          ),
        ),
      ),
    );
  }
}
