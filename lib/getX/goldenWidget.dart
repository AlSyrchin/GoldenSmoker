// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:goldensmoker/getX/commandFile.dart';
import 'package:goldensmoker/getX/getxGolden.dart';
// import 'package:goldensmoker/getX/reciept.dart';
import 'constant.dart';
import 'numberpicker.dart';
import 'timer.dart';

const size30 = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    return GetMaterialApp(
      theme: ThemeData.dark(),
      home: const HomePage(),
      getPages: [
        GetPage(name: "/", page: () => const HomePage()),
        GetPage(name: "/two", page: () => const DirectControl()),
        GetPage(name: "/three", page: () => const Correction()),
        GetPage(name: "/newrecipe", page: () => const NewRecipe()),
      ],
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    BluetoothUser bluetoothController = Get.put(BluetoothUser());
    return Scaffold(
      body: SafeArea(
          child: Container(
        color: Colors.amber,
        padding: const EdgeInsets.all(defaultPadding),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() => Text(
                '${bluetoothController.nameDev} / ${bluetoothController.bluetoothState}')),
            Obx(() => Text('${bluetoothController.dataString}')),
            Obx(() => Text(
                '${bluetoothController.tp} / ${bluetoothController.tb} / ${bluetoothController.step}')),
            MaterialButton(
              onPressed: () => Get.toNamed('two'),
              color: Colors.blue,
              child: const Text('Ручное управление'),
            ),
            MaterialButton(
              onPressed: () => Get.toNamed('three'),
              color: Colors.blue,
              child: const Text('Создание рецепта'),
            ),
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
    BluetoothUser bluetoothController = Get.put(BluetoothUser());
    Size size = MediaQuery.of(context).size;
    TextStyle stTxt =
        TextStyle(fontSize: size.height * 0.07, fontWeight: FontWeight.bold);
    return Scaffold(
      backgroundColor: mainFon,
      appBar: appBarMetod(),
      body: SafeArea(
          child: Center(
        child: SizedBox(
          width: size.width * 0.75, // 961
          height: size.height * 0.8, // 552
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.2,
                width: double.infinity,
                child: Row(
                  children: [
                    Expanded(
                        flex: 3,
                        child: StackContaner(
                            name: 'Температура', content: SliderControl())),
                    const SizedBox(width: defaultPadding),
                    Expanded(
                        child: StackContaner(
                            name: 't камеры',
                            content: Obx(() => Text('${bluetoothController.tp}',
                                style: stTxt)))),
                    const SizedBox(width: defaultPadding),
                    Expanded(
                        child: StackContaner(
                            name: 't продукта',
                            content: Obx(() => Text('${bluetoothController.tb}',
                                style: stTxt)))),
                  ],
                ),
              ),
              const SizedBox(height: defaultPadding),
              SizedBox(
                height: size.height * 0.38,
                width: double.infinity,
                child: Row(
                  children: [
                    Expanded(
                        flex: 4,
                        child: StackContaner(
                            name: 'Сообщения',
                            content: Obx(() => ListView.builder(
                                  itemCount: bluetoothController.listMsg.length,
                                  itemBuilder: (context, index) => Text(
                                    bluetoothController.listMsg[index],
                                    textAlign: TextAlign.center,
                                  ),
                                )))),
                    const SizedBox(width: defaultPadding),
                    const Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          StackContaner(
                              name: 'Заслонка', content: SwitchControlsAir()),
                          StackContaner(
                              name: 'Компрессор',
                              content: SwitchControlsSmoke()),
                          StackContaner(
                              name: 'Пароген', content: SwitchControlsWater()),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: defaultPadding * 1.5),
              const Center(child: ContanerButtons()),
            ],
          ),
        ),
      )),
    );
  }

  AppBar appBarMetod() {
    return AppBar(
      backgroundColor: mainFon,
      elevation: 0,
      title: const Center(child: Text('Прямое управление', style: size30)),
      actions: <Widget>[
        IconButton(
            onPressed: () {
              Get.offAllNamed('/');
            },
            icon: const Icon(Icons.search)),
      ],
    );
  }
}

