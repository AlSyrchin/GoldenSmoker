import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'numberpicker.dart';

class StatePicker extends GetxController{
  RxInt val = 0.obs;
  void newState(int newV){
    val.value = newV;
    update();
  }
  void restart (){
    val.value = 0;
  }
}

class Picker extends StatelessWidget {
  const Picker({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<StatePicker>(
        init: StatePicker(),
        builder: (_) => NumberPicker(
        value: _.val.value,
        minValue: 0,
        maxValue: 100,
        onChanged: (value)  {_.newState(value);},
      )
    );
  }
}

class StatePickerTime extends GetxController{
  RxInt h = 0.obs;
  RxInt m = 0.obs;
  void newStateH(int newH){
    h.value = newH;
    update();
  }
  void newStateMin(int newM){
    m.value = newM;
    update();
  }
  void restart (){
    h.value = 0;
    m.value = 0;
  }
}

class PickerTime extends StatelessWidget {
  const PickerTime({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return GetBuilder<StatePickerTime>(
        init: StatePickerTime(),
        builder: (_) => Row(
          mainAxisAlignment: MainAxisAlignment.center,
              children: [
                NumberPicker(
                  value: _.h.value,
                  minValue: 0,
                  maxValue: 12,
                  onChanged: (value) {
                    _.newStateH(value);
                  },
                ),
                NumberPicker(
                  value: _.m.value,
                  minValue: 0,
                  maxValue: 59,
                  onChanged: (value) {
                    _.newStateMin(value);
                  },
                )
              ],
            ));
  }
}

class StateBool extends GetxController{
  RxBool val = false.obs;
  void newState(){
    val.toggle();
    update();
  }
  void restart (){
    val.value = false;
  }
}

class PickerBool extends StatelessWidget {
  const PickerBool({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<StateBool>(
        init: StateBool(),
        builder: (on) => Switch(
              value: on.val.value,
              onChanged: (value) {
                on.newState();
              },
              activeTrackColor: Colors.amberAccent,
              activeColor: Colors.amber,
            ));
  }
}