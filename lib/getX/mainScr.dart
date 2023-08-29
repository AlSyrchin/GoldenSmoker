import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'constant.dart';
import 'recipeClass.dart';
import 'recipeWidget.dart';

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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: double.infinity,
              height: 325,
              child: GetBuilder<StateStage>(
                init: StateStage(),
                builder: (cont) => ReorderableListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: cont.stage.length,
                    itemBuilder: (context, index) => 
                    Dismissible(
                        key: ValueKey(cont.stage[index]),
                        direction: DismissDirection.vertical,
                        onDismissed: (_) {
                          cont.removeIndex(index);
                        },
                        child: CardWidget(key: ValueKey(index), index)),
                    onReorder: (oldIndex, newIndex) {
                      cont.fromTo(oldIndex, newIndex);
                    }),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              SizedBox(
              width: 300,
              height: 96,
              child: ElevatedButton(onPressed: (){}, child: const Text('Старт!'))),
              const SizedBox(width: defaultPadding),
              SizedBox(
              width: 300,
              height: 96,
              child: ElevatedButton(onPressed: (){}, child: const Text('Добавить')))
            ],)
          ],
        ),
      )),
    );
  }
}