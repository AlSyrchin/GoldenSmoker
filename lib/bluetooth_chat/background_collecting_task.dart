import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:scoped_model/scoped_model.dart';

class DataSample {
  double temperature1;
  double temperature2;
  double waterpHlevel;
  DateTime timestamp;

  DataSample({
    required this.temperature1,
    required this.temperature2,
    required this.waterpHlevel,
    required this.timestamp,
  });
}

class BackgroundCollectingTask extends Model {
  static BackgroundCollectingTask of(
    BuildContext context, {
    bool rebuildOnChange = false,
  }) =>
      ScopedModel.of<BackgroundCollectingTask>(
        context,
        rebuildOnChange: rebuildOnChange,
      );

  final BluetoothConnection _connection;
  List<int> _buffer = List<int>.empty(growable: true);

  // @TODO , такой сбор образцов в реальном коде должен быть делегирован
 // (предпочтительно через `Stream<DataSample>`), а затем сохранен для последующего использования
 // отображение на графике (или даже прямая подготовка к отображению).
 // @TODO ? в какой-то момент их следует уменьшить, так как бесконечный сбор данных приведет к нехватке памяти.
  List<DataSample> samples = List<DataSample>.empty(growable: true);

  bool inProgress = false;

  BackgroundCollectingTask._fromConnection(this._connection) {
    _connection.input!.listen((data) {
      _buffer += data;

      while (true) {
        // Если есть образец, и он полностью отправлен
        int index = _buffer.indexOf('t'.codeUnitAt(0));
        if (index >= 0 && _buffer.length - index >= 7) {
          final DataSample sample = DataSample(
              temperature1: (_buffer[index + 1] + _buffer[index + 2] / 100),
              temperature2: (_buffer[index + 3] + _buffer[index + 4] / 100),
              waterpHlevel: (_buffer[index + 5] + _buffer[index + 6] / 100),
              timestamp: DateTime.now());
          _buffer.removeRange(0, index + 7);

          samples.add(sample);
          notifyListeners(); // Примечание: Его не следует вызывать очень часто - в этом примере данные поступают каждую секунду, но если данных будет больше, они должны обновляться (включая перерисовку графиков) через некоторый фиксированный интервал, а не после каждой выборки.
 //print("${sample.timestamp.toString()} -> ${sample.temperature1} / ${sample.temperature2}");
        }
        // В противном случае сломается
        else {
          break;
        }
      }
    }).onDone(() {
      inProgress = false;
      notifyListeners();
    });
  }

  static Future<BackgroundCollectingTask> connect(
      BluetoothDevice server) async {
    final BluetoothConnection connection =
        await BluetoothConnection.toAddress(server.address);
    return BackgroundCollectingTask._fromConnection(connection);
  }

  void dispose() {
    _connection.dispose();
  }

  Future<void> start() async {
    inProgress = true;
    _buffer.clear();
    samples.clear();
    notifyListeners();
    _connection.output.add(ascii.encode('start'));
    await _connection.output.allSent;
  }

  Future<void> cancel() async {
    inProgress = false;
    notifyListeners();
    _connection.output.add(ascii.encode('stop'));
    await _connection.finish();
  }

  Future<void> pause() async {
    inProgress = false;
    notifyListeners();
    _connection.output.add(ascii.encode('stop'));
    await _connection.output.allSent;
  }

  Future<void> reasume() async {
    inProgress = true;
    notifyListeners();
    _connection.output.add(ascii.encode('start'));
    await _connection.output.allSent;
  }

  Iterable<DataSample> getLastOf(Duration duration) {
    DateTime startingTime = DateTime.now().subtract(duration);
    int i = samples.length;
    do {
      i -= 1;
      if (i <= 0) {
        break;
      }
    } while (samples[i].timestamp.isAfter(startingTime));
    return samples.getRange(i, samples.length);
  }
}