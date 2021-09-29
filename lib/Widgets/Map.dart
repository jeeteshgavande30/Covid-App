import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

/// Renders the map tooltip sample.
class MapTooltipPage extends StatefulWidget {
  /// Creates the map tooltip sample.
  @override
  _MapTooltipPageState createState() => _MapTooltipPageState();
}

class _MapTooltipPageState extends State<MapTooltipPage> {
  late List<dynamic> data;
  late List<_Info> _confirmed;
  late List<_Info> _recovered;
  late List<_Info> _deaths;

  late MapShapeSource _confirmedMapSource;
  late MapShapeSource _recoveredMapSource;
  late MapShapeSource _deathsMapSource;
  late MapShapeSource _mapSource;

  late Color _bubbleColor;

  // Index of either forest, river or rainfall data.
  int _currentDataTypeIndex = 0;

  late String _title;

  @override
  void initState() {
    data.forEach((item) {
      _confirmed.add(_Info(item["province"], confirmed: item["confirmed"]));
    });

    data.forEach((item) {
      _recovered.add(_Info(item["province"], confirmed: item["recoverd"]));
    });

    data.forEach((item) {
      _deaths.add(_Info(item["province"], confirmed: item["deaths"]));
    });

    _confirmedMapSource = MapShapeSource.asset(
      'assets/temp.json',
      shapeDataField: 'name',
      dataCount: _confirmed.length,
      primaryValueMapper: (int index) => _confirmed[index].state,
      bubbleSizeMapper: (int index) => _confirmed[index].confirmed!.toDouble(),
    );

    _recoveredMapSource = MapShapeSource.asset(
      'assets/temp.json',
      shapeDataField: 'name',
      dataCount: _recovered.length,
      primaryValueMapper: (int index) => _recovered[index].state,
      bubbleSizeMapper: (int index) => _recovered[index].recovered,
    );

    _deathsMapSource = MapShapeSource.asset(
      'assets/temp.json',
      shapeDataField: 'name',
      dataCount: _deaths.length,
      primaryValueMapper: (int index) => _deaths[index].state,
      bubbleSizeMapper: (int index) => _deaths[index].deaths,
    );
    _setMapDelegate(_currentDataTypeIndex);
    super.initState();
    getData();
  }

  void getData() async {
    Response response =
        await get(Uri.parse('https://disease.sh/v3/covid-19/jhucsse'));
    List<dynamic> temp = jsonDecode(response.body);
    data = temp.sublist(249, 286);
  }

  @override
  void dispose() {
    _confirmed.clear();
    _recovered.clear();
    _deaths.clear();
    super.dispose();
  }

  void _setMapDelegate(int index) {
    switch (index) {
      case 0:
        _title = 'Indian States with the Most Forest Area';
        _bubbleColor = const Color.fromRGBO(34, 205, 72, 0.7);
        _mapSource = _confirmedMapSource;
        break;
      case 1:
        _title = 'Indian States with the Most Rivers';
        _bubbleColor = const Color.fromRGBO(237, 171, 0, 0.7);
        _mapSource = _recoveredMapSource;
        break;
      case 2:
        _title = 'Indian States with the Most Rainfall';
        _bubbleColor = const Color.fromRGBO(24, 152, 207, 0.7);
        _mapSource = _deathsMapSource;
        break;
    }
  }

