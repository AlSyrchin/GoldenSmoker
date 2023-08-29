// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:syncfusion_flutter_charts/sparkcharts.dart';


//Dart Analyzer// Dart Fix
//LayoutBuilder
// ConstrainedBox - задаёт мин и макс размеры 
// FittedBox - расширяет размер ребенка
const Color mainFon = Color.fromRGBO(31, 10, 9, 1);
const defaultPadding = 20.0;

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    return MaterialApp(
      theme: ThemeData.dark(),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void tapScreen1() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => DirectControl()));
  }

  void tapScreen2() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => Recipes()));
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: mainFon,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                    onTap: () {
                      tapScreen2();
                    },
                    child: Container(
                      width: 350,
                      height: 490,
                      color: Colors.amber,
                      child: Center(
                          child: Text(
                        'Готовить по рецепту',
                        style: TextStyle(color: Colors.black87),
                      )),
                    )),
                SizedBox(width: defaultPadding),
                Column(
                  children: [
                    InkWell(
                        onTap: () {
                          tapScreen1();
                        },
                        child: Container(
                          width: 320,
                          height: 320,
                          color: Colors.amber,
                          child: Center(
                              child: Text(
                            'Прямое управление',
                            style: TextStyle(color: Colors.black87),
                          )),
                        )),
                    SizedBox(height: defaultPadding),
                    Row(
                      children: [
                        InkWell(
                            onTap: () {},
                            child: Container(
                              width: 150,
                              height: 150,
                              color: Colors.amber,
                              child: Center(
                                  child: Text(
                                'Создать рецепт',
                                style: TextStyle(color: Colors.black87),
                              )),
                            )),
                        SizedBox(width: defaultPadding),
                        InkWell(
                            onTap: () {},
                            child: Container(
                              width: 150,
                              height: 150,
                              color: Colors.amber,
                              child: Center(
                                  child: Text(
                                '...',
                                style: TextStyle(color: Colors.black87),
                              )),
                            )),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DirectControl extends StatelessWidget {
  const DirectControl({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainFon,
      appBar: AppBar(
        backgroundColor: mainFon,
        elevation: 0,
        title: Center(
          child: Text('Прямое управление'),
        ),
        actions: <Widget>[
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Container(
              padding: EdgeInsets.symmetric(
                  vertical: defaultPadding, horizontal: defaultPadding * 3),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StackContaner(
                    name: 'Температура',
                    content: SizedBox(
                      height: 100,
                      child: Row(children: [
                        Expanded(
                          flex: 4,
                          child: SliderControl(),
                        ),
                        Expanded(
                          child: IndicatorNumb(
                            nameIndicator: 't камеры',
                            number: 59,
                          ),
                        ),
                        Expanded(
                          child: IndicatorNumb(
                            nameIndicator: 't продукта',
                            number: 42,
                          ),
                        ),
                      ]),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: StackContaner(
                            name: 'Вентилятор',
                            content:
                                SizedBox(height: 120, child: SliderControl()),
                          )),
                      // Spacer(),
                      Expanded(
                        child: Column(
                          children: [
                            StackContaner(
                              name: 'Дымогенератор',
                              content: SwitchControl(),
                            ),
                            StackContaner(
                              name: 'Заслонка',
                              content: SwitchControl(),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {}, icon: Icon(Icons.arrow_back)),
                      IconButton(onPressed: () {}, icon: Icon(Icons.pause)),
                      IconButton(onPressed: () {}, icon: Icon(Icons.play_arrow))
                    ],
                  )
                  // TextField(
                  //   decoration: InputDecoration(
                  //       filled: true,
                  //       border: OutlineInputBorder(
                  //         borderSide: BorderSide.none,
                  //         borderRadius: BorderRadius.all(Radius.circular(10)),
                  //       ),
                  //       suffixIcon: InkWell(onTap: () {}, child: Icon(Icons.search))),
                  // )
                ],
              )),
        ),
      ),
    );
  }
}

List<String> myProd = [
  'Копченая свинина с сидровым мопом',
  'Копченая индейка',
  'Сыровяленый рулет из говядины',
  'Варено-копченая свинина',
  'Окорок копченый с томатами',
  'Бастурма с овощами',
  'Бекон из окорока и лопатки',
  'Карбонад из свинины',
  'Копченая индейка с сидровым мопом',
  'Варено-копченая индейка',
];

class Recipes extends StatelessWidget {
  Recipes({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    void tapScreen3(int index) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => MenuTime(
                index: index,
              )));
    }

    return Scaffold(
      backgroundColor: mainFon,
      appBar: AppBar(
        backgroundColor: mainFon,
        elevation: 0,
        title: const Center(
          child: Text('Выберете рецепт'),
        ),
        actions: <Widget>[
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
        ],
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
        child: GridView.builder(
            itemCount: myProd.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: defaultPadding,
              crossAxisSpacing: defaultPadding,
              childAspectRatio: 0.95,
            ),
            itemBuilder: (context, index) => InkWell(
                  onTap: () => tapScreen3(index),
                  child: Container(
                    color: Colors.black38,
                    padding: const EdgeInsets.all(defaultPadding),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(Icons.account_circle_outlined),
                        SizedBox(
                          height: 10,
                        ),
                        Text('${myProd[index]}'),
                      ],
                    ),
                  ),
                )),
      )),
    );
  }
}

