import 'package:bloc/bloc.dart';
import 'testRepository.dart';
import 'testEvent.dart';
import 'testState.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UsersRepository usersRepository;
  UserBloc(this.usersRepository) : super (UserEmptyState()){
    on<UserLoadEvent>((event, emit) async{
      emit(UserLoadingState());
      try{
        final List<String> loadedUserList = await ['1','2']; //usersRepository.getAllUsers()
        emit(UserLoadedState(loadedUser: loadedUserList));
      }catch (_){
        emit(UserErrorState());
      }
    });
    on<UserClearEvent>((event, emit) async{
      emit(UserEmptyState());
    });
  }
}