  Widget _buildCustomTooltipWidget(
      _Info model, ThemeData themeData, bool isLightTheme) {
    return Container(
        width: 300,
        padding: const EdgeInsets.all(10),
        child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 5),
                    Text(
                      model.state,
                      textAlign: TextAlign.center,
                      style: themeData.textTheme.bodyText2!.copyWith(
                          color: isLightTheme
                              ? const Color.fromRGBO(0, 0, 0, 0.87)
                              : const Color.fromRGBO(255, 255, 255, 0.87),
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(_getTooltipText(model),
                        style: themeData.textTheme.caption!.copyWith(
                          color: isLightTheme
                              ? const Color.fromRGBO(0, 0, 0, 0.87)
                              : const Color.fromRGBO(255, 255, 255, 0.87),
                        )),
                  ],
                ),
              ),
              const SizedBox(width: 5),
              // ClipRRect(
              //   borderRadius: BorderRadius.circular(4.0),
              //   child: Image.asset(
              //     model.imageSource,
              //     height: 80.0,
              //     width: 80.0,
              //     fit: BoxFit.fill,
              //   ),
              // ),
            ]));
  }

  _Info _getSelectedIndexModel(int index) {
    if (_currentDataTypeIndex == 0) {
      return _confirmed[index];
    } else if (_currentDataTypeIndex == 1) {
      return _recovered[index];
    } else {
      return _deaths[index];
    }
  }

  // ignore: missing_return
  String _getTooltipText(_Info model) {
    switch (_currentDataTypeIndex) {
      case 0:
        return '${model.state} ${model.confirmed} Updated at ${data[1]["updatedAt"]}';
      case 1:
        return '${model.state} ${model.recovered} Updated at ${data[1]["updatedAt"]}';
      case 2:
        return '${model.state} ${model.deaths} Updated at ${data[1]["updatedAt"]}';
    }

    return '';
  }

  Widget _buildChipWidget(int index, String text) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: ChoiceChip(
        label: Text(
          text,
          style: TextStyle(
            color: Color.fromRGBO(51, 51, 51, 1),
          ),
        ),
        selected: _currentDataTypeIndex == index,
        selectedColor: _bubbleColor,
        onSelected: (bool isSelected) {
          setState(() {
            _currentDataTypeIndex = isSelected ? index : 0;
            _setMapDelegate(_currentDataTypeIndex);
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
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
            child: _buildMapsWidget(themeData, scrollEnabled),
          ),
        ),
      );
    });
  }

  Widget _buildMapsWidget(ThemeData themeData, bool scrollEnabled) {
    final bool isLightTheme = themeData.brightness == Brightness.light;
    return Stack(
      children: <Widget>[
        Container(
          padding: scrollEnabled
              ? EdgeInsets.only(
                  left: 15,
                  top: MediaQuery.of(context).size.height * 0.05,
                  bottom: MediaQuery.of(context).size.height * 0.15)
              : const EdgeInsets.only(bottom: 75.0),
          child: SfMapsTheme(
              data: SfMapsThemeData(
                shapeHoverColor: Colors.transparent,
                shapeHoverStrokeWidth: 0,
                shapeHoverStrokeColor: Colors.transparent,
                bubbleHoverColor: _bubbleColor.withOpacity(0.4),
                bubbleHoverStrokeColor: Colors.black,
                bubbleHoverStrokeWidth: 1.0,
              ),
              child: Column(children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 30),
                    child: Align(
                        alignment: Alignment.center,
                        child: Text(_title,
                            style: Theme.of(context).textTheme.subtitle1))),
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

                      /// This callback returns the custom widget to be shown
                      /// as the tooltip. The custom widget will be wrapped
                      /// inside the tooltip. Hence, the nose will still be
                      /// there. You can customize the stroke around the
                      /// tooltip if needed.
                      bubbleTooltipBuilder: (BuildContext context, int index) {
                        return _buildCustomTooltipWidget(
                            _getSelectedIndexModel(index),
                            themeData,
                            isLightTheme);
                      },
                      color: isLightTheme
                          ? const Color.fromRGBO(204, 204, 204, 1)
                          : const Color.fromRGBO(103, 103, 103, 1),
                      strokeColor: isLightTheme
                          ? const Color.fromRGBO(255, 255, 255, 1)
                          : const Color.fromRGBO(49, 49, 49, 1),
                      strokeWidth: 0.5,
                      bubbleSettings: MapBubbleSettings(
                        minRadius: 15,
                        maxRadius: 30,
                        color: _bubbleColor,
                        strokeColor: Colors.black,
                        strokeWidth: 0.5,
                      ),
                      tooltipSettings: MapTooltipSettings(
                        color: isLightTheme
                            ? const Color.fromRGBO(255, 255, 255, 1)
                            : const Color.fromRGBO(66, 66, 66, 1),
                        strokeColor: const Color.fromRGBO(153, 153, 153, 1),
                        strokeWidth: 0.5,
                      ),
                    ),
                  ],
                )),
              ])),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _buildChipWidget(0, 'Forest'),
              _buildChipWidget(1, 'River'),
              _buildChipWidget(2, 'Rainfall'),
            ],
          ),
        )
      ],
    );
  }
}

class _Info {
  const _Info(
    this.state, {
    this.confirmed,
    this.recovered,
    this.deaths,
  });

  final String state;

  final double? recovered;

  final double? confirmed;

  final double? deaths;
}