// class ItemRecept extends StatelessWidget {
//   ItemRecept({
//     Key? key,
//   }) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: <Widget>[
//         Container(
//           width: 150,
//           height: 150,
//           padding: EdgeInsets.all(defaultPadding),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(16),
//           ),
//           child: Icon(Icons.access_time_filled),
//         ),
//         Padding(
//           padding: EdgeInsets.symmetric(vertical: defaultPadding / 2),
//           child: Text('1'),
//         ),
//       ],
//     );
//   }
// }

class MenuTime extends StatelessWidget {
  const MenuTime({
    Key? key,
    required this.index,
  }) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    void tapScreen4() {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => AutoOrHands(index: index)));
    }

    return Scaffold(
      backgroundColor: mainFon,
      appBar: AppBar(
        backgroundColor: mainFon,
        elevation: 0,
        title: const Center(
          child: Text('Коррекция рецепта'),
        ),
        actions: <Widget>[
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: defaultPadding),
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '${myProd[index]}',
                  style: TextStyle(fontSize: 25),
                ),
                SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: <Widget>[
                        ...stepRecept
                            .map((e) => ListCard(
                                  name: e,
                                ))
                            .toList()
                      ],
                    )),
                SizedBox(
                    width: 200,
                    height: 50,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.amber)),
                        onPressed: () => tapScreen4(),
                        child: Text(
                          'Начать!',
                          style: TextStyle(fontSize: 20),
                        )))
              ]),
        ),
      ),
    );
  }
}

List<String> step = [
  't камеры',
  't продукта',
  'Влажность',
  'Вентилятор',
  'Дымогенератор',
  'Заслонка'
];
List<String> stepRecept = [
  'Прогрев',
  'Сушка',
  'Копчение',
  'Проветривание',
  'Выход'
];

class ListTitleUser extends StatelessWidget {
  const ListTitleUser({
    Key? key,
    required this.nameOpps,
    required this.value,
  }) : super(key: key);
  final String nameOpps;
  final int value;
  @override
  Widget build(BuildContext context) {
    return
        // ListTile(
        //   minVerticalPadding: 0,
        //   horizontalTitleGap: 0,
        //   minLeadingWidth: 0,
        //   title: Text('${nameOpps}', style: TextStyle(fontSize: 10),),
        //   trailing: Text('${value}°', style: TextStyle(fontSize: 10),),
        // );
        Padding(
      padding: const EdgeInsets.symmetric(vertical: defaultPadding / 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${nameOpps}',
            style: TextStyle(fontSize: 10),
          ),
          Text(
            '${value}°',
            style: TextStyle(fontSize: 10),
          )
        ],
      ),
    );
  }
}

class ListCard extends StatelessWidget {
  const ListCard({
    Key? key,
    required this.name,
  }) : super(key: key);
  final String name;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        color: Colors.black38,
        width: 220,
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${name}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Divider(),
            ...step
                .map(
                  (e) => ListTitleUser(value: 10, nameOpps: e),
                )
                .toList(),
            Divider(),
            Center(child: Text('00:00'))
          ],
        ),
      ),
    );
  }
}

class AutoOrHands extends StatelessWidget {
  const AutoOrHands({
    Key? key,
    required this.index,
  }) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    void tapScreen5() {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Auto(index: index)));
    }

    void tapScreen6() {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Hands(
                index: index,
              )));
    }

    return Scaffold(
      backgroundColor: mainFon,
      body: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Container(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    tapScreen6();
                  },
                  child: Container(
                    child: Center(child: Text('Автоматический режим')),
                    color: Colors.amber,
                    width: 250,
                    height: 350,
                  ),
                ),
                SizedBox(
                  width: defaultPadding,
                ),
                InkWell(
                  onTap: () {
                    tapScreen6();
                  },
                  child: Container(
                    child: Center(child: Text('Ручной режим')),
                    color: Colors.amber,
                    width: 250,
                    height: 350,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: defaultPadding,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Отмена')),
          ]),
        ),
      ),
    );
  }
}

class Auto extends StatelessWidget {
  const Auto({
    Key? key,
    required this.index,
  }) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: mainFon,
        appBar: AppBar(
          backgroundColor: mainFon,
          elevation: 0,
          title: Text('Готовим \n${myProd[index]}'),
          actions: <Widget>[
            IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          ],
        ),
        body: Text('Auto'));
  }
}