class SwitchControlsAir extends StatelessWidget {
  const SwitchControlsAir({super.key});
  @override
  Widget build(BuildContext context) {
    BluetoothUser bluetoothController = Get.put(BluetoothUser());
    return GetBuilder<AllStateWidget>(
        init: AllStateWidget(),
        builder: (on) => Switch(
              value: on.isSwitchedAir.value,
              onChanged: (value) {
                on.isToggleAir();
                bluetoothController.sendMessage(on.message); //заслонка
              },
              activeTrackColor: Colors.amberAccent,
              activeColor: Colors.amber,
            ));
  }
}

class SwitchControlsSmoke extends StatelessWidget {
  const SwitchControlsSmoke({super.key});
  @override
  Widget build(BuildContext context) {
    BluetoothUser bluetoothController = Get.put(BluetoothUser());
    return GetBuilder<AllStateWidget>(
        init: AllStateWidget(),
        builder: (on) => Switch(
              value: on.isSwitchedSmoke.value,
              onChanged: (value) {
                on.isToggleSmoke();
                bluetoothController.sendMessage(on.message); //заслонка
              },
              activeTrackColor: Colors.amberAccent,
              activeColor: Colors.amber,
            ));
  }
}

class SwitchControlsWater extends StatelessWidget {
  const SwitchControlsWater({super.key});
  @override
  Widget build(BuildContext context) {
    BluetoothUser bluetoothController = Get.put(BluetoothUser());
    return GetBuilder<AllStateWidget>(
        init: AllStateWidget(),
        builder: (on) => Switch(
              value: on.isSwitchedWater.value,
              onChanged: (value) {
                on.isToggleWater();
                bluetoothController.sendMessage(on.message); //заслонка
              },
              activeTrackColor: Colors.amberAccent,
              activeColor: Colors.amber,
            ));
  }
}

class StackContaner extends StatelessWidget {
  final Widget content;
  final String name;
  const StackContaner({
    Key? key,
    required this.content,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      alignment: AlignmentDirectional.topStart,
      children: [
        Container(
          margin: EdgeInsets.only(top: size.height * 0.013),
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(child: content),
        ),
        Positioned(
          left: size.height * 0.026,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: size.height * 0.006),
            color: mainFon,
            child: Text(
              name,
              style: TextStyle(fontSize: size.height * 0.026),
            ),
          ),
        ),
      ],
    );
  }
}

class SliderControl extends StatelessWidget {
  const SliderControl({super.key});

  @override
  Widget build(BuildContext context) {
    BluetoothUser bluetoothController = Get.put(BluetoothUser());
    AllStateWidget allStateWidget = Get.put(AllStateWidget());
    return Container(
      padding: const EdgeInsets.symmetric(vertical: defaultPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              child: Obx(
            () => FittedBox(
                child: Text(
              '${allStateWidget.range.value.round()}°',
            )),
          )),
          Expanded(
            child: Obx(
              () => Slider(
                activeColor: Colors.amber,
                inactiveColor: Colors.grey,
                min: 0.0,
                max: 150.0,
                value: allStateWidget.range.value,
                onChanged: (value) => allStateWidget.setRange(value),
                onChangeEnd: (value) {
                  bluetoothController.sendMessage(allStateWidget.message);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ContanerButtons extends StatelessWidget {
  const ContanerButtons({super.key});
  @override
  Widget build(BuildContext context) {
    BluetoothUser bluetoothController = Get.put(BluetoothUser());
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        FittedBox(
            child: IconButton(
                onPressed: () {
                  bluetoothController.sendMessage(RECIPE_STOP);
                },
                icon: const Icon(Icons.close))),
        const VerticalDivider(),
        FittedBox(
            child: IconButton(
                onPressed: () {
                  bluetoothController.sendMessage(RECIPE_PAUSE);
                }, //RECIPE_CONTINUE
                icon: const Icon(Icons.pause))),
        const VerticalDivider(),
        FittedBox(
            child: IconButton(
                onPressed: () {
                  bluetoothController.sendMessage(RECIPE_START);
                },
                icon: const Icon(Icons.play_arrow))),
      ]),
    );
  }
}

class ContentIndicators extends StatelessWidget {
  const ContentIndicators({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);
  final String title;
  final Widget value;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    const bigSize = 0.07;
    const smSize = 0.03;
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: size.height * smSize)),
          Row(
            children: [
              value,
              Text('°',
                  style: TextStyle(
                      fontSize: size.height * bigSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey)),
              Icon(
                Icons.arrow_upward_sharp,
                color: Colors.red,
                size: size.height * bigSize,
              ),
            ],
          ),
        ]);
  }
}

