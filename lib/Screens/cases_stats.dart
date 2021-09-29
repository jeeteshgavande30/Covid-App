import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:corona_app/globals.dart' as g;
import 'package:corona_app/Widgets/line_chart.dart';
import 'package:corona_app/Widgets/bar_charts.dart';

class CasesStats extends StatefulWidget {
  const CasesStats({Key? key}) : super(key: key);

  @override
  _CasesStatsState createState() => _CasesStatsState();
}

class _CasesStatsState extends State<CasesStats> {
  // Item Widget
  Material items(Widget widget, String heading) {
    return Material(
      color: Colors.white,
      elevation: 10.0,
      shadowColor: Color(0x802196F3),
      borderRadius: BorderRadius.circular(5),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                heading,
                style: TextStyle(
                  fontFamily: 'MPLUSRounded',
                  color: Colors.blue[800],
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              Center(
                child: widget,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 12.0,
      mainAxisSpacing: 12.0,
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      children: <Widget>[
        items(
          Container(
            height: 250,
            child: SplineArea(
              g.date,
              g.confirmed,
              g.active,
              g.recovered,
              g.deaths,
            ),
          ),
          "Cummulative Case History",
        ),
        items(
          Container(
            height: 200,
            child: Bar(
              "Daily Confirmed Cases",
              g.date,
              g.dailyconfirmed,
              Colors.blue[600],
            ),
          ),
          "Daily Confirmed Cases",
        ),
        items(
          Container(
            height: 200,
            child: Bar(
              "Daily Recovered Cases",
              g.date,
              g.dailyrecovered,
              Colors.green[700],
            ),
          ),
          "Daily Recovered Cases",
        ),
        items(
          Container(
            height: 200,
            child: Bar(
              "Daily Active Cases",
              g.date,
              g.dailyactive,
              Colors.amberAccent[700],
            ),
          ),
          "Daily Active Cases",
        ),
        items(
          Container(
            height: 200,
            child: Bar(
              "Daily Deceased Cases",
              g.date,
              g.dailydeaths,
              Colors.pinkAccent[400],
            ),
          ),
          "Daily Deceased Cases",
        ),
      ],
      staggeredTiles: [
        StaggeredTile.fit(2),
        StaggeredTile.fit(1),
        StaggeredTile.fit(1),
        StaggeredTile.fit(1),
        StaggeredTile.fit(1),
      ],
    );
  }
}
