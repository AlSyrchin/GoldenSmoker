import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class CubitTime extends Cubit<String> {
  CubitTime() : super(DateFormat('hh:mm').format(DateTime.now())){
    Timer.periodic(const Duration(minutes: 1), (timer) {emit(DateFormat('hh:mm').format(DateTime.now()));});
  }
}