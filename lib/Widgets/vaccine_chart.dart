import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Spline extends StatefulWidget {
  final List<String> xdata;
  final List<double> y1data;
  final List<double> y2data;
  final List<double> y3data;
  const Spline(this.xdata, this.y1data, this.y2data, this.y3data) : super();

  @override
  _SplineState createState() => _SplineState(xdata, y1data, y2data, y3data);
}

/// State class of the spline area chart.
class _SplineState extends State<Spline> {
  final List<String> xdata;
  final List<double> y1data;
  final List<double> y2data;
  final List<double> y3data;
  _SplineState(this.xdata, this.y1data, this.y2data, this.y3data);

  @override
  Widget build(BuildContext context) {
    return _buildSplineAreaChart();
  }

  /// Returns the cartesian spline are chart.
  SfCartesianChart _buildSplineAreaChart() {
    return SfCartesianChart(
      legend: Legend(
        isVisible: true,
        opacity: 0.7,
        position: LegendPosition.bottom,
        overflowMode: LegendItemOverflowMode.wrap,
      ),
      // title: ChartTitle(text: 'C'),
      plotAreaBorderWidth: 0,
      primaryXAxis: DateTimeAxis(
          interval: xdata.length / 10,
          majorGridLines: const MajorGridLines(width: 0),
          dateFormat: DateFormat('''MMM/dd/yyyy'''),
          edgeLabelPlacement: EdgeLabelPlacement.shift),
      primaryYAxis: NumericAxis(
          numberFormat: NumberFormat.compact(),
          axisLine: const AxisLine(width: 0),
          majorTickLines: const MajorTickLines(size: 0)),
      series: _getSplieAreaSeries(),
      zoomPanBehavior: ZoomPanBehavior(
        /// To enable the pinch zooming as true.
        enablePinching: true,
        zoomMode: ZoomMode.xy,
        enablePanning: true,
        enableMouseWheelZooming: true,
      ),
      // tooltipBehavior: TooltipBehavior(enable: true),
      trackballBehavior: TrackballBehavior(
        enable: true,
        markerSettings: TrackballMarkerSettings(
          markerVisibility: TrackballVisibilityMode.visible,
          height: 10,
          width: 10,
          borderWidth: 1,
        ),
        hideDelay: 2000,
        activationMode: ActivationMode.singleTap,
        tooltipAlignment: ChartAlignment.center,
        tooltipDisplayMode: TrackballDisplayMode.groupAllPoints,
        tooltipSettings: InteractiveTooltip(canShowMarker: true),
        shouldAlwaysShow: false,
      ),
    );
  }

  /// Returns the list of chart series
  /// which need to render on the spline area chart.
  List<ChartSeries<_SplineAreaData, DateTime>> _getSplieAreaSeries() {
    final List<_SplineAreaData> chartData = [];
    for (var i = 0; i < xdata.length; i++) {
      chartData.add(_SplineAreaData(
          DateTime.parse(xdata[i]), y1data[i], y2data[i], y3data[i]));
    }
    return <ChartSeries<_SplineAreaData, DateTime>>[
      SplineAreaSeries<_SplineAreaData, DateTime>(
        dataSource: chartData,
        color: Colors.blue[900]!.withOpacity(0.25),
        borderColor: Colors.blue[600],
        borderWidth: 2,
        name: 'Total Vaccinations',
        xValueMapper: (_SplineAreaData cases, _) => cases.year,
        yValueMapper: (_SplineAreaData cases, _) => cases.y1,
      ),
      SplineAreaSeries<_SplineAreaData, DateTime>(
        dataSource: chartData,
        borderColor: Colors.pinkAccent[400],
        color: Colors.pinkAccent[400]!.withOpacity(0.25),
        borderWidth: 2,
        name: 'Partially Vaccinated',
        xValueMapper: (_SplineAreaData cases, _) => cases.year,
        yValueMapper: (_SplineAreaData cases, _) => cases.y2,
      ),
      SplineAreaSeries<_SplineAreaData, DateTime>(
        dataSource: chartData,
        borderColor: Colors.green[700],
        color: Colors.green[400]!.withOpacity(0.75),
        borderWidth: 2,
        name: 'Fully Vaccinated',
        xValueMapper: (_SplineAreaData cases, _) => cases.year,
        yValueMapper: (_SplineAreaData cases, _) => cases.y3,
      ),
    ];
  }
}

/// Private class for storing the spline area chart datapoints.
class _SplineAreaData {
  _SplineAreaData(this.year, this.y1, this.y2, this.y3);
  final DateTime year;
  final double y1;
  final double y2;
  final double y3;
}
