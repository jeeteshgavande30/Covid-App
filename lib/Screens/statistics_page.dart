import 'package:corona_app/Screens/cases_stats.dart';
import 'package:corona_app/Screens/state_list.dart';
import 'package:corona_app/Screens/vaccine_stats.dart';
import 'package:flutter/material.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'COVID-19 Statistics',
              style: TextStyle(
                fontFamily: 'MPLUSRounded',
                fontWeight: FontWeight.w600,
                fontSize: 22.0,
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.blue[900],
            bottom: TabBar(
              indicatorColor: Colors.white,
              tabs: [
                Tab(
                  text: 'Vaccine Stats',
                ),
                Tab(
                  text: 'Cases Stats',
                ),
                Tab(
                  text: 'Statewise Stats',
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              Container(
                child: VaccineStats(),
              ),
              Container(
                child: CasesStats(),
              ),
              Container(
                child: StateList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
