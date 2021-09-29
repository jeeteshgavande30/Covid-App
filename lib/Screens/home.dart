import 'package:corona_app/Screens/map.dart';
import 'package:corona_app/Widgets/panel.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Panel Controller
  final panelController = PanelController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white12,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/map-background-image.png"),
            fit: BoxFit.fitHeight,
          ),
        ),
        child: SafeArea(
          child: SlidingUpPanel(
            controller: panelController,
            // Content to be shown in the behind panel
            body: MapBubblePage(),
            panelBuilder: (controller) => PanelWidget(
              panelController: panelController,
              controller: controller,
            ),
            minHeight: MediaQuery.of(context).size.height * 0.12,
            maxHeight: MediaQuery.of(context).size.height * 0.8,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
            parallaxEnabled: true,
            parallaxOffset: 0.5,
          ),
        ),
      ),
    );
  }
}
