import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'constant.dart';
import 'state_menager.dart';
import 'widgets.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    return GetMaterialApp(
      theme: ThemeData.dark(),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
          child: SafeArea(child: StepsReorder())),
    );
  }
}

class StepsReorder extends StatelessWidget {
  const StepsReorder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Шаги рецепта', style: TextStyle(fontSize: 26)),
        centerTitle: true,
        backgroundColor: mainFon,
      ),
      backgroundColor: mainFon,
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
              height: h(662),
              child: GetBuilder<StateStage>(
                init: StateStage(),
                builder: (c) => ReorderableListView.builder(
                  buildDefaultDragHandles: false,
                  padding: EdgeInsets.symmetric(horizontal: w(152)),
                  itemCount: c.stage.length,
                  itemBuilder: (context, index) => ListTile(
                    horizontalTitleGap: 8,
                    key: ValueKey(c.stage[index]),
                    leading: ReorderableDragStartListener(
                      index: index,
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.apps,
                              size: 22,
                              color: Color.fromRGBO(255, 255, 255, 0.6))),
                    ),
                    title: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: w(40), vertical: h(25)),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                              flex: 3,
                              child: Text(c.stage[index].name, style: t32w700)),
                          Expanded(
                              child: Text(
                                  '${DateFormat.m().format(DateTime.parse('00000000T${c.stage[index].time}'))} мин',
                                  style: t32w700)),
                          Expanded(
                              child: Text(
                            '${c.stage[index].tempB.value}$indicate C',
                            style: t32w700,
                          )),
                          Expanded(
                              child: Text(
                                  '${c.stage[index].tempP.value}$indicate C',
                                  style: t32w700)),
                          Expanded(
                              child: Row(
                            children: [
                              c.stage[index].extractor.value
                                  ? const Icon(Icons.place, color: Colors.black)
                                  : const Text(''),
                              c.stage[index].smoke.value
                                  ? const Icon(Icons.cabin, color: Colors.black)
                                  : const Text(''),
                              c.stage[index].water.value
                                  ? const Icon(Icons.kayaking,
                                      color: Colors.black)
                                  : const Text(''),
                              c.stage[index].flap.value
                                  ? const Icon(Icons.label, color: Colors.black)
                                  : const Text(''),
                            ],
                          ))
                        ],
                      ),
                    ),
                    trailing: IconButton(
                        onPressed: () => c.removeIndex(index),
                        icon: const Icon(Icons.delete_outline,
                            size: 22,
                            color: Color.fromRGBO(255, 255, 255, 0.6))),
                  ),
                  onReorder: (oldIndex, newIndex) =>
                      c.fromTo(oldIndex, newIndex),
                  footer: InkWell(
                    onTap: () => Get.to(() => const NewStep()),
                    child: Container(
                        margin: EdgeInsets.only(
                            left: 70, right: 500, top: h(20), bottom: h(20)),
                        padding: EdgeInsets.symmetric(
                            horizontal: w(24), vertical: h(13)),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 2),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8))),
                        child: const Text(
                          'Новое действие',
                          style: TextStyle(fontSize: 20),
                        )),
                  ),
                ),
              )),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                  onTap: () => Get.off(() => const ProcessCooking()),
                  child: const ContanerRadius(Colors.white, 'Готовить')),
              const SizedBox(width: 50),
              InkWell(
                  onTap: () => Get.off(() => const ProcessCooking()),
                  child: const ContanerRadius(Colors.amber, 'Сохранить'))
            ],
          )
        ],
      )),
    );
  }
}

class NewStep extends StatelessWidget {
  const NewStep({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Новое действие', style: TextStyle(fontSize: 26)),
        centerTitle: true,
        backgroundColor: mainFon,
      ),
      backgroundColor: mainFon,
      body: SafeArea(
          child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: w(220), vertical: h(32)),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ItemEdit('Температура камеры', SliderCast()),
            ItemEdit('Температура продукта', SliderCast()),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.only(left: 75, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ToggleBtn('Пароген'),
                  SizedBox(width: defaultPadding * 2),
                  ToggleBtn('Компрессор'),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.only(left: 75, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ToggleBtn('Заслонка'),
                  SizedBox(width: defaultPadding * 2),
                  ToggleBtn('Вытяжка'),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.only(left: 70),
              child: ContanerRadius(Colors.amber, 'Добавить'),
            )
          ],
        ),
      )),
    );
  }
}

