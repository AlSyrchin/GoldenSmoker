//Храним данные

import 'dart:math';
import 'etap.dart';

class ListState {
  final List<Stage> stage = [];

  List<Stage> addStage(Stage st){
    stage.add(st);
    return stage;
  }

    List<Stage> removeStage(int index){
    stage.removeAt(index);
    return stage;
  }
}

class NetworkException implements Exception {}