class Hands extends StatelessWidget {
  const Hands({
    Key? key,
    required this.index,
  }) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: mainFon,
        appBar: AppBar(
          backgroundColor: mainFon,
          elevation: 0,
          title: Text('Готовим \n${myProd[index]}'),
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  Dialog(context);
                },
                icon: const Icon(Icons.search)),
          ],
        ),
        body: SafeArea(
            child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: defaultPadding),
            child: Container(
                color: Colors.amber,
                width: 400,
                height: 330,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        width: 400,
                        color: Colors.blue,
                        padding: EdgeInsets.all(defaultPadding),
                        child: Center(child: Text('Копчение'))),
                    Container(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Pokazatel(
                                    nameIndicat: step[0],
                                    temperat: 56,
                                    toTemperat: 70,
                                  ),
                                  Pokazatel(
                                    nameIndicat: step[2],
                                    temperat: 56,
                                    toTemperat: 70,
                                  ),
                                  PokazatelTxt(nameIndicat: step[4], temperat: true,)
                                ],
                              ),

                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Pokazatel(
                                    nameIndicat: step[1],
                                    temperat: 56,
                                    toTemperat: 70,
                                  ),
                                  Pokazatel(
                                    nameIndicat: step[3],
                                    temperat: 56,
                                    toTemperat: 70,
                                  ),
                                  PokazatelTxt(nameIndicat: step[5], temperat: true,)
                                ],
                              )
                            ],
                          ),
                          Divider(),
                          Padding(
                            padding: const EdgeInsets.all(defaultPadding / 2),
                            child:SizedBox(
                    width: 100,
                    height: 30,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.amber)),
                        onPressed: (){},
                        child: Text(
                          '00:00',
                          style: TextStyle(fontSize: 20),
                        ))),
                          )
                        ],
                      ),
                    )
                  ],
                )),
          ),
        )));
  }

  Future<dynamic> Dialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Сбрызните мясо \nсидровым мопом',
              style: TextStyle(
                fontSize: 40,
              ),
              textAlign: TextAlign.center,
            ),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Ок'))
            ],
          );
        });
  }
}

class Pokazatel extends StatelessWidget {
  const Pokazatel({
    Key? key,
    required this.nameIndicat,
    required this.temperat,
    required this.toTemperat,
  }) : super(key: key);
  final String nameIndicat;
  final int temperat;
  final int toTemperat;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding / 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${nameIndicat}'),
          Row(
            children: [
              Text('${temperat}%',style: TextStyle(fontSize: 40),),
              Icon(Icons.arrow_right_alt_outlined, color: Colors.redAccent,),
              Text('${toTemperat}%', style: TextStyle(fontSize: 20),)
            ],
          )
        ],
      ),
    );
  }
}

class PokazatelTxt extends StatelessWidget {
  const PokazatelTxt({
    Key? key,
    required this.nameIndicat,
    required this.temperat,
  }) : super(key: key);
  final String nameIndicat;
  final bool temperat;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${nameIndicat}'),
          Row(
            children: [
              Text('${temperat ? 'Открыта' : 'Закрыта'}',style: TextStyle(fontSize: 20, color: Colors.green),),
            ],
          )
        ],
      ),
    );
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
    return Container(
      padding: EdgeInsets.all(10),
      child: Stack(
        alignment: AlignmentDirectional.topStart,
        children: [
          Container(
            margin: EdgeInsets.all(7),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(child: content),
          ),
          Positioned(
            top: 0,
            left: 35,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              color: mainFon,
              child: Center(
                  child: Text(
                '${name}',
              )),
            ),
          ),
        ],
      ),
    );
  }
}

class SwitchControl extends StatefulWidget {
  const SwitchControl({super.key});

  @override
  State<SwitchControl> createState() => _SwitchControlState();
}

class _SwitchControlState extends State<SwitchControl> {
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return Switch(
      value: isSwitched,
      onChanged: (value) {
        setState(() {
          isSwitched = value;
        });
      },
      activeTrackColor: Colors.amberAccent,
      activeColor: Colors.amber,
    );
  }
}

class SliderControl extends StatefulWidget {
  const SliderControl({super.key});
  @override
  State<SliderControl> createState() => _SliderControlState();
}

class _SliderControlState extends State<SliderControl> {
  double _value = 0;
  @override
  Widget build(BuildContext context) {
    return Slider(
      activeColor: Colors.amber,
      inactiveColor: Colors.grey,
      min: 0.0,
      max: 100.0,
      label: _value.round().toString(),
      value: _value,
      onChanged: (value) {
        setState(() {
          _value = value;
        });
      },
    );
  }
}

class IndicatorNumb extends StatelessWidget {
  final String nameIndicator;
  final int number;
  const IndicatorNumb({
    Key? key,
    required this.nameIndicator,
    required this.number,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${nameIndicator}',
          style: TextStyle(fontSize: 12),
        ),
        const SizedBox(
          height: 3,
        ),
        Row(
          children: [
            Text('${number}', style: TextStyle(fontSize: 35)),
            const SizedBox(width: 10),
            const Icon(
              Icons.arrow_upward_outlined,
              color: Colors.redAccent,
            )
          ],
        )
      ],
    );
  }
}
