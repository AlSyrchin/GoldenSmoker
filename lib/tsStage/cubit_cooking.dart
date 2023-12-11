import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit_bluetooth.dart';
import 'stage.dart';
import 'state_cooking.dart';

class CubitCooking extends Cubit<StateCooking> {
  final CubitBluetooth cubitBluetooth;
  CubitCooking(this.cubitBluetooth) : super(StateCooking()){
    cubitBluetooth.otherCubitChat.stream.listen((event) {}).onData((data) {
      emit(state.copyWith(tbox: data.tb, tprod: data.tp, time: data.timeNow, lamp: data.lamp, cookingPage: data.whisEtap));
      // if (state.activePage < data.whisEtap) state.pageController.jumpToPage(data.whisEtap);
      // nextPage(curve: Curves.easeIn, duration: Duration(milliseconds: 400)); 
    });
  }

  void toActive(int num) {
    emit(state.copyWith(activePage: num));
  }

  void btnBack() {
    cubitBluetooth.sendMessage('RS_R!');
    // state.pageController.jumpToPage(0);
    emit(state.copyWith(activePage: 0));
  }

    void btnNext(int i) {
    // cubitBluetooth.sendMessage('RS_R!');
    // state.pageController.jumpToPage(0);
    emit(state.copyWith(activePage: i));
  }

  // void stop() {
  //   state.pageController.jumpToPage(0);
  //   cubitBluetooth.sendMessage('RS');
  // }

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
}