abstract class UserState{}

class UserLoadingState extends UserState{}

class UserEmptyState extends UserState{}

class UserLoadedState extends UserState {
  List<dynamic> loadedUser;
  UserLoadedState({required this.loadedUser}) : assert(loadedUser.isNotEmpty);
}

class UserErrorState extends UserState{}