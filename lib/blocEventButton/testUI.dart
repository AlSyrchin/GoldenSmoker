import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'testBloc.dart';
import 'testEvent.dart';
import 'testRepository.dart';
import 'testState.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final usersRepository = UsersRepository();
  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserBloc>(
      create: (context) => UserBloc(usersRepository),
      child: const Scaffold(
          body: Column(
        children: [
          ButtonAct(), 
          ListW()
          ],
      )),
    );
  }
}

class ListW extends StatelessWidget {
  const ListW({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(builder: (context, state) {
      if (state is UserEmptyState){
        return const Text('Empty');
      }
      if (state is UserLoadingState){
        return const Text('Loading');
      } 
      if (state is UserLoadedState){
        return const Text('Hi');
      }
      if (state is UserErrorState){
        return const Text('Error');
      }
      return Container();
    },
    );
  }
}

class ButtonAct extends StatelessWidget {
  const ButtonAct({super.key});

  @override
  Widget build(BuildContext context) {
    final UserBloc userBloc = context.read<UserBloc>(); 
    return Row(children: [ 
      ElevatedButton(onPressed: (){userBloc.add(UserLoadEvent());}, child: const Text('Load')),
      ElevatedButton(onPressed: (){userBloc.add(UserClearEvent());}, child: const Text('Clear'))
    ],);
  }
}