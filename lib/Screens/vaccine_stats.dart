import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:corona_app/globals.dart' as g;
import 'package:corona_app/Widgets/bar_charts.dart';
import 'package:corona_app/Widgets/vaccine_chart.dart';

class VaccineStats extends StatefulWidget {
  const VaccineStats({Key? key}) : super(key: key);

  @override
  State<VaccineStats> createState() => _VaccineStatsState();
}

class _VaccineStatsState extends State<VaccineStats> {
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
              height: 275,
              child: Spline(
                g.date,
                g.totalvaccinated,
                g.totalvaccinated1,
                g.totalvaccinated2,
              ),
            ),
            "Cummulative Vaccination History"),
        items(
            Container(
              height: 200,
              child: Bar(
                "Daily Active Cases",
                g.date,
                g.vaccinated1,
                Colors.pinkAccent[400],
              ),
            ),
            "Vaccinated Once"),
        items(
            Container(
              height: 200,
              child: Bar(
                "Daily Active Cases",
                g.date,
                g.vaccinated2,
                Colors.green[400],
              ),
            ),
            "Vaccinated Twice"),
      ],
      staggeredTiles: [
        StaggeredTile.fit(2),
        StaggeredTile.fit(1),
        StaggeredTile.fit(1),
      ],
    );
  }
}
