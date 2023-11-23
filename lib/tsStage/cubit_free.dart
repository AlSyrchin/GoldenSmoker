import 'package:flutter_bloc/flutter_bloc.dart';
import 'state_free.dart';

class CubitFree extends Cubit<StateFree> {
  CubitFree() : super(StateFree());

  void nextBtn(int index) {
    List<bool> newList = [];
    newList.addAll(state.btnList);
    for (int i = 0; i < newList.length; i++) {
      newList[i] = i == index;
    }
    emit(state.copyWith(btnList: newList));
  }
}