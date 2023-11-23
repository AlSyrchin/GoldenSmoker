import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit_one.dart';
import 'state_two.dart';

class CubitTwo extends Cubit<StateTwo> {
  final CubitOne otherCubit;

  CubitTwo(this.otherCubit) : super(StateTwo());

  void addItem(List<bool> btnList) {
    if (btnList[0]) {otherCubit.addRelated(state.tbox, state.tprod);}
    if (btnList[1]) {otherCubit.addDrying(state.tbox, state.tprod, state.time);}
    if (btnList[2]) {otherCubit.addBoiling(state.tbox, state.tprod, state.time);}
    if (btnList[3]) {otherCubit.addSmoking(state.tbox, state.tprod, state.time);}
    if (btnList[4]) {otherCubit.addFrying(state.tbox, state.tprod);}
    if (btnList[5]) {
      if (state.name.isEmpty) return;
      otherCubit.addUnique(state.name, state.tbox, state.tprod, state.time, state.extractor, state.smoke, state.water, state.flap, state.tens);
    }
  }

  void restart(){
    emit(state.copyWith(name: '', tbox: 0, tprod: 0, time: 0, extractor: false, smoke: false, water: false, flap: false, tens: false));
  }

  void toggleButton(int isWho, bool b) {
    switch(isWho){
      case 0: b == true ? emit(state.copyWith(extractor: true)) : emit(state.copyWith(extractor: false));
      case 1: b == true ? emit(state.copyWith(smoke: true)) : emit(state.copyWith(smoke: false));
      case 2: b == true ? emit(state.copyWith(water: true)) : emit(state.copyWith(water: false));
      case 3: b == true ? emit(state.copyWith(flap: true)) : emit(state.copyWith(flap: false));
      case 4: b == true ? emit(state.copyWith(tens: true)) : emit(state.copyWith(tens: false));
      default:
    }
  }


  void addName(String text) {
    emit(state.copyWith(name: text));
  }

  void addTime(String text) {
    int newTime = int.parse(text);
    emit(state.copyWith(time: newTime));
  }

  void addTbox(double number) {
    emit(state.copyWith(tbox: number));
}

  void addTprod(double number) {
    emit(state.copyWith(tprod: number));
}

  void nextBtn(int index) {
    List<bool> newList = [];
    newList.addAll(state.btnList);
    for (int i = 0; i < newList.length; i++) {
      newList[i] = i == index;
    }
    emit(state.copyWith(btnList: newList));
  }
}