import 'dart:async';
import 'dart:math' as math;

import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:syncfusion_flutter_charts/sparkcharts.dart';

void main() {
  return runApp(_ChartApp());
}

class _ChartApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      home: _MyHomePage(),
    );
  }
}

class _MyHomePage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  _MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<_MyHomePage> {
  _MyHomePageState() {
    timer =
        Timer.periodic(const Duration(milliseconds: 5000), _updateDataSource);
  }

// Переменные
  List<LineSeries<GrData, int>>? series;
  Timer? timer;
  ChartSeriesController? _chartSeriesController;
  static List<GrData> data1 = [
    GrData(0),
  ];
  static List<GrData> data2 = [
    GrData(0),
  ];
  static List<GrData> data3 = [
    GrData(0),
  ];
  static List<GrData> data4 = [
    GrData(0),
  ];
  static List<GrData> data5 = [
    GrData(0),
  ];

  List<ChartElement> chartElement = [
    ChartElement(data1, 't молока', 'TM', Colors.redAccent),
    ChartElement(data2, 't рубашки', 'TW', Colors.blueAccent),
    ChartElement(data3, 't установл.', 'HS_TS_KS_HD', Colors.greenAccent),
    ChartElement(data4, 'Нагрев', 'PV', Colors.purpleAccent),
    ChartElement(
      data5,
      'Этап',
      'ST',
      Colors.yellowAccent,
    ),
  ];

// Инициализация при старте
  @override
  void initState() {
    series = <LineSeries<GrData, int>>[
      LineSeries<GrData, int>(
        dataSource: chartElement[0].data,
        width: 2,
        xValueMapper: (GrData sales, i) => i,
        yValueMapper: (GrData sales, _) => sales.gradys,
        color: chartElement[0].color,
        name: chartElement[0].name,
        legendItemText: chartElement[0].itamTxt,
      ),
      LineSeries<GrData, int>(
        dataSource: chartElement[1].data,
        width: 2,
        xValueMapper: (GrData sales, i) => i,
        yValueMapper: (GrData sales, _) => sales.gradys,
        color: chartElement[1].color,
        name: chartElement[1].name,
        legendItemText: chartElement[1].itamTxt,
      ),
      LineSeries<GrData, int>(
        dataSource: chartElement[2].data,
        width: 2,
        xValueMapper: (GrData sales, i) => i,
        yValueMapper: (GrData sales, _) => sales.gradys,
        color: chartElement[2].color,
        name: chartElement[2].name,
        legendItemText: chartElement[2].itamTxt,
      ),
      LineSeries<GrData, int>(
        dataSource: chartElement[3].data,
        width: 2,
        xValueMapper: (GrData sales, i) => i,
        yValueMapper: (GrData sales, _) => sales.gradys,
        color: chartElement[3].color,
        name: chartElement[3].name,
        legendItemText: chartElement[3].itamTxt,
      ),
      LineSeries<GrData, int>(
        dataSource: chartElement[4].data,
        width: 2,
        xValueMapper: (GrData sales, i) => i,
        yValueMapper: (GrData sales, _) => sales.gradys,
        color: chartElement[4].color,
        name: chartElement[4].name,
        legendItemText: chartElement[4].itamTxt,
      ),
    ];

    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    // data1!.clear();
    series!.clear();
    _chartSeriesController = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Flutter chart'),
        ),
        backgroundColor: Color.fromRGBO(31, 10, 9, 1),
        body: Column(children: [
          SizedBox(
            height: 50,
          ),
          Expanded(child: getAddRemoveSeriesChart()),
          SizedBox(
            height: 50,
          ),
        ]));
  }

  SfCartesianChart getAddRemoveSeriesChart() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      legend: Legend(
          isVisible: true,
          position: LegendPosition.left,
          textStyle: TextStyle(color: Colors.white)),
      primaryXAxis: NumericAxis(
          majorGridLines: const MajorGridLines(width: 0),
          edgeLabelPlacement: EdgeLabelPlacement.shift),
      primaryYAxis: NumericAxis(
          opposedPosition: true,
          maximum: 60,
          axisLine: const AxisLine(width: 0),
          labelFormat: r'{value}°',
          majorTickLines: const MajorTickLines(size: 0)),
      series: series,
      zoomPanBehavior: ZoomPanBehavior(
          maximumZoomLevel: 0.1,
          enablePinching: true,
          zoomMode: ZoomMode.x,
          enablePanning: true,
          enableMouseWheelZooming: true),
      trackballBehavior: TrackballBehavior(
        lineColor: Colors.amber,
        lineWidth: 4,
        enable: true,
        markerSettings: TrackballMarkerSettings(
          markerVisibility: TrackballVisibilityMode.visible,
          height: 10,
          width: 10,
          borderWidth: 1,
        ),
        hideDelay: 2 * 1000,
        activationMode: ActivationMode.singleTap,
        tooltipDisplayMode: TrackballDisplayMode.floatAllPoints,
        shouldAlwaysShow: true,
      ),
    );
  }

  ///Get the random data
  int _getRandomInt(int min, int max) {
    final math.Random random = math.Random();
    return min + random.nextInt(max - min);
  }

  void _updateDataSource(Timer timer) {
    setState(() {
      data1!.add(GrData(_getRandomInt(1, 30)));
      data2!.add(GrData(_getRandomInt(1, 50)));
      data3!.add(GrData(_getRandomInt(2, 10)));

      data4!.add(GrData(_getRandomInt(1, 3)));
      data5!.add(GrData(_getRandomInt(1, 4)));
    });
  }
}

class GrData {
  final int gradys;
  GrData(this.gradys);
}

class ChartElement {
  final List<GrData> data;
  final String itamTxt;
  final String name;
  final Color color;
  ChartElement(this.data, this.itamTxt, this.name, this.color);
}
