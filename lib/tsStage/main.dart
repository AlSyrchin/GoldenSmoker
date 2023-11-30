import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goldensmoker/tsStage/cubit_eigth.dart';
import 'cubit_chat.dart';
import 'cubit_bluetooth.dart';
import 'cubit_five.dart';
import 'cubit_seven.dart';
import 'cubit_six.dart';
import 'page_four.dart';
import 'cubit_one.dart';
import 'cubit_two.dart';

// void main() { runApp(const MyApp());}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    final cubitOne = CubitOne();
    final cubitChat = CubitChat();
    final cubitBluetooth = CubitBluetooth(cubitChat);
    return MultiBlocProvider(
      providers: [
        BlocProvider<CubitTwo>(create: (context) => CubitTwo(cubitOne)),
        BlocProvider<CubitOne>(create: (context) => cubitOne),
        BlocProvider<CubitSix>(create: (context) => CubitSix(cubitOne, cubitBluetooth)),
        BlocProvider<CubitBluetooth>(create: (context) => cubitBluetooth),
        BlocProvider<CubitChat>(create: (context) => cubitChat),
        BlocProvider<CubitFive>(create: (context) => CubitFive(cubitChat, cubitBluetooth)),
        BlocProvider<CubitSeven>(create: (context) => CubitSeven(cubitBluetooth)),
        BlocProvider<CubitEigth>(create: (context) => CubitEigth(cubitBluetooth))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Bloc Example',
        theme: ThemeData.dark(
          // platform: TargetPlatform.iOS // переход на ios 
        ),
        home: const PageFour(),
      ),
    );
  }
}