/////////////////////////////////////

class Correction extends StatelessWidget {
  const Correction({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // RecipeController recipeController = Get.put(RecipeController());
    BluetoothUser bluetoothController = Get.put(BluetoothUser());
    return Scaffold(
      backgroundColor: mainFon,
      appBar: appBarMetod(),
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //наполнение
            SizedBox(
                width: double.infinity,
                height: 325,
                // child: Obx(() => recipeController.widgetAllStage())
                ),
            const SizedBox(height: defaultPadding),
            SizedBox(
              width: 500,
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                        onPressed: () => Get.toNamed('newrecipe'),
                        child: const Text('Add')),
                  ),
                  const SizedBox(width: defaultPadding),
                  Expanded(
                    child: ElevatedButton(
                        onPressed: () {
                          // bluetoothController.sendMessage(recipeController.sendRecipe());
                          bluetoothController.sendMessage(RECIPE_START);
                        },
                        child: const Text('Go')),
                  ),
                  const SizedBox(width: defaultPadding),
                  Expanded(
                    child: ElevatedButton(
                        onPressed: () {
                          bluetoothController.sendMessage('R!');
                        },
                        child: const Text('Clear')),
                  )
                ],
              ),
            )
          ],
        ),
      )),
    );
  }

  AppBar appBarMetod() {
    return AppBar(
      backgroundColor: mainFon,
      elevation: 0,
      title: const Center(child: Text('Создание рецепта', style: size30)),
      actions: <Widget>[
        Center(child: SizedBox(width: 60, child: clock())),
        IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
      ],
    );
  }

  TimerBuilder clock() {
    return TimerBuilder.periodic(const Duration(seconds: 1),
        builder: (context) {
      return Text(DateFormat('hh:mm:ss').format(DateTime.now()));
    });
  }
}

String formatDuration(Duration d) {
  String f(int n) {
    return n.toString().padLeft(2, '0');
  }

  d += const Duration(microseconds: 999999);
  return "${f(d.inMinutes)}:${f(d.inSeconds % 60)}";
}

class Picker extends StatefulWidget {
  const Picker({
    Key? key,
  }) : super(key: key);
  @override
  State<Picker> createState() => _PickerState();
}

class _PickerState extends State<Picker> {
  int _currentValue = 0;
  @override
  Widget build(BuildContext context) {
    return NumberPicker(
      value: _currentValue,
      minValue: 0,
      maxValue: 100,
      onChanged: (value) => setState(() => _currentValue = value),
    );
  }
}

