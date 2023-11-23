import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit_bluetooth.dart';
import 'cubit_chat.dart';
import 'state_five.dart';

class CubitFive extends Cubit<StateFive> {
  final CubitChat cubitChat;
  final CubitBluetooth cubitBluetooth;
  bool tboxUp = false;
  bool tprodUp = false;

  CubitFive(this.cubitChat, this.cubitBluetooth) : super(StateFive()){
    emit(state.copyWith(temperature: cubitChat.state.tb, tbox: cubitChat.state.tb, tprod: cubitChat.state.tp, btnSmoke: [!cubitChat.state.s, cubitChat.state.s], btnWater: [!cubitChat.state.w, cubitChat.state.w], btnExtractor: [!cubitChat.state.a, cubitChat.state.a]));
  
    cubitChat.stream.listen((event) {}).onData((data) {
      if (state.tbox > data.tb) {tboxUp = false;} else {tboxUp = true;}
      if (state.tprod > data.tp) {tprodUp = false;} else {tprodUp = true;}
      emit(state.copyWith(tbox: data.tb, tprod: data.tp, tboxUp: tboxUp, tprodUp: tprodUp));
    });
  }

  void nextBtn(int index, int isWho) {
    List<bool> newList = [];

    if (index == 0) {
      newList = [true,false];
    } else {
      newList = [false,true];
    }

    switch (isWho){
      case 0: emit(state.copyWith(btnExtractor: newList));
      case 1: emit(state.copyWith(btnSmoke: newList));
      case 2: emit(state.copyWith(btnWater: newList));
      case 3: emit(state.copyWith(btnFlap: newList));
      case 4: emit(state.copyWith(btnTens: newList));
    }
    upD();
  }

  void addT(double number) {
    emit(state.copyWith(temperature: number));
  }

  void upD(){
    String message = '';
    String msgSwitched = '';
    String msgRange = '';
    String end = '';
    if (state.btnExtractor.last || state.btnSmoke.last || state.btnWater.last) msgSwitched += 'M!';
    if (state.btnExtractor.last) msgSwitched += 'A';
    if (state.btnSmoke.last) msgSwitched += 'S';
    if (state.btnWater.last) msgSwitched += 'W';
    if (state.temperature != 0) msgRange = 'MB${state.temperature.round() * 10}';
    if (msgRange !='' && msgSwitched != '') end = '~';
    message = 'RM>$msgRange$end$msgSwitched';

    cubitBluetooth.sendMessage(message);
  }
}