class DirectControl extends StatelessWidget {
  const DirectControl({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Прямое управление', style: TextStyle(fontSize: 26)),
        centerTitle: true,
        backgroundColor: mainFon,
      ),
      backgroundColor: mainFon,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 32),
          child: Column(
            children: [
              const Row(
                children: [
                  Expanded(
                      child: StackContaner(Text('Температура'), SliderCast())),
                  SizedBox(width: 20),
                  StackContaner(Text('t камеры'),
                      Text('59°', style: TextStyle(fontSize: 42))),
                  SizedBox(width: 20),
                  StackContaner(Text('t продукта'),
                      Text('42°', style: TextStyle(fontSize: 42)))
                ],
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StackContaner(Text('Заслонка'), ButtonValue('Заслонка')),
                  StackContaner(Text('Компрессор'), ButtonValue('Компрессор')),
                  StackContaner(Text('Пароген'), ButtonValue('Пароген')),
                ],
              ),
              Row(
                children: [
                  const StackContaner(Text('Дымоген'), ButtonValue('Дымоген')),
                  const SizedBox(width: 20),
                  Expanded(
                      child: SizedBox(
                          height: 122,
                          child: StackContaner(const Text('Сообщения'),
                              ListView(children: const [Text('1')])))),
                ],
              ),
              const SizedBox(height: 20),
              const ButtonRule()
            ],
          ),
        ),
      ),
    );
  }
}

final List<String> list = ['rer', 'sghw', 'jkjgfd'];

class ProcessCooking extends StatelessWidget {
  const ProcessCooking({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Готовим', style: TextStyle(fontSize: 26)),
          centerTitle: true,
          backgroundColor: mainFon,
        ),
        backgroundColor: mainFon,
        body: SafeArea(
          child: Container(
              margin: const EdgeInsets.symmetric(vertical: 24),
              child: const CardW()),
        ));
  }
}

class CardW extends StatefulWidget {
  const CardW({super.key});
  @override
  State<CardW> createState() => _CardWState();
}

class _CardWState extends State<CardW> {
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
        itemCount: 5,
        options: CarouselOptions(
          aspectRatio: 2,
          viewportFraction: 0.6,
          enlargeCenterPage: true,
          enableInfiniteScroll: false,
          onPageChanged: (index, reason) => setState(() => currentPage = index),
        ),
        itemBuilder: (context, index, realIndex) {
          return Opacity(
            opacity: currentPage == realIndex ? 1.0 : 0.5,
            child: const ContanerCook(),
          );
        });
  }
}

class ContanerCook extends StatelessWidget {
  const ContanerCook({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: Column(
        children: [
          Container(
            // width:500,
            decoration: const BoxDecoration(        
                color: Colors.amber,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12))),
            padding: const EdgeInsets.symmetric(vertical: 8),
            alignment: Alignment.center,
            child: const Text('Копчение',
                style: TextStyle(fontSize: 24, color: mainFon, fontWeight: FontWeight.w700)),
          ),
          Padding(
            padding:  const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Indicator(name: 't камеры', t1: 56, t2: 70),
                    Indicator(name: 't продукта', t1: 70, t2: 65),
                  ],
                ),
                const SizedBox(height: 20),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Icon(Icons.backpack, color: mainFon, size: 60),
                  Icon(Icons.hive_rounded, color: mainFon, size: 60),
                  Icon(Icons.accessibility_new, color: mainFon, size: 60),
                  Icon(Icons.offline_share_outlined, color: mainFon, size: 60),
                ],),
                const SizedBox(height: 20),
                const Divider(color: mainFon04, height: 2),
                const SizedBox(height: 20),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.all(Radius.circular(4))),
                  width: 142*1.4,
                  height: 54* 1.4,
                  alignment: Alignment.center,
                  child: const Text('4:28:32', style: TextStyle(color: mainFon, fontSize: 32* 1.4, fontWeight: FontWeight.w700),))
              ],
            ),
          )
        ],
      ),
    );
  }
}

class Indicator extends StatelessWidget {
  const Indicator({
    Key? key,
    required this.name,
    required this.t1,
    required this.t2,
  }) : super(key: key);
  final String name;
  final int t1;
  final int t2;
  static const st1 =  TextStyle(color: mainFon, fontSize: 28, fontWeight: FontWeight.w400);
  static const st2 =  TextStyle(color: mainFon, fontSize: 70, fontWeight: FontWeight.w700);
  static const st3 =  TextStyle(color: mainFon, fontSize: 40, fontWeight: FontWeight.w700);
  static const st4 =  TextStyle(color: mainFon04, fontSize: 70, fontWeight: FontWeight.w700);
  static const st5 =  TextStyle(color: mainFon04, fontSize: 40, fontWeight: FontWeight.w700);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name, style: st1),
        Row(
          children: [
            Text('$t1', style: st2),
            const Text(indicate, style: st4),
            Icon(
              Icons.arrow_right,
              color: t1 < t2 ? Colors.red : Colors.green,
            ),
            Text('$t2', style: st3),
            const Text(indicate, style: st5),
          ],
        )
      ],
    );
  }
}

