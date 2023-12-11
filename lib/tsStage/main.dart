import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit_creater.dart';
import 'page_choise.dart';
import 'page_rules.dart';
import 'page_settings.dart';
import 'cubit_chat.dart';
import 'cubit_bluetooth.dart';
import 'cubit_rules.dart';
import 'cubit_cooking.dart';
import 'cubit_choise.dart';
import 'cubit_time.dart';
import 'page_navigator.dart';
import 'cubit_text_input.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    final cubitOne = CubitTextInput();
    final cubitChat = CubitChat();
    final cubitBluetooth = CubitBluetooth(cubitChat);
    return MultiBlocProvider(
      providers: [
        BlocProvider<CubitTextInput>(create: (context) => cubitOne),
        BlocProvider<CubitChoise>(create: (context) => CubitChoise(cubitOne, cubitBluetooth)),
        BlocProvider<CubitBluetooth>(create: (context) => cubitBluetooth),
        BlocProvider<CubitChat>(create: (context) => cubitChat),
        BlocProvider<CubitRules>(create: (context) => CubitRules(cubitChat, cubitBluetooth)),
        BlocProvider<CubitCooking>(create: (context) => CubitCooking(cubitBluetooth)),
        BlocProvider<CubitCreater>(create: (context) => CubitCreater(cubitBluetooth)),
        BlocProvider<CubitTime>(create: (context) => CubitTime())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Bloc Example',
        theme: ThemeData.dark(
          // platform: TargetPlatform.iOS // переход на ios 
        ),
        home: const PageNavigator(),
        routes: {
          '/choise':(context) => const PageChoise(),
          '/rules':(context) => const PageRules(),
          '/settings':(context) => const PageSettings(),
        },
      ),
    );
  }
}