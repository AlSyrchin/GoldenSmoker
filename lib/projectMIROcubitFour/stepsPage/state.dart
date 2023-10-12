import '../etap.dart';

abstract class ReciepState {
  const ReciepState();
}

class ListState {
  final List<Stage> stage;

  ListState({required this.stage});

  List<Stage> addStage(Stage st){
    stage.add(st);
    return stage;
  }

    List<Stage> removeStage(int index){
    stage.removeAt(index);
    return stage;
  }

   List<Stage> fromTo(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final element = stage.removeAt(oldIndex);
    stage.insert(newIndex, element);
    return stage;
  }
}



//
class HomePageState {
  final int count;

  const HomePageState({required this.count});
}