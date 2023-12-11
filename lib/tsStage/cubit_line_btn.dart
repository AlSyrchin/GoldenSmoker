import 'package:flutter_bloc/flutter_bloc.dart';
import 'state_line_btn.dart';

class CubitLineBTN extends Cubit<StateLineBTN> {
  CubitLineBTN() : super(StateLineBTN());

  void nextBtn(int index) {
    List<bool> newList = [];
    newList.addAll(state.btnList);
    for (int i = 0; i < newList.length; i++) {
      newList[i] = i == index;
    }
    emit(state.copyWith(btnList: newList));
  }
}