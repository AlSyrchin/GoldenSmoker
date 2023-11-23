import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'constant.dart';
import 'picker.dart';
import 'package:intl/intl.dart';
import 'recipe_class.dart';


class CardWidget extends StatelessWidget {
  const CardWidget(this.index, {super.key});
  final int index;
  @override
  Widget build(BuildContext context) {
    StateStage stStage = Get.put(StateStage());
    return Container(
      width: 260,
      height: 325,
      margin: const EdgeInsets.symmetric(horizontal: defaultPadding),
      child: Card(
        child: Container(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              Text(stStage.stage[index].name),
              TitleAll(index, 't камеры', 'value'),
              TitleAll(index, 't продукта', 'value'),
              TitleAll(index, 'Заслонка', 'bool'),
              TitleAll(index, 'Пароген', 'bool'),
              TitleAll(index, 'Дымоген', 'bool'),
              TitleAll(index, 'Вытяжка', 'bool'),
              const Divider(),
              TitleTime(index),
            ],
          ),
        ),
      ),
    );
  }
}

class TitleAll extends StatelessWidget {
  const TitleAll(this.index, this.name, this.who, {Key? key}) : super(key: key);
  final String name;
  final int index;
  final String who;

  Widget goTrailingWidget(StateStage stStage){
    Widget newWidget = const Text('');
    if (name == 't камеры') newWidget = Text('${stStage.stage[index].tempB.value}$indicate');
    if (name == 't продукта') newWidget = Text('${stStage.stage[index].tempP.value}$indicate');
    if (name == 'Пароген' ) newWidget = stStage.stage[index].water.value ? const Text('Вкл.') : const Text('Выкл.');
    if (name == 'Дымоген' ) newWidget = stStage.stage[index].smoke.value ? const Text('Вкл.') : const Text('Выкл.');
    if (name == 'Вытяжка') newWidget = stStage.stage[index].extractor.value ? const Text('Вкл.') : const Text('Выкл.');
    if (name == 'Заслонка') newWidget = stStage.stage[index].flap.value ? const Text('Откр.') : const Text('Закр.');
    return newWidget;
  }

  @override
  Widget build(BuildContext context) {
    StateStage stStage = Get.put(StateStage());
    return ListTile(
            visualDensity: stWidg,
            dense: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 2),
            title: Text(name),
            trailing: Obx(() => goTrailingWidget(stStage)),
            onTap: () => showDialog(
                    context: context,
                    builder: (BuildContext context) => DialogAll(name,index, who)),
          );
  }
}

class TitleTime extends StatelessWidget {
  const TitleTime(this.index, {super.key});
  final int index;
  @override
  Widget build(BuildContext context) {
    StateStage stStage = Get.put(StateStage());
    return ListTile(
            visualDensity: stWidg,
            dense: true,
            contentPadding: EdgeInsets.zero,
            title: Obx(() => Center(child: Text(DateFormat.Hm().format(DateTime.parse('00000000T${stStage.stage[index].time}'))))),
            onTap: ()=> showDialog(
                    context: context,
                    builder: (BuildContext context) => DialogAll('Hours : min', index, 'timer')),
          );
  }
}

class DialogAll extends StatelessWidget {
  const DialogAll(
    this.name, this.index, this.who, {
    Key? key,
  }) : super(key: key);
  final String name;
  final int index;
  final String who;

  Widget goContentWidget() {
    Widget newWidget = const Text('');
    if (who == 'value') newWidget = const Picker();
    if (who == 'bool') newWidget = const PickerBool();
    if (who == 'timer') newWidget = const PickerTime();
    return newWidget;
  }

  void pressValue(String name, StateStage stStage, StatePicker pValue) {
    if (name == deviceCard[0]) stStage.editIndex(index, null, pValue.val.value.toDouble(), null);
    if (name == deviceCard[1]) stStage.editIndex(index, pValue.val.value.toDouble(), null, null);
    pValue.restart();
  }

  void pressTimer(StateStage stStage, StatePickerTime pTime) {
    stStage.editIndex(index, null, null, pTime.h.value * 60 + pTime.m.value);
    pTime.restart();
  }

  void pressBool(StateStage stStage, StateBool pBool) {
    // stStage.setBool(pBool.val.value, index);
    // pBool.restart();
  }

  @override
  Widget build(BuildContext context) {
    StateBool pBool = Get.put(StateBool());
    StatePicker pValue = Get.put(StatePicker());
    StatePickerTime pTime = Get.put(StatePickerTime());
    StateStage stStage = Get.put(StateStage());
    return AlertDialog(
      backgroundColor: mainFon,
      title: Center(child: Text(name)),
      content: goContentWidget(),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.amber)),
              child: const Text("Сохранить"),
              onPressed: () {
                    pressValue(name, stStage, pValue);
                    if (who == 'boolOnOff' || who == 'boolOpenClose') pressBool(stStage, pBool);
                    if (who == 'timer') pressTimer(stStage, pTime);
                Navigator.of(context).pop();
              })
      ]
    );
  }
}


