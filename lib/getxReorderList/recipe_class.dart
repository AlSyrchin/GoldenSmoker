import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'command_file.dart';

abstract class Stage {
  final tempB = 0.0.obs;
  final tempP = 0.0.obs;
  final time = '0000'.obs;
  final extractor = false.obs;//Вытяжка
  final smoke = false.obs;//Дымоген
  final water = false.obs;//Пароген
  final flap = false.obs;//Заслонка
  String name = '';
  String generateStringCommand();
}


class Related extends Stage {
  Related(double b, double p){
    name = 'Отепление';
    tempB.value = b;
    tempP.value = p;
  }

  
  @override
  String generateStringCommand() {
    return "$RECIPE_ADD${ACTION_INPUT}MP${convertDoubleFromString(tempP.value)}~M!TF";
  }

}

class Drying extends Stage {
  Drying(double b, double p, int t){
    name = 'Сушка';
    tempB.value = b;
    tempP.value = p;
    time.value = intFromStringTime(t);
    extractor.value = true;
    flap.value = true;
  }

  @override
  String generateStringCommand() {
    return "$RECIPE_ADD${ACTION_INPUT}MP${convertDoubleFromString(tempP.value)}MT${time.value}~M!TFA";
  }

}

class Boiling extends Stage {
  Boiling(double b, double p, int t){
    name = 'Варка';
    tempB.value = b;
    tempP.value = p;
    time.value = intFromStringTime(t);
    water.value = true;
  }

  @override
  String generateStringCommand() {
    return "$RECIPE_ADD${ACTION_INPUT}MP${convertDoubleFromString(tempP.value)}MT${time.value}~M!WTF";
  }


}

class Smoking extends Stage {
  Smoking(double b, double p, int t){
    name = 'Копчение';
    tempB.value = b;
    tempP.value = p;
    time.value = intFromStringTime(t);
    extractor.value = true;
    smoke.value = true;
  }

  @override
  String generateStringCommand() {
    return "$RECIPE_ADD${ACTION_INPUT}MB${convertDoubleFromString(tempB.value)}MT${time.value}~M!TFS";
  }
}

class Frying extends Stage {
  Frying(double b, double p){
    name = 'Жарка';
    tempB.value = b;
    tempP.value = p;
  }

  @override
  String generateStringCommand() {
    return "$RECIPE_ADD${ACTION_INPUT}MB${convertDoubleFromString(tempB.value)}~M!TF";
  }

}


String convertDoubleFromString(double param) {
  return '${(param * 10).toInt()}';
}

  String intFromStringTime(int m) {
    int h = m ~/ 60;
    m = m % 60;
    return '${NumberFormat('00').format(h)}${NumberFormat('00').format(m)}';
  }