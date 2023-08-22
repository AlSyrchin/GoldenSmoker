import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'getxGolden.dart';
import 'goldenWidget.dart';
import 'numberpicker.dart';
import 'reciept.dart';
import 'timer.dart';

const String indicate = '°';
const style20t = TextStyle(fontSize: 20, color: Colors.black);
const style24t = TextStyle(fontSize: 24, color: Colors.black);
const style20f = TextStyle(fontSize: 20, color: Colors.black26);
const style24f = TextStyle(fontSize: 24, color: Colors.black26);


class ListViewCard extends StatelessWidget {
  const ListViewCard({
    Key? key,
    required this.name,
    this.tBox,
    this.tProd,
    this.time,
    this.parogen,
    this.compres,
    this.zaslon,
  }) : super(key: key);
  final String name;
  final double? tBox;
  final double? tProd;
  final int? time;
  final bool? parogen;
  final bool? compres;
  final bool? zaslon;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(name, style: style24t),
      TitleNew(deviceStep[0], value: tBox ?? tProd),
      TitleNew(deviceStep[1], value: tProd ?? tBox),
      TitleNew(deviceStep[2], valStr: parogen),
      TitleNew(deviceStep[3], valStr: compres),
      TitleNew(deviceStep[4], valStr: zaslon),
      const Divider(color: Colors.black26),
      time != null
          ? Text('00:$time', style: style24t)
          : const Text('00:00', style: style24f)
    ]);
  }

// Таймер ставится при запуске шага
//TimerSec(DateTime.now().add(Duration(seconds: time!)))
  TimerBuilder timerSec(DateTime alert) {
    return TimerBuilder.scheduled([alert], builder: (context) {
      var now = DateTime.now();
      var reached = now.compareTo(alert) >= 0;
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            !reached
                ? TimerBuilder.periodic(const Duration(seconds: 1),
                    alignment: Duration.zero, builder: (context) {
                    var now = DateTime.now();
                    var remaining = alert.difference(now);
                    return Text(formatDuration(remaining), style: style24t);
                  })
                : const Text(
                    "00:00",
                    style: style24f,
                  ),
          ],
        ),
      );
    });
  }
}

List<String> deviceStep = [
  't камеры',
  't продукта',
  'Пароген',
  'Компрессор',
  'Заслонка',
];

class TitleNew extends StatelessWidget {
  const TitleNew(this.name, {this.value, this.valStr, super.key});
  final double? value;
  final bool? valStr;
  final String name;
  @override
  Widget build(BuildContext context) {
    const stWidg = VisualDensity(horizontal: 0, vertical: -4);
    return value != null
        ? ListTile(
            visualDensity: stWidg,
            dense: true,
            onTap: () => value != null
                ? showDialog(
                    context: context,
                    builder: (BuildContext context) => DialogValue(name, value!))
                : () {},
            title: Text(name, style: style24t),
            trailing: Text('${value!.toInt()}$indicate', style: style24t),
          )
        : ListTile(
            visualDensity: stWidg,
            dense: true,
            onTap: () => valStr != null
                ? showDialog(
                    context: context,
                    builder: (BuildContext context) => DialogOnOff(name))
                : () {},
            title: valStr != null
                ? Text(name, style: style24t)
                : Text(name, style: style24f),
            trailing: valStr != null
                ? const Text('Вкл.', style: style20t)
                : const Text('Выкл.', style: style20f),
          );
  }
}

class DialogValue extends StatelessWidget {
  const DialogValue(
    this.name, this.value, {
    Key? key,
  }) : super(key: key);
  final String name;
  final double value;
  @override
  Widget build(BuildContext context) {
    RecipeController recipeController = Get.put(RecipeController());
    return AlertDialog(
      backgroundColor: mainFon,
      title: Text(name),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Picker(),
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.amber)),
              child: const Text("Select"),
              onPressed: () {
                recipeController.editStageIndex(0, 25, 35);
                recipeController.update();
              })
        ],
      ),
    );
  }
}

class DialogOnOff extends StatelessWidget {
  const DialogOnOff(
    this.name, {
    Key? key,
  }) : super(key: key);
  final String name;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: mainFon,
      title: Text(name),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SwitchControlsWater(),
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.amber)),
              child: const Text("Select"),
              onPressed: () {})
        ],
      ),
    );
  }
}

class StatePicker extends GetxController{
  RxInt val = 10.obs;
  void newState(int newV){
    val.value = newV;
  }
}

class Picker extends StatelessWidget {
  const Picker({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<StatePicker>(
      init: StatePicker(),
      builder: (_) => NumberPicker(
      value: _.val.value,
      minValue: 0,
      maxValue: 100,
      onChanged: (value) => _.newState(value),
    )
      );
    
  }
}
