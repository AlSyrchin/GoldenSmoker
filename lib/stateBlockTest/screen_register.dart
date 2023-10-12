import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'register_bloc.dart';


void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    return MaterialApp(
      theme: ThemeData.dark(),
      home: WidMain(),
    );
  }
}

class WidMain extends StatelessWidget {
  const WidMain({super.key});

  @override
   Widget build(BuildContext context) { 
    return Scaffold( 
       
       body: GestureDetector( 
           onTap: () => FocusScope.of(context).unfocus(), 
           child: SafeArea( 
                        child: BlocProvider( 
                         create: (context) => RegisterBloc(), 
                         child: const RegisterView(), 
                      ), 
                   ),
          )); 
       } 
    } 

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) =>  SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text('Please provide Your basic information: ${context.read<RegisterBloc>().state.name}'),
            TextField(
              onChanged: (value) => context.read<RegisterBloc>().add(RegisterEventName(value)),
            )
          ],
        ),
      ) ,
    );
  }
}
    