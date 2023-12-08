import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit_bluetooth.dart';
import 'cubit_one.dart';
import 'stage.dart';
import 'state_six.dart';

class CubitSix extends Cubit<StateSix> {
  final CubitOne otherCubit;
  final CubitBluetooth cubitBluetooth;
  
  static final List<Recipe> initList = [
    Recipe('Курица', 'assets/images/001.png', 'info Курица', [Related(24,24.9), Boiling(26, 25, 10), Frying(26, 24)]),
    Recipe('Мясо', 'assets/images/002.png', 'info Мясо', [Related(25,17), Drying(23, 20, 10), Smoking(25, 27, 15), Frying(22, 25)]),
    Recipe('Колбаса', 'assets/images/003.png', 'info Колбаса', [Related(29,23), Drying(16, 16, 5), Smoking(25, 25, 6), Frying(27, 27), Related(29,23), Drying(16, 16, 5), Smoking(25, 25, 6), Frying(27, 27)]),
    Recipe('Котлеты', 'assets/images/004.png', 'info Котлеты', [Related(24, 23), Boiling(25, 48, 8), Frying(26, 22)]),
    Recipe('Тест', 'assets/images/001.png', 'info Тест', [Boiling(24, 24, 9), Drying(18, 17, 10), Smoking(1, 1, 7), Related(28, 27.5)])
  ];

  CubitSix(this.otherCubit, this.cubitBluetooth) : super(StateSix(stages: initList, queryStages: initList));

  void addRecipe(){
    Recipe newRecipe = Recipe(otherCubit.state.name, 'assets/images/005.png', 'inf', otherCubit.state.stage);
    List<Recipe> newState = state.stages;
    newState.add(newRecipe);
    emit(state.copyWith(stages: newState));
  }

  // void loadRecipe(Recipe recipe) {
  //   String newCom = 'RA_R!';
  //   for (var stage in recipe.stages) {
  //     newCom = '${newCom}_${stage.command}';
  //   }
  //   cubitBluetooth.sendMessage(newCom);
  // }

  void addString(String query) {

  // List<Recipe> stages = [];
    final suggestions = state.stages.where((el) {
    final title = el.name.toLowerCase();
    final input = query.toLowerCase();
    return title.contains(input);
  } ).toList();
    emit(state.copyWith(query: query, queryStages: suggestions));
  }

  void onSearch(){
    emit(state.copyWith(isSearch: true));
  }
  
  void offSearch(){
    emit(state.copyWith(isSearch: false));
  }
}