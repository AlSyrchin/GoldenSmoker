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
    StS stS = Get.put(StS());
    return Scaffold(
      appBar: AppBar(title: const Text('Title'),),
      body: SafeArea(
          child: Container(
        color: mainFon,
        padding: const EdgeInsets.all(defaultPadding),
        alignment: Alignment.center,
        child:   Column(
          children: [
            Obx(() => Clone(stS.item[0].s,stS.item[0].i)),
            Obx(() => Clone(stS.item[1].s,stS.item[1].i)),

            Obx(() => Clone(stS.user.value.s,stS.user.value.i)),

            Obx(() => Clone(stS.itemS[0].s.value, stS.itemS[0].i.value )),
            Obx(() => Clone(stS.itemS[1].s.value, stS.itemS[1].i.value )),
        
        ],)
      )),
    );
  }
}


class CC {
  final i = 0.obs;
  final s = '0'.obs;
}

class C {
  int i;
  String s;
  C(this.i,this.s);
}

class StS extends GetxController{
  RxList<C> item = <C>[C(1,'1'), C(2,'2') ].obs;
  RxList<CC> itemS = <CC>[CC()].obs;
  final user = C(1,'1').obs;

  void editItem(){
    itemS.add(CC());
    itemS.add(CC());
    itemS[0].i.value = 10;
    itemS[0].s.value = '10';


    // user.update((val) {val!.i = 10; val.s = 's';});

    // item[0].i = 10;
    // item[0].s = 'str';
    // item.refresh();

    // item.removeAt(0);
    // item.insert(0, C(10,'str'));
  }
}

class Clone extends StatelessWidget {
  const Clone(this.text, this.number,{Key? key}) : super(key: key);
  final String text;
  final int number;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(text),
      trailing: Text('$number'),
    );
  }
}

