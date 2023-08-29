import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'commandFile.dart';
import 'recieptsStep.dart';


class StateStage extends GetxController{
  RxList<Stage> stage = <Stage>[Related(1, 1), Drying(2, 2, 2), Boiling(3, 3, 3), Smoking(4, 4, 4), Frying(5, 5)].obs;
  int indexCurrent = 0;

  void addRelated(double p, double b, int t){
    stage.add(Related(b, p));
    update();
  }
    void addDrying(double p, double b, int t){
    stage.add(Drying(b, p, t));
    update();
  }
  void addBoiling(double p, double b, int t) {
    stage.add(Boiling(b, p, t));
    update();
  }
    void addSmoking(double p, double b, int t){
    stage.add(Smoking(b, p, t));
    update();
  }
    void addFrying(double p, double b, int t){
    stage.add(Frying(b, p));
    update();
  }
  
  void removeIndex(int index) {
    if (stage.isNotEmpty) stage.removeAt(index);
    update();
  }

  void editIndex(int index, double? p, double? b, int? t) {
    stage[index].tempP.value = p ?? stage[index].tempP.value;
    stage[index].tempB.value = b ?? stage[index].tempB.value;
    if (t != null) stage[index].time.value = intFromStringTime(t);
  }

  void fromTo(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final element = stage.removeAt(oldIndex);
    stage.insert(newIndex, element);
  }

   String sendRecipe() {
    return stage.map<String>((e) => e.generateStringCommand()).join('_');
  }

  Widget allStageWidget() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: stage.length,
      itemBuilder: (context, index) => Card(
        color: Colors.white,
        child: SizedBox(
          width: 260,
          height: 325,
          child: Column(
            children: [
              stage[index].generateWidgetInfo(index),
              IconButton(
                onPressed: () => removeIndex(index),
                icon: const Icon(Icons.delete, color: Colors.red),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget widgetCurrentStage() {
    return stage[indexCurrent].generateWidgetInfo(indexCurrent);
  }
}


abstract class Stage {
  final tempB = 0.0.obs;
  final tempP = 0.0.obs;
  final time = '0000'.obs;
  final extractor = false.obs;//Вытяжка
  final smoke = false.obs;//Дымоген
  final water = false.obs;//Пароген
  final flap = false.obs;//Заслонка
  String name = '';
  String generateStringCommand();
  Widget generateWidgetInfo(int index);
}


class Related extends Stage {
  Related(double b, double p){
    name = 'Отепление';
    tempB.value = b;
    tempP.value = p;
  }

  
  @override
  String generateStringCommand() {
    return "$RECIPE_ADD${ACTION_INPUT}MP${convertDoubleFromString(tempP.value)}~M!TF";
  }

  @override
  Widget generateWidgetInfo(int index) {
    // return ListViewCard(index: index, name: name, tProd: tempP.value);
    return Text('1');
  }
}

class Drying extends Stage {
  Drying(double b, double p, int t){
    name = 'Сушка';
    tempB.value = b;
    tempP.value = p;
    time.value = intFromStringTime(t);
    extractor.value = true;
    flap.value = true;
  }

  @override
  String generateStringCommand() {
    return "$RECIPE_ADD${ACTION_INPUT}MP${convertDoubleFromString(tempP.value)}MT${time.value}~M!TFA";
  }

  @override
  Widget generateWidgetInfo(int index) {
    // return ListViewCard(index: index, name: name, tProd: tempP.value, time: time.value, flap: flap.value, extractor: extractor.value);
    return Text('1');
  }

}

class Boiling extends Stage {
  Boiling(double b, double p, int t){
    name = 'Варка';
    tempB.value = b;
    tempP.value = p;
    time.value = intFromStringTime(t);
    water.value = true;
  }

  @override
  String generateStringCommand() {
    return "$RECIPE_ADD${ACTION_INPUT}MP${convertDoubleFromString(tempP.value)}MT${time.value}~M!WTF";
  }

  @override
  Widget generateWidgetInfo(int index) {
    // return ListViewCard(index: index, name: name, tProd: tempP.value,time: time.value, water: water.value);
    return Text('1');
  }

}

class Smoking extends Stage {
  Smoking(double b, double p, int t){
    name = 'Копчение';
    tempB.value = b;
    tempP.value = p;
    time.value = intFromStringTime(t);
    extractor.value = true;
    smoke.value = true;
  }

  @override
  String generateStringCommand() {
    return "$RECIPE_ADD${ACTION_INPUT}MB${convertDoubleFromString(tempB.value)}MT${time.value}~M!TFS";
  }

  @override
  Widget generateWidgetInfo(int index) {
    // return ListViewCard(index: index, name: name, tBox: tempB.value, time: time.value, smoke: smoke.value, extractor: extractor.value);
    return Text('1');
  }

}

class Frying extends Stage {
  Frying(double b, double p){
    name = 'Жарка';
    tempB.value = b;
    tempP.value = p;
  }

  @override
  String generateStringCommand() {
    return "$RECIPE_ADD${ACTION_INPUT}MB${convertDoubleFromString(tempB.value)}~M!TF";
  }

  @override
  Widget generateWidgetInfo(int index) {
    // return ListViewCard(index: index, name: name, tProd: tempB.value);
    return Text('1');
  }

}


String convertDoubleFromString(double param) {
  return '${(param * 10).toInt()}';
}

  String intFromStringTime(int m) {
    int h = m ~/ 60;
    m = m % 60;
    return '${NumberFormat('00').format(h)}${NumberFormat('00').format(m)}';
  }