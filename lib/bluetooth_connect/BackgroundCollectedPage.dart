import 'package:flutter/material.dart';

import './BackgroundCollectingTask.dart';
import './helpers/LineChart.dart';
import './helpers/PaintStyle.dart';

class BackgroundCollectedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final BackgroundCollectingTask task =
        BackgroundCollectingTask.of(context, rebuildOnChange: true);

    // Сдвиг аргументов необходим для временных меток, так как миллисекунды в double могут привести к потере точности.
    final int argumentsShift =
        task.samples.first.timestamp.millisecondsSinceEpoch;

    final Duration showDuration =
        Duration(hours: 2); // @TODO . show duration should be configurable
    final Iterable<DataSample> lastSamples = task.getLastOf(showDuration);

    final Iterable<double> arguments = lastSamples.map((sample) {
      return (sample.timestamp.millisecondsSinceEpoch - argumentsShift)
          .toDouble();
    });

    // Шаг для меток аргументов
    final Duration argumentsStep =
        Duration(minutes: 15); // @TODO . продолжительность шага должна быть настраиваемой

    // Найдите первую временную метку, указанную на шаге до этого
    final DateTime beginningArguments = lastSamples.first.timestamp;
    DateTime beginningArgumentsStep = DateTime(beginningArguments.year,
        beginningArguments.month, beginningArguments.day);
    while (beginningArgumentsStep.isBefore(beginningArguments)) {
      beginningArgumentsStep = beginningArgumentsStep.add(argumentsStep);
    }
    beginningArgumentsStep = beginningArgumentsStep.subtract(argumentsStep);
    final DateTime endingArguments = lastSamples.last.timestamp;

    // Сгенерировать список временных меток меток
    final Iterable<DateTime> argumentsLabelsTimestamps = () sync* {
      DateTime timestamp = beginningArgumentsStep;
      yield timestamp;
      while (timestamp.isBefore(endingArguments)) {
        timestamp = timestamp.add(argumentsStep);
        yield timestamp;
      }
    }();

    // Сопоставьте строки для меток
    final Iterable<LabelEntry> argumentsLabels =
        argumentsLabelsTimestamps.map((timestamp) {
      return LabelEntry(
          (timestamp.millisecondsSinceEpoch - argumentsShift).toDouble(),
          ((timestamp.hour <= 9 ? '0' : '') +
              timestamp.hour.toString() +
              ':' +
              (timestamp.minute <= 9 ? '0' : '') +
              timestamp.minute.toString()));
    });

    return Scaffold(
        appBar: AppBar(
          title: Text('Collected data'),
          actions: <Widget>[
            // Круг прогресса
            (task.inProgress
                ? FittedBox(
                    child: Container(
                        margin: new EdgeInsets.all(16.0),
                        child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white))))
                : Container(/* Dummy */)),
            // Start/stop buttons
            (task.inProgress
                ? IconButton(icon: Icon(Icons.pause), onPressed: task.pause)
                : IconButton(
                    icon: Icon(Icons.play_arrow), onPressed: task.reasume)),
          ],
        ),
        body: ListView(
          children: <Widget>[
            Divider(),
            ListTile(
              leading: const Icon(Icons.brightness_7),
              title: const Text('Температуры'),
              subtitle: const Text('В градусах Цельсия'),
            ),
            LineChart(
              constraints: const BoxConstraints.expand(height: 350),
              arguments: arguments,
              argumentsLabels: argumentsLabels,
              values: [
                lastSamples.map((sample) => sample.temperature1),
                lastSamples.map((sample) => sample.temperature2),
              ],
              verticalLinesStyle: const PaintStyle(color: Colors.grey),
              additionalMinimalHorizontalLabelsInterval: 0,
              additionalMinimalVerticalLablesInterval: 0,
              seriesPointsStyles: [
                null,
                null,
                //const PaintStyle(style: PaintingStyle.stroke, strokeWidth: 1.7*3, color: Colors.indigo, strokeCap: StrokeCap.round),
              ],
              seriesLinesStyles: [
                const PaintStyle(
                    style: PaintingStyle.stroke,
                    strokeWidth: 1.7,
                    color: Colors.indigoAccent),
                const PaintStyle(
                    style: PaintingStyle.stroke,
                    strokeWidth: 1.7,
                    color: Colors.redAccent),
              ],
            ),
            Divider(),
            ListTile(
              leading: const Icon(Icons.filter_vintage),
              title: const Text('Уровень рН воды'),
            ),
            LineChart(
              constraints: const BoxConstraints.expand(height: 200),
              arguments: arguments,
              argumentsLabels: argumentsLabels,
              values: [
                lastSamples.map((sample) => sample.waterpHlevel),
              ],
              verticalLinesStyle: const PaintStyle(color: Colors.grey),
              additionalMinimalHorizontalLabelsInterval: 0,
              additionalMinimalVerticalLablesInterval: 0,
              seriesPointsStyles: [
                null,
              ],
              seriesLinesStyles: [
                const PaintStyle(
                    style: PaintingStyle.stroke,
                    strokeWidth: 1.7,
                    color: Colors.greenAccent),
              ],
            ),
          ],
        ));
  }
}
