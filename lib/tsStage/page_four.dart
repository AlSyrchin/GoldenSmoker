import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit_bluetooth.dart';
import 'page_five.dart';
import 'constant.dart';
import 'page_one.dart';
import 'page_six.dart';
import 'state_bluetooth.dart';
import 'widgets.dart';

class PageFour extends StatelessWidget {
  const PageFour({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainFon,
        title: BlocBuilder<CubitBluetooth, StateBluetooth>(
          builder: (context, state) => state.bluetoothState.stringValue == 'STATE_ON' ? const Icon(Icons.bluetooth, color: Colors.amber) : const Icon(Icons.bluetooth_disabled, color: Colors.grey)),
        ),
      backgroundColor: mainFon,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        SizedBox(
          width: 250,
          height: 400,
          child: InkWell(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const PageSix(),)), 
            child: const ContanerRadius(Colors.white, 'Готовим по рецепту', 1)),
        ),
        const SizedBox(width: 20),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          SizedBox(
            width: 250,
            height: 190,
            child: InkWell(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const PageFive(),)), 
              child: const ContanerRadius(Colors.white, 'Прямое управление', 1)),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 250,
            height: 190,
            child: InkWell(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const PageOne(),)), 
              child: const ContanerRadius(Colors.white, 'Создать рецепт', 1)),
          )
        ],)
      ],)  
    );
  }
}