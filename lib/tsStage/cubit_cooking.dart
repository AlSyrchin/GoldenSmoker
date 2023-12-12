import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit_bluetooth.dart';
import 'stage.dart';
import 'state_cooking.dart';
import 'widgets.dart';

class CubitCooking extends Cubit<StateCooking> {
  final CubitBluetooth cubitBluetooth;
  CubitCooking(this.cubitBluetooth) : super(StateCooking()){
    cubitBluetooth.otherCubitChat.stream.listen((event) {}).onData((data) {
      emit(state.copyWith(tbox: data.tb, tprod: data.tp, time: data.timeNow, lamp: data.lamp, cookingPage: data.whisEtap));
    });
  }

  void toActive(int num) {
    emit(state.copyWith(activePage: num));
  }

  void btnBack() {
    cubitBluetooth.sendMessage('RS_R!');
    emit(state.copyWith(activePage: 0));
  }

    void btnNext(int i) {
    emit(state.copyWith(activePage: i));
  }

  void pause() {
    cubitBluetooth.sendMessage('RP');
  }

  void start(Recipe recipe) {
    String newCom = 'RA_R!';
    for (var stage in recipe.stages) {
      newCom = '${newCom}_${stage.command}';
    }
    newCom = '${newCom}_RC';
    cubitBluetooth.sendMessage(newCom);
  }

  void toggleLamp() {
    String message;
    if (state.lamp) {message = 'L-';} else {message = 'L+';} 
    cubitBluetooth.sendMessage(message);
  }

  String getTime(int time, int index){
    if (time == 0) {return '∞';} 
    else if (state.cookingPage == index) {return getTimeString(state.time);}
    else return getTimeString(time);
  }
}