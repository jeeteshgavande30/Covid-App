import 'package:flutter/material.dart';
import 'package:corona_app/globals.dart' as g;
import 'package:flutter/rendering.dart';

class StateList extends StatefulWidget {
  const StateList({Key? key}) : super(key: key);

  @override
  _StateListState createState() => _StateListState();
}

class _StateListState extends State<StateList> {
  bool scroll = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Visibility(
        visible: scroll,
        child: FloatingActionButton.extended(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                actionsPadding: EdgeInsets.zero,
                title: Center(
                  child: Text(
                    'Abbreviations Used',
                    style: TextStyle(
                      fontFamily: 'MPLUSRounded',
                      fontWeight: FontWeight.bold,
                    ),
                    textScaleFactor: 1.25,
                  ),
                ),
                content: Container(
                  height: MediaQuery.of(context).size.height * 0.16,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'A: Active Cases',
                          style: TextStyle(
                            fontFamily: 'MPLUSRounded',
                            color: Colors.blueAccent[400],
                            fontWeight: FontWeight.bold,
                          ),
                          textScaleFactor: 1.2,
                        ),
                        Text(
                          'C: Confirmed Cases',
                          style: TextStyle(
                            fontFamily: 'MPLUSRounded',
                            color: Colors.amberAccent[700],
                            fontWeight: FontWeight.bold,
                          ),
                          textScaleFactor: 1.2,
                        ),
                        Text(
                          'R: Recovered Cases',
                          style: TextStyle(
                            fontFamily: 'MPLUSRounded',
                            color: Colors.greenAccent[700],
                            fontWeight: FontWeight.bold,
                          ),
                          textScaleFactor: 1.2,
                        ),
                        Text(
                          'D: Death Cases',
                          style: TextStyle(
                            fontFamily: 'MPLUSRounded',
                            color: Colors.redAccent[400],
                            fontWeight: FontWeight.bold,
                          ),
                          textScaleFactor: 1.2,
                        ),
                      ],
                    ),
                  ),
                ),
                actions: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Close',
                        style: TextStyle(
                          fontFamily: 'MPLUSRounded',
                          fontWeight: FontWeight.bold,
                        ),
                        textScaleFactor: 1.25,
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color?>(Colors.blue[50]),
                        overlayColor:
                            MaterialStateProperty.all<Color?>(Colors.blue[100]),
                        foregroundColor:
                            MaterialStateProperty.all<Color?>(Colors.blue[700]),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          label: Text(
            "Abbreviations",
            style: TextStyle(
              fontFamily: 'MPLUSRounded',
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      ),
      body: NotificationListener<UserScrollNotification>(
        onNotification: (notification) {
          if (notification.direction == ScrollDirection.forward) {
            setState(() {
              scroll = true;
            });
          } else if (notification.direction == ScrollDirection.reverse) {
            setState(() {
              scroll = false;
            });
          }
          return true;
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(2.0, 10.0, 2.0, 10.0),
            child: Column(
              children: [
                Table(
                  border: TableBorder.all(
                    width: 2.0,
                    color: Colors.white,
                  ),
                  columnWidths: {
                    0: FlexColumnWidth(150),
                    1: FlexColumnWidth(60),
                    2: FlexColumnWidth(60),
                    3: FlexColumnWidth(60),
                    4: FlexColumnWidth(60),
                  },
                  textDirection: TextDirection.ltr,
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: <TableRow>[
                    TableRow(children: [
                      Container(
                        height: 40,
                        decoration: new BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: Text(
                            "State/UT",
                            style: TextStyle(
                              fontFamily: 'MPLUSRounded',
                              color: Colors.indigo[900],
                              fontWeight: FontWeight.bold,
                            ),
                            textScaleFactor: 1.4,
                          ),
                        ),
                      ),
                      Container(
                        height: 40,
                        decoration: new BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: Center(
                          child: Text(
                            "A",
                            style: TextStyle(
                              fontFamily: 'MPLUSRounded',
                              color: Colors.blueAccent[400],
                              fontWeight: FontWeight.bold,
                            ),
                            textScaleFactor: 1.4,
                          ),
                        ),
                      ),
                      Container(
                        height: 40,
                        decoration: new BoxDecoration(
                          color: Colors.yellow[50],
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: Center(
                          child: Text(
                            "C",
                            style: TextStyle(
                              fontFamily: 'MPLUSRounded',
                              color: Colors.amberAccent[700],
                              fontWeight: FontWeight.bold,
                            ),
                            textScaleFactor: 1.4,
                          ),
                        ),
                      ),
                      Container(
                        height: 40,
                        decoration: new BoxDecoration(
                          color: Colors.green[50],
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: Center(
                          child: Text(
                            "R",
                            style: TextStyle(
                              fontFamily: 'MPLUSRounded',
                              color: Colors.greenAccent[700],
                              fontWeight: FontWeight.bold,
                            ),
                            textScaleFactor: 1.4,
                          ),
                        ),
                      ),
                      Container(
                        height: 40,
                        decoration: new BoxDecoration(
                          color: Colors.red[50],
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: Center(
                          child: Text(
                            "D",
                            style: TextStyle(
                              fontFamily: 'MPLUSRounded',
                              color: Colors.redAccent[400],
                              fontWeight: FontWeight.bold,
                            ),
                            textScaleFactor: 1.4,
                          ),
                        ),
                      ),
                    ]),
                    for (var i = 0; i < g.states.length; i++)
                      TableRow(
                        children: [
                          Container(
                            height: 43,
                            decoration: new BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(
                              child: Text(
                                g.states[i],
                                style: TextStyle(
                                  fontFamily: 'MPLUSRounded',
                                  color: Colors.blue[900],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.visible,
                              ),
                            ),
                          ),

                          // Active Cases Column
                          Container(
                            height: 43,
                            decoration: new BoxDecoration(
                              color: Colors.blue[50],
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (g.todayactivecases[i].toInt() != 0)
                                    if (g.todayactivecases[i].toInt() > 0)
                                      Text(
                                        '+${g.todayactivecases[i].toInt().toString()}',
                                        style: TextStyle(
                                          fontFamily: 'MPLUSRounded',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                          color: Colors.blue,
                                        ),
                                        textAlign: TextAlign.center,
                                        textScaleFactor: 1.25,
                                      ),
                                  if (g.todayactivecases[i].toInt() < 0)
                                    Text(
                                      g.todayactivecases[i].toInt().toString(),
                                      style: TextStyle(
                                        fontFamily: 'MPLUSRounded',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                        color: Colors.blue,
                                      ),
                                      textAlign: TextAlign.center,
                                      textScaleFactor: 1.25,
                                    ),
                                  Text(
                                    g.activecases[i].toInt().toString(),
                                    style: TextStyle(
                                      fontFamily: 'MPLUSRounded',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                    textAlign: TextAlign.center,
                                    textScaleFactor: 1.0,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // Confirmed Cases Column
                          Container(
                            height: 43,
                            decoration: new BoxDecoration(
                              color: Colors.yellow[50],
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (g.todayconfirmedcases[i].toInt() != 0)
                                    if (g.todayconfirmedcases[i].toInt() > 0)
                                      Text(
                                        '+${g.todayconfirmedcases[i].toInt().toString()}',
                                        style: TextStyle(
                                          fontFamily: 'MPLUSRounded',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                          color: Colors.amber,
                                        ),
                                        textAlign: TextAlign.center,
                                        textScaleFactor: 1.25,
                                      ),
                                  if (g.todayconfirmedcases[i].toInt() < 0)
                                    Text(
                                      g.todayconfirmedcases[i]
                                          .toInt()
                                          .toString(),
                                      style: TextStyle(
                                        fontFamily: 'MPLUSRounded',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                        color: Colors.amber,
                                      ),
                                      textAlign: TextAlign.center,
                                      textScaleFactor: 1.25,
                                    ),
                                  Text(
                                    g.confirmedcases[i].toInt().toString(),
                                    style: TextStyle(
                                      fontFamily: 'MPLUSRounded',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                    textAlign: TextAlign.center,
                                    textScaleFactor: 1.0,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // Recovered Cases Column
                          Container(
                            height: 43,
                            decoration: new BoxDecoration(
                              color: Colors.green[50],
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (g.todayrecoveredcases[i].toInt() != 0)
                                    if (g.todayrecoveredcases[i].toInt() > 0)
                                      Text(
                                        '+${g.todayrecoveredcases[i].toInt().toString()}',
                                        style: TextStyle(
                                          fontFamily: 'MPLUSRounded',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                          color: Colors.green,
                                        ),
                                        textAlign: TextAlign.center,
                                        textScaleFactor: 1.25,
                                      ),
                                  if (g.todayrecoveredcases[i].toInt() < 0)
                                    Text(
                                      g.todayrecoveredcases[i]
                                          .toInt()
                                          .toString(),
                                      style: TextStyle(
                                        fontFamily: 'MPLUSRounded',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                        color: Colors.green,
                                      ),
                                      textAlign: TextAlign.center,
                                      textScaleFactor: 1.25,
                                    ),
                                  Text(
                                    g.recoveredcases[i].toInt().toString(),
                                    style: TextStyle(
                                      fontFamily: 'MPLUSRounded',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                    textAlign: TextAlign.center,
                                    textScaleFactor: 1.0,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // Death Cases Column
                          Container(
                            height: 43,
                            decoration: new BoxDecoration(
                              color: Colors.red[50],
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (g.todaydeathscases[i].toInt() != 0)
                                    if (g.todaydeathscases[i].toInt() > 0)
                                      Text(
                                        '+${g.todaydeathscases[i].toInt().toString()}',
                                        style: TextStyle(
                                          fontFamily: 'MPLUSRounded',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                          color: Colors.red,
                                        ),
                                        textAlign: TextAlign.center,
                                        textScaleFactor: 1.25,
                                      ),
                                  if (g.todaydeathscases[i].toInt() < 0)
                                    Text(
                                      g.todaydeathscases[i].toInt().toString(),
                                      style: TextStyle(
                                        fontFamily: 'MPLUSRounded',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                        color: Colors.red,
                                      ),
                                      textAlign: TextAlign.center,
                                      textScaleFactor: 1.25,
                                    ),
                                  Text(
                                    g.deathscases[i].toInt().toString(),
                                    style: TextStyle(
                                      fontFamily: 'MPLUSRounded',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                    textAlign: TextAlign.center,
                                    textScaleFactor: 1.0,
                                  ),
                                ],
                              ),
                            ),
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
      ),
    );
  }
}
