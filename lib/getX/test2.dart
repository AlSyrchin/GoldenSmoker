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
      home: HomePage(),
      getPages: [
        GetPage(name: "/", page: () => HomePage()),
      ],
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Title'),),
      body: SafeArea(
          child: Container(
        color: mainFon,
        padding: const EdgeInsets.all(defaultPadding),
        alignment: Alignment.center,
        child: const Reorders()      
      )),
    );
  }
}



class StateReord extends GetxController{
  RxList<String> item = <String>[
    "GeeksforGeeks",
    "Flutter",
    "Developer",
    "Android",
    "Programming",
    "CplusPlus",
    "Python",
    "javascript"
  ].obs;

  void fromTo (int oldIndex, int newIndex){
    if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          final element = item.removeAt(oldIndex);
          item.insert(newIndex, element);
  }

  void removeInd (index){
    item.removeAt(index);
    update();
  }
}

class Reorders extends StatelessWidget {
  const Reorders({super.key});

  @override
  Widget build(BuildContext context) {
    return 
    GetBuilder(
      init: StateReord(),
      builder: (controller) => ReorderableListView.builder(
      onReorder: (oldIndex, newIndex) {
        controller.fromTo(oldIndex, newIndex);
      },
      itemCount: controller.item.length,
      itemBuilder: (BuildContext context, int index) => Dismissible(
        key: Key(controller.item[index]),
        onDismissed: (_){
          controller.removeInd(index);
        },
        child: Container(
            // key: ValueKey(index),
            color: Colors.amber,
            height: 50,
            child: Text('${controller.item[index]}')),
      ),
    ), 
      );
    
  }
}
