import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit_bluetooth.dart';
import 'cubit_chat.dart';
import 'state_rules.dart';

class CubitRules extends Cubit<StateRules> {
  final CubitChat cubitChat;
  final CubitBluetooth cubitBluetooth;
  bool tboxUp = false;
  bool tprodUp = false;

  CubitRules(this.cubitChat, this.cubitBluetooth) : super(StateRules()){
    emit(state.copyWith(temperature: 0, tbox: cubitChat.state.tb, tprod: cubitChat.state.tp, btnSmoke: [!cubitChat.state.s, cubitChat.state.s], btnWater: [!cubitChat.state.w, cubitChat.state.w], btnExtractor: [!cubitChat.state.a, cubitChat.state.a]));
  
    cubitChat.stream.listen((event) {}).onData((data) {
      tboxUp = state.tbox > data.tb;
      tprodUp = state.tprod > data.tp;
      emit(state.copyWith(tbox: data.tb, tprod: data.tp, tboxUp: tboxUp, tprodUp: tprodUp, lamp: data.lamp, isWater: data.isWater));
    });
  }

  void nextBtn(int index, int isWho) {
    List<bool> newList = [];
    (index == 0) ? newList = [true,false] : newList = [false,true];
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
    // if (state.btnFlap.last) msgSwitched += '?';
    if (state.temperature != 0) msgRange = 'MB${state.temperature.round() * 10}';
    if (msgRange !='' && msgSwitched != '') end = '~';
    message = 'RM>$msgRange$end$msgSwitched';

    cubitBluetooth.sendMessage(message);
  }

  void toggleLamp() {
    String message;
    if (state.lamp) {message = 'L-';} else {message = 'L+';} 
    cubitBluetooth.sendMessage(message);
  }

    String toNameBtn(int isWho){
    String res;
    switch (isWho) {
        case 0: res = 'Заслонка';break;
        case 1: res = 'Дымоген';break;
        case 2: res = 'Пароген';break;
        case 3: res = 'Вытяжка';break;
        case 4: res = 'Тен';break;
        default: res = 'None';
      }
    return res;
  }

    IconData toIconBtn(int isWho){
    IconData res;
    switch (isWho) {
        case 0: res = Icons.extension;break;
        case 1: res = Icons.smoking_rooms_rounded;break;
        case 2: res = Icons.opacity;break;
        case 3: res = Icons.leak_add;break;
        case 4: res = Icons.texture_rounded;break;
        default: res = Icons.back_hand;
      }
    return res;
  }

  List<bool> isSelected(int isWho){
    List<bool> res;
    switch (isWho) {
        case 0: res = state.btnExtractor;break;
        case 1: res = state.btnSmoke;break;
        case 2: res = state.btnWater;break;
        case 3: res =  state.btnFlap;break;
        case 4: res = state.btnTens;break;
        default: res = [];
      }
    return res;
  }
}