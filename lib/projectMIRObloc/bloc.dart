import 'package:bloc/bloc.dart';
import 'event.dart';
import 'state.dart';

class UserBloc extends Bloc<Event, State> {
  UserBloc() : super (UserEmptyState()){
    on<RecipeAddEvent>((event, emit) async{
      emit(UserLoadingState());
      try{
        emit(UserLoadedState());
      }catch (_){
        emit(UserErrorState());
      }
    });
    on<LoadEvent>((event, emit) async{
      emit(UserEmptyState());
    });
  }
}