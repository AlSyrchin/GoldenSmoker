import 'state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit() : super(HomePageState(count: 0));

  void incrementCounter() {
    emit(HomePageState(count: state.count+1));
  }
}