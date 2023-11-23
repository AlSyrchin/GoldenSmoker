import 'package:get/get.dart';

import 'recipe_class.dart';

double h(double height){
  return Get.height * height/990; 
}
double w(double width){
  return Get.width * width/1440; 
}

class StateStage extends GetxController{
  RxList<Stage> stage = <Stage>[Related(1, 1), Drying(2, 2, 2), Boiling(3, 3, 3), Smoking(4, 4, 4), Frying(5, 5)].obs;
  int indexCurrent = 0;

  void addRelated(double p, double b, int t){
    stage.add(Related(b, p));
    refresh();
  }
    void addDrying(double p, double b, int t){
    stage.add(Drying(b, p, t));
    refresh();
  }
  void addBoiling(double p, double b, int t) {
    stage.add(Boiling(b, p, t));
    refresh();
  }
    void addSmoking(double p, double b, int t){
    stage.add(Smoking(b, p, t));
    refresh();
  }
    void addFrying(double p, double b, int t){
    stage.add(Frying(b, p));
    refresh();
  }
  
  void removeIndex(int index) {
    if (stage.isNotEmpty) stage.removeAt(index);
    refresh();
  }

  void editIndex(int index, double? p, double? b, int? t) {
    stage[index].tempP.value = p ?? stage[index].tempP.value;
    stage[index].tempB.value = b ?? stage[index].tempB.value;
    if (t != null) stage[index].time.value = intFromStringTime(t);
  }

  void fromTo(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final element = stage.removeAt(oldIndex);
    stage.insert(newIndex, element);
  }

   String sendRecipe() {
    return stage.map<String>((e) => e.generateStringCommand()).join('_');
  }
}