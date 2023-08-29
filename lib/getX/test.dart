// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'constant.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData.dark(),
      home: const HomePage(),
      getPages: [
        GetPage(name: "/", page: () => const HomePage()),
      ],
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Title'),
      ),
      body: SafeArea(
          child: Container(
        color: mainFon,
        padding: const EdgeInsets.all(defaultPadding),
        alignment: Alignment.center,
        child: Column(
          children: [
            Row(
              children: [
                ToggleBtn(deviceCard[2]),
                const SizedBox(height: defaultPadding * 2),
                ToggleBtn(deviceCard[3]),
              ],
            ),
            const SizedBox(width: defaultPadding * 2),
            Row(
              children: [
                ToggleBtn(deviceCard[4]),
                const SizedBox(height: defaultPadding * 2),
                ToggleBtn(deviceCard[5]),
              ],
            )

        ],),
      )),
    );
  }
}


class StateToggle extends GetxController {
  RxList<bool> togWater = <bool>[true, false].obs;
  RxList<bool> togSmoke = <bool>[true, false].obs;
  RxList<bool> togFlap = <bool>[true, false].obs;
  RxList<bool> togFans = <bool>[true, false].obs;

  void toggleT(int index, String name) {
    for (int i = 0; i < togSmoke.length; i++) {
      if (name == deviceCard[2]) togWater[i] = i == index;
      if (name == deviceCard[3]) togSmoke[i] = i == index;
      if (name == deviceCard[4]) togFlap[i] = i == index;
      if (name == deviceCard[5]) togFans[i] = i == index;
    }
  }

    List<bool> listSelect(String name){
      List<bool> res = [];
      if (name == deviceCard[2]) res = togWater;
      if (name == deviceCard[3]) res = togSmoke;
      if (name == deviceCard[4]) res = togFlap;
      if (name == deviceCard[5]) res = togFans;
      return res;
  }
}

class ToggleBtn extends StatelessWidget {
  const ToggleBtn(this.name, {Key? key}) : super(key: key);
  final String name;

  @override
  Widget build(BuildContext context) {
    StateToggle tog = Get.put(StateToggle());
    return SizedBox(
      width: 203,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name),
          const SizedBox(height: 10),
          Obx(
            () => ToggleButtons(
                direction: Axis.horizontal,
                onPressed: (int index) {
                  tog.toggleT(index, name);
                },
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                selectedBorderColor: Colors.white,
                selectedColor: mainFon,
                fillColor: Colors.white,
                color: Colors.white,
                constraints: const BoxConstraints(
                  minHeight: 40.0,
                  minWidth: 80.0,
                ),
                isSelected: tog.listSelect(name),
                children: name == 'Заслонка' ? const [Text('Откр.'), Text('Закр.')] : const [Text('Вкл.'), Text('Выкл.')]
                ),
          ),
        ],
      ),
    );
  }
}


class StateRule extends GetxController{
  
}