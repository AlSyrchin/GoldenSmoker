import 'package:flutter_bloc/flutter_bloc.dart';
import 'stage.dart';
import 'state_one.dart';

class CubitOne extends Cubit<StateOne> {
  CubitOne() : super(StateOne());

  void addRelated(double tb, double tp) {
    final Stage st = Related(tb, tp);
    List<Stage> newState = [];
    newState.addAll(state.stage);
    newState.add(st);
    emit(state.copyWith(stage: newState));
  }

  void addDrying(double tb, double tp, int t) {
    final Stage st = Drying(tb, tp, t);
    List<Stage> newState = [];
    newState.addAll(state.stage);
    newState.add(st);
    emit(state.copyWith(stage: newState));
  }

  void addBoiling(double tb, double tp, int t) {
    final Stage st = Boiling(tb, tp, t);
    List<Stage> newState = [];
    newState.addAll(state.stage);
    newState.add(st);
    emit(state.copyWith(stage: newState));
  }

  void addSmoking(double tb, double tp, int t) {
    final Stage st = Smoking(tb, tp, t);
    List<Stage> newState = [];
    newState.addAll(state.stage);
    newState.add(st);
    emit(state.copyWith(stage: newState));
  }

  void addFrying(double tb, double tp) {
    final Stage st = Frying(tb, tp);
    List<Stage> newState = [];
    newState.addAll(state.stage);
    newState.add(st);
    emit(state.copyWith(stage: newState));
  }

    void addUnique(String n, double b, double p, int t, bool ex, bool sm, bool wa, bool fl, bool te,) {
    final Stage st = Unique(n, b, p, t, ex, sm, wa, fl, te);
    List<Stage> newState = [];
    newState.addAll(state.stage);
    newState.add(st);
    emit(state.copyWith(stage: newState));
  }

  void addName(String text) {
    emit(state.copyWith(name: text));
  }

  void delet(int index) {
    List<Stage> newState = [];
    newState.addAll(state.stage);
    if (newState.isEmpty) return;
    newState.removeAt(index);
    emit(state.copyWith(stage: newState));
  }

    void clearStages() {
      emit(state.copyWith(stage: []));
  }

  void fromTo(int oldIndex, int newIndex) {
    List<Stage> newState = [];
    newState.addAll(state.stage);
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final element = newState.removeAt(oldIndex);
    newState.insert(newIndex, element);
    emit(state.copyWith(stage: newState));
  }
}