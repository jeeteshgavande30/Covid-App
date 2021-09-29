import 'package:corona_app/Screens/check_slots.dart';
import 'package:corona_app/Screens/home.dart';
import 'package:corona_app/Screens/news.dart';
import 'package:corona_app/Screens/statistics_page.dart';
import 'package:flutter/material.dart';
import 'package:motion_tab_bar_v2/motion-tab-bar.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen>
    with TickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      initialIndex: 0,
      length: 4,
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tabController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MotionTabBar(
        initialSelectedTab: "Home",
        labels: const [
          "Home",
          "Statistics",
          "Slots",
          "News",
        ],
        icons: const [
          Icons.home_rounded,
          Icons.pie_chart_rounded,
          Icons.date_range_rounded,
          Icons.article_rounded,
        ],
        tabSize: 50,
        tabBarHeight: 55,
        textStyle: TextStyle(
          fontSize: 16,
          color: Colors.blue[800],
          fontWeight: FontWeight.w800,
          fontFamily: 'MPLUSRounded',
        ),
        tabIconColor: Colors.blue[800],
        tabIconSize: 30.0,
        tabIconSelectedSize: 35.0,
        tabSelectedColor: Colors.blue[800],
        tabIconSelectedColor: Colors.white,
        tabBarColor: Colors.white70,
        onTabItemSelected: (int value) {
          setState(() {
            _tabController!.index = value;
          });
        },
      ),
      body: TabBarView(
        // swipe navigation handling is not supported
        physics: NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: <Widget>[
          Home(),
          StatisticsPage(),
          CheckSlots(),
          News(),
        ],
      ),
    );
  }
}
