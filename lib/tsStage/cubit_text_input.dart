import 'package:flutter_bloc/flutter_bloc.dart';

class CubitTextInput extends Cubit<String> {
  CubitTextInput() : super('');

  void addName(String text) {
    emit(text);
  }

    void restart() {
    emit('');
  }
}