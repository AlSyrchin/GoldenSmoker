import '../etap.dart';
import 'state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageCubit extends Cubit<ListState> {
  HomePageCubit() : super(ListState(stage: [Related(10, 20)]));

  void addStage() {
    emit(ListState(stage: state.addStage(Frying(5, 5))));
  }
  void remStage(int index) {
    emit(ListState(stage: state.removeStage(index)));
  }

  void fromTo(int oldIndex, int newIndex) {
    emit(ListState(stage: state.fromTo(oldIndex,newIndex)));
  }
}

//
// class HomePageCubit extends Cubit<HomePageState> {
//   HomePageCubit() : super(HomePageState(count: 0));

//   void incrementCounter() {
//     emit(HomePageState(count: state.count+1));
//   }
// }