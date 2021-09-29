///Flutter package imports
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_maps/maps.dart';
import 'package:corona_app/globals.dart' as g;

class MapBubblePage extends StatefulWidget {
  @override
  _MapBubblePageState createState() => _MapBubblePageState();
}

class _MapBubblePageState extends State<MapBubblePage>
    with TickerProviderStateMixin {
  _MapBubblePageState();

  late MapShapeSource _mapSource;
  // ignore: unused_field
  late MapShapeSource _confirmedMapSource;
  late MapShapeSource _recoveredMapSource;
  late MapShapeSource _deathsMapSorce;

  late Color _shapeColor;
  late Color _shapeStrokeColor;
  late Color _bubbleColor;
  late Color _bubbleStrokeColor;
  late Color _tooltipColor;
  late Color _tooltipStrokeColor;
  late Color _tooltipTextColor;

  late String _currentDelegate;

  BoxDecoration? _confirmedBoxDecoration;
  BoxDecoration? _recoveredBoxDecoration;
  BoxDecoration? _deathsBoxDecoration;

  late List<_Details> _confirmedUsers = [];
  late List<_Details> _recoveredUsers = [];
  late List<_Details> _deathsUsers = [];

  late AnimationController _confirmedController;
  late AnimationController _recoveredController;
  late AnimationController _deathsController;

  late Animation<double> _confirmedAnimation;
  late Animation<double> _recoveredAnimation;
  late Animation<double> _deathsAnimation;

  @override
  void initState() {
    super.initState();

    _confirmedController = AnimationController(
        duration: const Duration(milliseconds: 100),
        vsync: this,
        lowerBound: 0.6,
        upperBound: 1.0);
    _confirmedAnimation =
        CurvedAnimation(parent: _confirmedController, curve: Curves.easeInOut);

    _recoveredController = AnimationController(
        duration: const Duration(milliseconds: 100),
        vsync: this,
        lowerBound: 0.6,
        upperBound: 1.0);
    _recoveredAnimation =
        CurvedAnimation(parent: _recoveredController, curve: Curves.easeInOut);

    _deathsController = AnimationController(
        duration: const Duration(milliseconds: 100),
        vsync: this,
        lowerBound: 0.6,
        upperBound: 1.0);
    _deathsAnimation =
        CurvedAnimation(parent: _deathsController, curve: Curves.easeInOut);

    // Making recovered map as default display
    _recoveredController.forward();

    for (var i = 0; i < g.states.length; i++) {
      _confirmedUsers.add(_Details(g.states[i], g.confirmedcases[i]));
      _recoveredUsers.add(_Details(g.states[i], g.recoveredcases[i]));
      _deathsUsers.add(_Details(g.states[i], g.deathscases[i]));
    }

    _confirmedMapSource = MapShapeSource.asset(
      'assets/temp.json',
      shapeDataField: 'name',
      dataCount: _confirmedUsers.length,
      primaryValueMapper: (int index) => _confirmedUsers[index].state,
      bubbleSizeMapper: (int index) => _confirmedUsers[index].cases,
    );

    _recoveredMapSource = MapShapeSource.asset(
      'assets/temp.json',
      shapeDataField: 'name',
      dataCount: _recoveredUsers.length,
      primaryValueMapper: (int index) => _recoveredUsers[index].state,
      bubbleSizeMapper: (int index) => _recoveredUsers[index].cases,
    );

    _deathsMapSorce = MapShapeSource.asset(
      'assets/temp.json',
      shapeDataField: 'name',
      dataCount: _deathsUsers.length,
      primaryValueMapper: (int index) => _deathsUsers[index].state,
      bubbleSizeMapper: (int index) => _deathsUsers[index].cases,
    );

    _mapSource = _recoveredMapSource;
    _currentDelegate = 'recovered';
    _shapeColor = const Color.fromRGBO(20, 227, 79, 0.15);
    _shapeStrokeColor = const Color.fromARGB(255, 95, 216, 95).withOpacity(1);
    _bubbleColor = const Color.fromRGBO(43, 176, 43, 0.6);
    _tooltipColor = const Color.fromRGBO(65, 154, 207, 1);
    _bubbleStrokeColor = Colors.white;
    _tooltipStrokeColor = Colors.white;
    _tooltipTextColor = Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final bool scrollEnabled = constraints.maxHeight > 400;
      double height = scrollEnabled ? constraints.maxHeight : 400;
      if (false ||
          (true &&
              MediaQuery.of(context).orientation == Orientation.landscape)) {
        final double refHeight = height * 0.6;
        height = height > 500 ? (refHeight < 500 ? 500 : refHeight) : height;
      }
      return Center(
        child: SingleChildScrollView(
          child: SizedBox(
            width: constraints.maxWidth,
            height: height,
            child: _buildMapsWidget(scrollEnabled),
          ),
        ),
      );
    });
  }

  Widget _buildMapsWidget(bool scrollEnabled) {
    return Stack(
      children: <Widget>[
        Padding(
          padding: scrollEnabled
              ? EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.05,
                  bottom: MediaQuery.of(context).size.height * 0.15,
                  right: 10)
              : const EdgeInsets.only(bottom: 75.0, right: 10),
          child: SfMapsTheme(
              data: SfMapsThemeData(
                shapeHoverColor: Colors.transparent,
                shapeHoverStrokeColor: Colors.transparent,
                bubbleHoverColor: _shapeColor,
                bubbleHoverStrokeColor: _bubbleColor,
                bubbleHoverStrokeWidth: 1.5,
              ),
              child: Column(children: <Widget>[
                Expanded(
                  child: SfMaps(
                    layers: <MapLayer>[
                      MapShapeLayer(
                        loadingBuilder: (BuildContext context) {
                          return Container(
                            height: 25,
                            width: 25,
                            child: const CircularProgressIndicator(
                              strokeWidth: 3,
                            ),
                          );
                        },
                        source: _mapSource,
                        color: _shapeColor,
                        strokeWidth: 1,
                        strokeColor: _shapeStrokeColor,
                        // Returns the custom tooltip for each bubble.
                        bubbleTooltipBuilder:
                            (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(_getCustomizedString(index),
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(color: _tooltipTextColor)),
                          );
                        },
                        bubbleSettings: MapBubbleSettings(
                            strokeColor: _bubbleStrokeColor,
                            strokeWidth: 0.5,
                            color: _bubbleColor,
                            minRadius: 10,
                            maxRadius: 40),
                        tooltipSettings: MapTooltipSettings(
                            color: _tooltipColor,
                            strokeColor: _tooltipStrokeColor),
                      ),
                    ],
                  ),
                )
              ])),
        ),
        SizedBox(
          height: 5.0,
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 5.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  decoration: _confirmedBoxDecoration,
                  child: ScaleTransition(
                    scale: _confirmedAnimation,
                    child: ElevatedButton(
                      child: Text(
                        "Confirmed",
                        style: TextStyle(
                          fontSize: 15.0,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.redAccent[100],
                        onPrimary: Colors.red[900],
                      ),
                      onPressed: () {
                        setState(() {
                          _currentDelegate = '_confirmed';
                          _shapeColor = const Color.fromRGBO(232, 14, 14, 0.15);
                          _shapeStrokeColor =
                              const Color.fromARGB(255, 255, 179, 179)
                                  .withOpacity(1);
                          _bubbleColor = const Color.fromRGBO(232, 14, 14, 0.4);
                          _bubbleStrokeColor = Colors.white;
                          _tooltipColor = const Color.fromRGBO(52, 85, 176, 1);
                          _tooltipStrokeColor = Colors.white;
                          _tooltipTextColor = Colors.white;

                          _confirmedController.forward();

                          _deathsController.reverse();
                          _recoveredController.reverse();
                        });
                      },
                    ),
                  ),
                ),
                Container(
                  decoration: _recoveredBoxDecoration,
                  child: ScaleTransition(
                    scale: _recoveredAnimation,
                    child: ElevatedButton(
                      child: Text(
                        "Recovered",
                        style: TextStyle(fontSize: 15.0),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.greenAccent[100],
                        onPrimary: Colors.green[900],
                      ),
                      onPressed: () {
                        setState(() {
                          _mapSource = _recoveredMapSource;
                          _currentDelegate = 'recovered';
                          _shapeColor = const Color.fromRGBO(20, 227, 79, 0.15);
                          _shapeStrokeColor =
                              const Color.fromARGB(255, 95, 216, 95)
                                  .withOpacity(1);
                          _bubbleColor = const Color.fromRGBO(43, 176, 43, 0.6);
                          _tooltipColor = const Color.fromRGBO(65, 154, 207, 1);
                          _bubbleStrokeColor = Colors.white;
                          _tooltipStrokeColor = Colors.white;
                          _tooltipTextColor = Colors.white;

                          _recoveredController.forward();

                          _confirmedController.reverse();
                          _deathsController.reverse();
                        });
                      },
                    ),
                  ),
                ),
                Container(
                  decoration: _deathsBoxDecoration,
                  child: ScaleTransition(
                    scale: _deathsAnimation,
                    child: ElevatedButton(
                      child: Text(
                        "Deaths",
                        style: TextStyle(fontSize: 15.0),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blueAccent[100],
                        onPrimary: Colors.blue[900],
                      ),
                      onPressed: () {
                        setState(() {
                          _mapSource = _deathsMapSorce;
                          _currentDelegate = 'deaths';
                          _shapeColor =
                              const Color.fromRGBO(107, 182, 255, 0.25);
                          _shapeStrokeColor =
                              Colors.blue[900]!.withOpacity(0.2);
                          _bubbleColor =
                              const Color.fromRGBO(30, 144, 255, 0.5);
                          _tooltipColor = const Color.fromRGBO(189, 74, 119, 1);
                          _bubbleStrokeColor = Colors.white;
                          _tooltipStrokeColor = Colors.white;
                          _tooltipTextColor = Colors.white;

                          _deathsController.forward();

                          _confirmedController.reverse();
                          _recoveredController.reverse();
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String _getCustomizedString(int index) {
    switch (_currentDelegate) {
      case '_confirmed':
        return _confirmedUsers[index].state +
            ' : ' +
            _confirmedUsers[index].cases.toStringAsFixed(0);
      case 'recovered':
        return _recoveredUsers[index].state +
            ' : ' +
            _recoveredUsers[index].cases.toStringAsFixed(0);
      case 'deaths':
        return _deathsUsers[index].state +
            ' : ' +
            _deathsUsers[index].cases.toStringAsFixed(0);
      default:
        return '';
    }
  }
}

class _Details {
  _Details(this.state, this.cases);

  final String state;
  final double cases;
}
