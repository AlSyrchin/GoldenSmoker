class UsersRepository{
  UserProvider _usersProvider = UserProvider();
  Future<List<String>>getAllUsers() => _usersProvider.getUser();
}


class UserProvider{
  Future<List<String>> getUser() async{
    return await [];
  }
}