import 'package:corona_app/Widgets/image_card.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:url_launcher/url_launcher.dart';

class PanelWidget extends StatefulWidget {
  final ScrollController controller;
  final PanelController panelController;
  PanelWidget({
    Key? key,
    required this.controller,
    required this.panelController,
  }) : super(key: key);

  @override
  _PanelWidgetState createState() => _PanelWidgetState();
}

// To make a phone call
Future<void> _makePhoneCall() async {
  const num = 'tel:91 11 23978046';
  if (await canLaunch(num)) {
    await launch(num);
  } else {
    throw 'Could not launch $num';
  }
}

class _PanelWidgetState extends State<PanelWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: widget.controller,
      padding: EdgeInsets.zero,
      children: <Widget>[
        SizedBox(
          height: 20.0,
        ),
        Center(
          child: Text(
            "COVID-19 In India",
            style: TextStyle(
              fontSize: 30.0,
              fontFamily: 'MPLUSRounded',
              color: Colors.blue[900],
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 25.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Container(
            child: Column(
              children: <Widget>[
                Text(
                  "Coronavirus disease or COVID-19 is an infectious disease caused by a newly discovered coronavirus.\n",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    color: Colors.blue[600],
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "Most people who fall sick with COVID-19 will experience mild to moderate symptoms and recover without special treatment.\n",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    color: Colors.blue[600],
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton.icon(
                      onPressed: _makePhoneCall,
                      icon: Icon(Icons.phone_in_talk_rounded),
                      label: Text(
                        "Helpline Number",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green[600],
                        onPrimary: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Symptoms:",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 26.0,
                        fontFamily: 'MPLUSRounded',
                        color: Colors.blue[800],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        ImageCard(
                          imgsrc: 'assets/images/symptom - 01.png',
                          color: (Colors.redAccent[100])!,
                          text: 'Cough',
                        ),
                        ImageCard(
                          imgsrc: 'assets/images/symptom - 02.png',
                          color: (Colors.redAccent[100])!,
                          text: 'High Fever',
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        ImageCard(
                          imgsrc: 'assets/images/symptom - 03.png',
                          color: (Colors.redAccent[100])!,
                          text: 'Headache',
                        ),
                        ImageCard(
                          imgsrc: 'assets/images/symptom - 04.png',
                          color: (Colors.redAccent[100])!,
                          text: 'Sore Throat',
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "How It Spreads:",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 26.0,
                        fontFamily: 'MPLUSRounded',
                        color: Colors.blue[800],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        ImageCard(
                          imgsrc: 'assets/images/spread - 01.png',
                          color: (Colors.amberAccent[400])!,
                          text: 'By Air - Cough or Sneeze',
                        ),
                        ImageCard(
                          imgsrc: 'assets/images/spread - 02.png',
                          color: (Colors.amberAccent[400])!,
                          text: 'Personal Contact',
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        ImageCard(
                          imgsrc: 'assets/images/spread - 03.png',
                          color: (Colors.amberAccent[400])!,
                          text: 'Contaminated Objects',
                        ),
                        ImageCard(
                          imgsrc: 'assets/images/spread - 04.png',
                          color: (Colors.amberAccent[400])!,
                          text: 'Social Gathering',
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Prevention:",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 26.0,
                        fontFamily: 'MPLUSRounded',
                        color: Colors.blue[800],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        ImageCard(
                          imgsrc: 'assets/images/prevent - 01.png',
                          color: (Colors.greenAccent[700])!,
                          text: 'Always Wash Your Hands',
                        ),
                        ImageCard(
                          imgsrc: 'assets/images/prevent - 02.png',
                          color: (Colors.greenAccent[700])!,
                          text: 'Always Wear a Face Mask',
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        ImageCard(
                          imgsrc: 'assets/images/prevent - 03.png',
                          color: (Colors.greenAccent[700])!,
                          text: 'Avoid Contact with Sick People',
                        ),
                        ImageCard(
                          imgsrc: 'assets/images/prevent - 04.png',
                          color: (Colors.greenAccent[700])!,
                          text: 'Always Cover Your Cough or Sneeze',
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
