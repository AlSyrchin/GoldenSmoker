import 'dart:async';
import 'dart:math';

///Package imports
import 'package:flutter/material.dart';
// import 'package:intl/intl.dart' hide TextDirection;

///Chart import
import 'package:syncfusion_flutter_charts/charts.dart' hide LabelPlacement;

///Core import
import 'package:syncfusion_flutter_core/core.dart';

///Core theme import
import 'package:syncfusion_flutter_core/theme.dart';

///Slider import
import 'package:syncfusion_flutter_sliders/sliders.dart';

void main() {
  runApp(const ExampleApplication());
}

class ExampleApplication extends StatelessWidget {
  const ExampleApplication({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: RangeZoom(),
    );
  }
}


class RangeZoom extends StatefulWidget {
  const RangeZoom({super.key});

  @override
  State<RangeZoom> createState() => _RangeZoomState();
}

class _RangeZoomState extends State<RangeZoom> {
//
  double min = 0, max = 120;
  late RangeController rangeController;
  late SfCartesianChart columnChart, splineChart;
  final List<ChartSampleData> splineSeriesData = <ChartSampleData>[];
  int  init = 121;
  //Переменная по обновлению графика
  bool enableDeferredUpdate = false;

  @override
  void initState() {
    super.initState();
    //концы контроллера
    rangeController = RangeController(
      start: 10,
      end: 20,
    );
    for (int i = 0; i < 120; i++){
      splineSeriesData.add(ChartSampleData(x: i, y: Random().nextInt(150) + 1));
    }

    Timer.periodic(Duration(seconds: 1), (timer) {setState(() {
      splineSeriesData.add(ChartSampleData(x: init, y: Random().nextInt(150) + 1));
      init++;
      max++;
    });});

    
  }

  @override
  void dispose() {
    rangeController.dispose();
    splineSeriesData.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

      columnChart = SfCartesianChart(
            margin: EdgeInsets.zero,
            primaryXAxis: NumericAxis(isVisible: false),
            primaryYAxis: NumericAxis(isVisible: false),
            plotAreaBorderWidth: 0,
            series: <StepAreaSeries<ChartSampleData, int>>[
              StepAreaSeries<ChartSampleData, int>(
                dataSource: splineSeriesData,
                borderColor: const Color.fromRGBO(0, 193, 187, 1),
                color: const Color.fromRGBO(163, 226, 224, 1),
                borderDrawMode: BorderDrawMode.excludeBottom,
                borderWidth: 1,
                xValueMapper: (ChartSampleData sales, _) => sales.x,
                yValueMapper: (ChartSampleData sales, _) => sales.y,
                animationDuration: 0,
              )
            ],
          );

    splineChart = SfCartesianChart(
      plotAreaBorderWidth: 0,
      tooltipBehavior: TooltipBehavior(
          animationDuration: 0, shadowColor: Colors.transparent, enable: true),
      primaryXAxis: NumericAxis(
          isVisible: false,
          minimum:  min,
          maximum:  max,
          visibleMinimum: rangeController.start,
          visibleMaximum: rangeController.end,
          rangeController: rangeController),
      primaryYAxis: NumericAxis(
        labelPosition: ChartDataLabelPosition.inside,
        labelAlignment: LabelAlignment.end,
        majorTickLines: const MajorTickLines(size: 0),
        axisLine: const AxisLine(color: Colors.transparent),
        anchorRangeToVisiblePoints: false,
      ),
      series: <LineSeries<ChartSampleData, int>>[
        LineSeries<ChartSampleData, int>(          
          name: 'EUR',
          dataSource: splineSeriesData,
          color: const Color.fromRGBO(0, 193, 187, 1),
          animationDuration: 0,
          xValueMapper: (ChartSampleData sales, _) => sales.x,          
          yValueMapper: (ChartSampleData sales, _) => sales.y,
        )
      ],
    );


    final Widget page = Container(
        color: Colors.white,
        child: Center(
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                    padding: const EdgeInsets.fromLTRB(5, 20, 15, 25),
                    child: splineChart),
              ),
              SfRangeSelectorTheme(
                  data: SfRangeSelectorThemeData(
                      activeLabelStyle: const TextStyle(
                          fontSize: 10,
                          color:  Color.fromARGB(255, 26, 26, 26)),
                      inactiveLabelStyle: const TextStyle(
                          fontSize: 10,
                          color:  Color.fromRGBO(170, 170, 170, 1)),
                      activeTrackColor: const Color.fromRGBO(255, 125, 30, 1),
                      inactiveRegionColor: Colors.white.withOpacity(0.75),
                      thumbColor: Colors.white,
                      thumbStrokeColor: const Color.fromRGBO(255, 125, 30, 1),
                      thumbStrokeWidth: 2.0,
                      overlayRadius: 1,
                      overlayColor: Colors.transparent),
                  child: Container(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(14, 0, 15, 15),
                        child: SfRangeSelector(
                          min: min,
                          max: max,
                          interval: 10,
                          enableDeferredUpdate: enableDeferredUpdate,
                          deferredUpdateDelay: 1000,
                          controller: rangeController,
                          showTicks: true,
                          showLabels: true,
                          dragMode: SliderDragMode.both,
                          onChanged: (SfRangeValues values) {},
                          child: Container(
                            height: 75,
                            child: columnChart,
                          ),
                        ),
                      ),
                    ),
                  )),
            ],
          ),
        ));


    return Scaffold(
      body: page,
    );
  }

}

class ChartSampleData {
  int x;
  double y;
  ChartSampleData({
    required this.x,
    required this.y,
  });
}
