import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit_bluetooth.dart';
import 'cubit_text_input.dart';
import 'stage.dart';
import 'state_choise.dart';

class CubitChoise extends Cubit<StateChoise> {
  final CubitTextInput otherCubit;
  final CubitBluetooth cubitBluetooth;
  
  static final List<Recipe> initList = [
    Recipe('Курица', 'assets/images/001.png', 'info Курица', [Related(24,24.9), Boiling(26, 25, 10), Frying(26, 24)]),
    Recipe('Мясо', 'assets/images/002.png', 'info Мясо', [Related(25,17), Drying(23, 20, 10), Smoking(25, 27, 15), Frying(22, 25)]),
    Recipe('Колбаса', 'assets/images/003.png', 'info Колбаса', [Related(29,23), Drying(16, 16, 5), Smoking(25, 25, 6), Frying(27, 27), Related(29,23), Drying(16, 16, 5), Smoking(25, 25, 6), Frying(27, 27)]),
    Recipe('Котлеты', 'assets/images/004.png', 'info Котлеты', [Related(24, 23), Boiling(25, 48, 8), Frying(26, 22)]),
    Recipe('Тест', 'assets/images/001.png', 'info Тест', [Boiling(24, 24, 9), Drying(18, 17, 10), Smoking(1, 1, 7), Related(28, 27.5)])
  ];

  CubitChoise(this.otherCubit, this.cubitBluetooth) : super(StateChoise(stages: initList, queryStages: initList));

  void addRecipe(List<Stage> stage){
    Recipe newRecipe = Recipe(otherCubit.state, 'assets/images/005.png', 'inf', stage);
    List<Recipe> newState = state.stages;
    newState.add(newRecipe);
    emit(state.copyWith(stages: newState));
  }

  void stringSearch(String query) {
    final suggestions = state.stages.where((el) {
    final title = el.name.toLowerCase();
    final input = query.toLowerCase();
    return title.contains(input);
  } ).toList();
    emit(state.copyWith(query: query, queryStages: suggestions));
  }

  void btnSearch(){
    emit(state.copyWith(isSearch: !state.isSearch));
  }

  void nextBtn(){
    emit(state.copyWith(btnGrid: state.btnGrid.reversed.toList()));
  }
}