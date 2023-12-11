import 'package:flutter_bloc/flutter_bloc.dart';
import 'stage.dart';
import 'state_creater.dart';
import 'cubit_bluetooth.dart';

class CubitCreater extends Cubit<StateCreater> {
  final CubitBluetooth cubitBluetooth;
  CubitCreater(this.cubitBluetooth) : super(StateCreater());

  void toggleBtn() {
    emit(state.copyWith(isSettings: !state.isSettings));
  }

    void restart() {
    emit(state.copyWith());
  }

  void delet(List<Stage> stage, int index) {
    if (stage.isEmpty) return;
    stage.removeAt(index);
    emit(state.copyWith());
  }

  void fromTo(List<Stage> stage, int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {newIndex -= 1;}
    final element = stage.removeAt(oldIndex);
    stage.insert(newIndex, element);
    emit(state.copyWith());
  }

    void start(Recipe recipe) {
    String newCom = 'RA_R!';
    for (var stage in recipe.stages) {newCom = '${newCom}_${stage.command}';}
    newCom = '${newCom}_RC';
    cubitBluetooth.sendMessage(newCom);
  }
}