class NewRecipe extends StatelessWidget {
  const NewRecipe({super.key});
  @override
  Widget build(BuildContext context) {
    StateLu valueLu = Get.put(StateLu());
    // RecipeController recipeController = Get.put(RecipeController());
    AllStateWidget allStateWidget = Get.put(AllStateWidget());
    return Scaffold(
      backgroundColor: mainFon,
      appBar: appBarMetod(),
      body: const SafeArea(
          child: Padding(
        padding: EdgeInsets.all(defaultPadding),
        child:  Center(
            child: Column(
          children: [
            Lu(),
            SizedBox(
              width: 800,
              height: 50,
              // child: ElevatedButton(
              //   onPressed: () {
              //     switch (valueLu.selectedValue.value) {
              //       case 0:
              //         recipeController.listStages
              //             .add(Related(allStateWidget.range.value));
              //         break;
              //       case 1:
              //         recipeController.listStages.add(Drying(
              //             allStateWidget.range.value,
              //             allStateWidget.range.value.toInt()));
              //         break;
              //       case 2:
              //         recipeController.listStages.add(Boiling(
              //             allStateWidget.range.value,
              //             allStateWidget.range.value.toInt()));
              //         break;
              //       case 3:
              //         recipeController.listStages.add(Smoking(
              //             allStateWidget.range.value,
              //             allStateWidget.range.value.toInt()));
              //         break;
              //       case 4:
              //         recipeController.listStages
              //             .add(Frying(allStateWidget.range.value));
              //         break;
              //       default:
              //     }
              //     Get.back();
              //   },
              //   child: const Text('Add'),
              // ),
            )
          ],
        )),
      )),
    );
  }

  AppBar appBarMetod() {
    return AppBar(
      backgroundColor: mainFon,
      elevation: 0,
      title: const Center(child: Text('Новое действие', style: size30)),
      actions: <Widget>[
        IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
      ],
    );
  }
}

class StateLu extends GetxController {
  RxInt selectedValue = 0.obs;

  void upSt(int? val) {
    selectedValue.value = val ?? selectedValue.value;
    update();
  }
}

List<DropdownMenuEntry<int>> listDrop = nameStep
    .map((e) => DropdownMenuEntry(
          value: e.index,
          label: e.name,
        ))
    .toList();

class Lu extends StatelessWidget {
  const Lu({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<StateLu>(
      init: StateLu(),
      builder: (_) => SizedBox(
        width: 800,
        height: 450,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: 70,
              child: DropdownMenu<int>(
                  initialSelection: _.selectedValue.value,
                  dropdownMenuEntries: listDrop,
                  onSelected: (int? newValue) {
                    _.upSt(newValue);
                  },
                  // isDense: true,
                  // isExpanded: true,
                  // padding: const EdgeInsets.all(8),
                  // borderRadius: const BorderRadius.all(Radius.circular(4)),
                ),
            ),
            if (_.selectedValue.value == 1)
              const SizedBox(
                  width: double.infinity,
                  height: 70,
                  child:
                      StackContaner(name: 'Заслонка', content: Text('Откр.', style: TextStyle(fontSize: 20),))),
            if (_.selectedValue.value == 3)
              const SizedBox(
                  width: double.infinity,
                  height: 70,
                  child:
                      StackContaner(name: 'Компрессор', content: Text('Вкл.'))),
            if (_.selectedValue.value == 2)
              const SizedBox(
                  width: double.infinity,
                  height: 70,
                  child: StackContaner(name: 'Пароген', content: Text('Вкл.'))),
              const SizedBox(
                  width: double.infinity,
                  height: 100,
                  child: StackContaner(
                      name: 't камеры', content: SliderControl())),
            if (_.selectedValue.value == 0 ||
                _.selectedValue.value == 1 ||
                _.selectedValue.value == 2)
              const SizedBox(
                  width: double.infinity,
                  height: 100,
                  child: StackContaner(
                      name: 't продукта', content: SliderControl())),
            if (_.selectedValue.value == 1 ||
                _.selectedValue.value == 2 ||
                _.selectedValue.value == 3)
              const SizedBox(
                  width: double.infinity,
                  height: 100,
                  child: StackContaner(
                      name: 'Выдержка', content: SliderControl())),
          ],
        ),
      ),
    );
  }
}
