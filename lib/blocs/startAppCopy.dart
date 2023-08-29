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
const LinearGradient mainGradient = LinearGradient(
  colors: [Color.fromRGBO(253, 212, 67, 1), Color.fromRGBO(239, 157, 26, 1)],
  begin: Alignment.bottomLeft,
  end: Alignment.topRight,
    );
const TextStyle style20 = TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w400);
const TextStyle style32 = TextStyle(fontSize: 32, color: Colors.black, fontWeight: FontWeight.w700);
const TextStyle style56 = TextStyle(fontSize: 56, color: Colors.black, fontWeight: FontWeight.w700);

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
      home: const Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double x = size.width * 0.68;
    double y = size.height * 0.81;

    void directControl() {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => DirectControl()));
    }

    void recipes() {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Recipes()));
    }

    return Scaffold(
      backgroundColor: mainFon,
      body: SafeArea(
          child: Center(
        child: Container(
          width: x,
          height: y,
          child: Row(children: [
            InkWell(onTap: (){recipes();} ,child: ContainerRadius(content: ContentRicept(size), x: x/2, y: y,)),
              const SizedBox(width: defaultPadding,),
              Expanded(child: Column(
                children: [
                  Expanded(flex: 2, child: InkWell(onTap: (){directControl();} ,child: ContainerRadius(content: ContentDirect(size), x: x/2, y: y * 2/3,))),
                  const SizedBox(height: defaultPadding,),
                  Expanded(child: Row(
                    children: [
                      Expanded(child: InkWell(onTap: (){} ,child: ContainerRadius(content: ContentCreate(size)  , x: x/4, y: x/4))),
                      const SizedBox(width: defaultPadding,),
                      Expanded(child: InkWell(onTap: (){} ,child: ContainerRadius(content: FittedBox(child: contentMenu[3].icon,), x: x/4, y: x/4))),
                  ],)),
              ],)),
            ]),
        ),
      )),
    );
  }

  Container ContentDirect(Size size) {
    return Container(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Column(children: [
                    SizedBox( height: size.height * 0.2, child: FittedBox(child: contentMenu[1].icon,),),
                    Text(contentMenu[1].title, style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold,  color: Colors.black)),
                    SizedBox(height: defaultPadding/ 2,),
                    Text(contentMenu[1].text, style: TextStyle(fontSize: 20,  color: Colors.black))
                ],));
  }

  Container ContentCreate(Size size) {
    return Container(
                      padding: EdgeInsets.all(defaultPadding),
                      child: Column(children: [
                      SizedBox(height: size.height * 0.1, child: FittedBox(child: contentMenu[2].icon,),),
                      Text('Создать рецепт', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,  color: Colors.black),)
                    ],));
  }

  Container ContentRicept(Size size) {
    return Container(
            padding: EdgeInsets.all(defaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              SizedBox(width: size.width * 0.32, height: size.height * 0.46, child: FittedBox(child: contentMenu[0].icon,)),
              SizedBox(width: size.width * 0.175, height: size.height * 0.136, child: Text(contentMenu[0].title, style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black),)),
              SizedBox(height: 5,),
              SizedBox(width: size.width * 0.28, child: Text(contentMenu[0].text, style: TextStyle(fontSize: 20, color: Colors.black),))
            ]),
          );
  }
}

class ContainerRadius extends StatelessWidget {
  const ContainerRadius({
    Key? key,
    required this.content,
    required this.x,
    required this.y,
  }) : super(key: key);
  final Widget content;
  final double x;
  final double y;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: x,
      height: y,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: content,
    );
  }
}

class ContentMenu {
  final String title;
  final String text;
  final Icon icon;
  ContentMenu({
    required this.title,
    required this.text,
    required this.icon,
  });
}

class ButtonMain extends StatelessWidget {
  const ButtonMain({
    Key? key,
    required this.text,
    required this.color,
    required this.txtSize,
    required this.onClc,
  }) : super(key: key);

  final String text;
  final Color color;
  final double txtSize;
  final void Function()? onClc;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ElevatedButton(
        onPressed: onClc,
        style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(24))),
            ),
            backgroundColor: MaterialStateProperty.all(color)),
        child: Text(
          text,
          style: TextStyle(fontSize: size.height * txtSize, color: mainFon),
        ));
  }
}

class DirectControl extends StatelessWidget {
  const DirectControl({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: mainFon,
      appBar: AppBarMetod(),
      body: SafeArea(
          child: Center(
        child: Container(
          width: size.width * 0.75,
          height: size.height * 0.8,
          child: Column(children: [
            Expanded(flex: 3, child: StackContaner(name: 'Температура', content: Row(
              children: [
              Expanded(flex: 6 ,child: SliderControl()),
              SizedBox(width: defaultPadding,),
              Expanded(flex: 2,child: ContentIndicator(title: 't камеры', value: 59,)),
              SizedBox(width: defaultPadding,),
              Expanded(flex: 2, child: ContentIndicator(title: 't продукта', value: 42,)),
            ],))),
            SizedBox(height: defaultPadding,),
            Expanded(flex: 3, child: Row(children: [
              Expanded(flex: 2 ,child: StackContaner(name: 'Вентилятор', content: SliderControl(),)),
              SizedBox(width: defaultPadding,),
              Expanded(
                child: Column(children: [
                  Expanded(child: StackContaner(name: 'Дымогенератор', content: SwitchControl(),)),
                  SizedBox(height: defaultPadding,),
                  Expanded(child: StackContaner(name: 'Заслонка', content: SwitchControl(),))
                ],),
              )
            ],)),
            SizedBox(height: defaultPadding,),
            Center(
                  child: ContanerButton()),
            ],),
        ),
      )),
    );
  }

  AppBar AppBarMetod() {
    return AppBar(
        backgroundColor: mainFon,
        elevation: 0,
        title: Center(child: Text('Прямое управление', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold))),
        actions: <Widget>[
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search)),
        ],
      );
  }
}

class ContanerButton extends StatelessWidget {
  const ContanerButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.3,
      height: size.height * 0.08,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        FittedBox(child: IconButton(onPressed: (){}, icon: Icon(Icons.close))  ),
        VerticalDivider(),
        FittedBox(child: IconButton(onPressed: (){}, icon: Icon(Icons.pause))),
        VerticalDivider(),
        FittedBox(child: IconButton(onPressed: (){}, icon: Icon(Icons.play_arrow))),
      ]),
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
    Size size = MediaQuery.of(context).size;
    return Stack(
      alignment: AlignmentDirectional.topStart,
      children: [
        Container(
          margin: EdgeInsets.only(top: size.height * 0.013),
          padding: EdgeInsets.symmetric(horizontal: defaultPadding),
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
            child: Text('${name}', style: TextStyle(fontSize: size.height * 0.026),),
          ),
        ),
      ],
    );
  }
}

/////////////////////////////////////////////////////////////////////////////
///Indicator


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
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(vertical: defaultPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: Text('${_value.round()}°', style: TextStyle(fontWeight: FontWeight.bold, fontSize: size.height * 0.08 ),)),
          Expanded(
            child: Slider(
              activeColor: Colors.amber,
              inactiveColor: Colors.grey,
              min: 0.0,
              max: 150.0,
              value: _value,
              onChanged: (value) {
                setState(() {
                  _value = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}


/////////////////////////////////////////////////////////////////////////////
///END Indicator


class ContentIndicator extends StatelessWidget {
  const ContentIndicator({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);
  final String title;
  final int value;
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    const bigSize = 0.08;
    const smSize = 0.03;
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Text(title, style: TextStyle(fontSize: size.height * smSize)),
      Row(
        children: [
        Text('${value}', style: TextStyle(fontSize: size.height * bigSize, fontWeight: FontWeight.bold),),
        Text('°', style: TextStyle(fontSize: size.height * bigSize, fontWeight: FontWeight.bold, color: Colors.grey)),
        Icon(Icons.arrow_upward_sharp, color: Colors.red, size: size.height * bigSize,),
      ],),
    ]),
    );
  }
}

class Recipes extends StatelessWidget {
  const Recipes({super.key});

  @override
  Widget build(BuildContext context) {

    void correction(int index) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Correction(index: index)));
    }

    return Scaffold(
      backgroundColor: mainFon,
      appBar: AppBarMetod(),
      body: SafeArea(
          child: Container(
            child: GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: defaultPadding),
            itemCount: myProd.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: defaultPadding/2,
            ),
            itemBuilder: (context, index) => InkWell(
              onTap: () => correction(index),
              child: Container(
                padding: EdgeInsets.all(5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Expanded(flex: 3 ,child: Image.asset(myProd[index].image, fit: BoxFit.fill, color: Colors.amber,)),
                  SizedBox(height: 5,),
                  Expanded(child: Text(myProd[index].name ,textAlign: TextAlign.center, style: TextStyle(fontSize: 20),))
                ],),
              ),
            ))
          )),
    );
  }

  AppBar AppBarMetod() {
    return AppBar(
        backgroundColor: mainFon,
        elevation: 0,
        title: Center(child: Text('Выберите рецепт', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold))),
        actions: <Widget>[
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search)),
        ],
      );
  }
}

class Product {
  final String name;
  final String image;
  Product({
    required this.name,
    required this.image,
  });
}

class Correction extends StatelessWidget {
  const Correction({
    Key? key,
    required this.index,
  }) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    void autoOrHands(int index) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => AutoOrHands(index: index)));
    }

    return Scaffold(
      backgroundColor: mainFon,
      appBar: AppBarMetod(),
      body: SafeArea(
          child: Container(
            // color: Colors.green,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text(myProd[index].name, style: TextStyle(fontSize: 30),),
              SizedBox(height: defaultPadding + 2,),
              SizedBox(
                height: size.height * 0.54,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
                  itemCount: receptStep.length,
                  itemBuilder: (context, index) => 
                  Container(
                    padding: EdgeInsets.all(defaultPadding / 2),
                    child: ContainerRadius(x: size.width * 0.25, y: size.height * 0.58, 
                    content: CorrectionCardContent(index: index),
                    )),
                ),
              ),
              SizedBox(height: 33,),
              SizedBox(
                  width: size.width * 0.31,
                  height: size.height * 0.16,
                child: ButtonMain(text: 'Начать!', color: Colors.amber, txtSize: 0.068, onClc: () => autoOrHands(index))),
            ],),
          )),
    );
  }

  AppBar AppBarMetod() {
    return AppBar(
        backgroundColor: mainFon,
        elevation: 0,
        title: Center(child: Text('Коррекция рецепта', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),)),
        actions: <Widget>[
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search)),
        ],
      );
  }
}

class CorrectionCardContent extends StatelessWidget {
  const CorrectionCardContent({
    Key? key,
    required this.index,
  }) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Text(receptStep[index], style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.w700),),       
        ...deviceStep
                  .map(
                    (e) => Row(
                      children: [
                        Text(e.title,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w400)),
                        Spacer(),
                        Container(
                          width: 47,
                          child: Text('50${e.indicate}',
                          textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700)),
                        )
                      ],
                    ),
                  )
                  .toList(),
        Divider(color:Color.fromRGBO(31, 10, 9, 0.4), height: 2,),
        Center(child: Text('00:00', style: TextStyle(color: Color.fromRGBO(31, 10, 9, 0.4), fontSize: 24, fontWeight: FontWeight.w700),))
        ],),
    );
  }
}

class DeviceStep {
  final String title;
  final String indicate;
  DeviceStep({
    required this.title,
    required this.indicate,
  });
}

class AutoOrHands extends StatelessWidget {
  const AutoOrHands({
    Key? key,
    required this.index,
  }) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    void directControl() {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => DirectControl()));
    }

    void cookingProcess(int index) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => CookingProcess(index: index,)));
    }
    
    return Scaffold(
      backgroundColor: mainFon,
      body: SafeArea(
          child: Center(
        child: Container(
          width: size.width * 0.63,
          height: size.height * 0.88,
          child: Column(
              children: [
                Expanded(
                  child: Row(children: [
                    InkWell(
                      onTap: () => cookingProcess(index),
                      child: ContainerRadius(
                        x: size.width * 0.3,
                        y: size.height * 68,
                        content: CardAuto(size),
                      ),
                    ),
                    const SizedBox(
                      width: defaultPadding,
                    ),
                    InkWell(
                      onTap: () => directControl(),
                      child: ContainerRadius(
                        x: size.width * 0.3,
                        y: size.height * 68,
                        content: CardHand(size),
                      ),
                    ),
                  ]),
                ),
                SizedBox(
                  height: defaultPadding + 4,
                ),
                SizedBox(
                    width: size.width * 0.31,
                  height: size.height * 0.16,
                    child: ButtonMain(
                      text: 'Отмена',
                      color: Colors.white,
                      txtSize: 0.068,
                      onClc: () => Navigator.pop(context),
                    )),
              ],
            )),
      )),
    );
  }

  Container CardAuto(Size size) {
    return Container(
                        padding: EdgeInsets.all(defaultPadding),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                  height: size.height * 0.25,
                                  child: FittedBox(
                                    child: contentMenu[4].icon,
                                  )),
                                  SizedBox( height: 12,),
                              SizedBox(
                                  height: size.height * 0.126,
                                  child: Text(
                                    contentMenu[4].title,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  )),
                              SizedBox( height: 5,),
                              SizedBox(
                                  child: Text(
                                    contentMenu[4].text,
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black),
                                  ))
                            ]),
                      );
  }
  Container CardHand(Size size) {
    return Container(
                        padding: EdgeInsets.all(defaultPadding),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                  height: size.height * 0.25,
                                  child: FittedBox(
                                    child: contentMenu[5].icon,
                                  )),
                                  SizedBox( height: 12,),
                              SizedBox(
                                  height: size.height * 0.065,
                                  width: double.infinity,
                                  child: Text(
                                    contentMenu[5].title,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  )),
                              SizedBox( height: 5,),
                              SizedBox(
                                  child: Text(
                                    contentMenu[5].text,
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black),
                                  ))
                            ]),
                      );
  }
}

class CookingProcess extends StatelessWidget {
  const CookingProcess({
    Key? key,
    required this.index,
  }) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: mainFon,
      appBar: AppBarMetod(index),
      body: SafeArea(
          child: Center(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: defaultPadding + 4),
          // width: size.width * 0.75,
          // height: size.height * 0.8,
          // color: Colors.green,
          child: SizedBox(
            height: size.height * 0.75,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
              itemCount: receptStep.length,
              itemBuilder: (context, index) => Container(
                  padding: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
                  child: ContainerRadius(
                    x: size.width * 0.51,
                    y: size.height * 0.75,
                    content: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: size.height * 0.073,
                          child: Center(
                              child: Text(receptStep[index],
                                  style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700))),
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(24),
                                topRight: Radius.circular(24)),
                          ),
                        ),
                        SizedBox(height: defaultPadding,),
                        SizedBox(
                          width: size.width * 0.444,
                          height: size.height * 0.48,
                          child: GridView.builder(
                              padding: EdgeInsets.symmetric(
                                  horizontal: defaultPadding),
                              itemCount: deviceStep.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      // mainAxisSpacing: 5,
                                      // crossAxisSpacing: 5,
                                      childAspectRatio: 2.1),
                              itemBuilder: (context, index) =>
                                  ContentItem(index)),
                        ),
                        Divider(
                          color: Color.fromRGBO(31, 10, 9, 0.4),
                          height: 2,
                        ),
                        SizedBox(
                          height: defaultPadding,
                        ),
                        Center(
                            child: Text(
                          '00:00',
                          style: TextStyle(
                              color: Color.fromRGBO(31, 10, 9, 0.4),
                              fontSize: 34,
                              fontWeight: FontWeight.w700),
                        ))
                      ],
                    ),
                  )),
            ),
          ),
        ),
      )),
    );
  }

  Container ContentItem(int index) {
    return Container(
      height: 100,
      // color: Colors.green,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            deviceStep[index].title,
            style: style20,
          ),
          Row(
            children: [
              Text('56', style: style56),
              Text(deviceStep[index].indicate, style: style56),
              Icon(
                Icons.arrow_back_outlined,
                color: Colors.red,
              ),
              Text(
                '70',
                style: style32,
              )
            ],
          )
        ],
      ),
    );
  }

  AppBar AppBarMetod(int index) {
    return AppBar(
      backgroundColor: mainFon,
      elevation: 0,
      title: Container(
        padding: EdgeInsets.symmetric(vertical: defaultPadding / 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Готовим',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
            Text(myProd[index].name,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      actions: <Widget>[
        IconButton(onPressed: () {}, icon: const Icon(Icons.expand_rounded)),
        IconButton(onPressed: () {}, icon: const Icon(Icons.graphic_eq)),
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.lightbulb_outline_rounded,
              color: Colors.amber,
            )),
      ],
    );
  }
}


List<ContentMenu> contentMenu = [
  ContentMenu(title: 'Готовить по рецепту', text: 'Выберите рецепт и готовьте в автоматическом или ручном режиме', icon: const Icon(Icons.book , color: Colors.amber)),
  ContentMenu(title: 'Прямое управление', text: 'Получите прямой доступ к функциям сыроварни', icon: const Icon(Icons.settings, color: Colors.amber)),
  ContentMenu(title: 'Создать рецепт', text: '', icon: const Icon(Icons.add , color: Colors.amber)),
  ContentMenu(title: '', text: '', icon: const Icon(Icons.more_horiz , color: Colors.amber)),
  ContentMenu(title: 'Автоматический режим', text: 'Коптильня будет сама переключать режимы работы. Остается только засыпать ингредиенты в нужное время.', icon: const Icon(Icons.hdr_auto_sharp, color: Colors.amber)),
  ContentMenu(title: 'Ручной режим', text: 'Возьмите коптильню под полный контроль и пользуйтесь рецептом как подсказкой.', icon: const Icon(Icons.handyman_outlined, color: Colors.amber,)),
];

List<Product> myProd = [
  Product(name: 'Копченая свинина с сидровым мопом', image: 'assets/images/001.png'),
  Product(name: 'Копченая индейка', image: 'assets/images/002.png'),
  Product(name: 'Сыровяленый рулет из говядины', image: 'assets/images/003.png'),
  Product(name: 'Варено-копченая свинина', image: 'assets/images/004.png'),
  Product(name: 'Окорок копченый с томатами', image: 'assets/images/005.png'),
  Product(name: 'Варено-копченая индейка', image: 'assets/images/006.png'),
  Product(name: 'Бекон из окорока и лопатки', image: 'assets/images/007.png'),
  Product(name: 'Карбонад из свинины', image: 'assets/images/008.png'),
  Product(name: 'Бастурма с овощами', image: 'assets/images/009.png'),
];

List<String> receptStep = [
  'Прогрев',
  'Сушка',
  'Нагрев',
  'Копчение',
  'Проветривание',
  'Варка'
];

List<DeviceStep> deviceStep = [
  DeviceStep(title: 't камеры', indicate: '°' ),
  DeviceStep(title: 't продукта', indicate: '°' ),
  DeviceStep(title: 'Влажность', indicate: '%' ),
  DeviceStep(title: 'Вентилятор', indicate: '%' ),
  DeviceStep(title: 'Дымогенератор', indicate: '' ),
  DeviceStep(title: 'Заслонка', indicate: '' ),  
];



class ValueStep {
  int tw;
  int tm;
  int wl;
  int vt;
  bool dg;
  bool zs;
  ValueStep(
    this.tw,
    this.tm,
    this.wl,
    this.vt,
    this.dg,
    this.zs,
  );
}

class Warming extends ValueStep{
  String name = 'Прогрев';
  Warming(tw, this.name) : super(tw, 0, 0, 0, false, false);
}

class Heat extends ValueStep{
  String name = 'Нагрев';
  Heat(tm, this.name) : super(0, tm, 0, 0, false, false);
}

class Drying extends ValueStep{
  String name = 'Сушка';
  Drying(tw, tm, wl, vt, zs, this.name) : super(tw, tm, wl, vt, false, zs);
}

class Smoking extends ValueStep{
  String name = 'Копчение';
  Smoking(tw, tm, wl, vt, dg, zs, this.name) : super(tw, tm, wl, vt, dg, zs);
}

class Ventilate extends ValueStep{
  String name = 'Проветривание';
  Ventilate(tw, tm, wl, vt, dg, zs, this.name) : super(tw, tm, wl, vt, dg, zs);
}

class Boiling extends ValueStep{
  String name = 'Варка';
  Boiling(tw, tm, wl, vt, dg, zs, this.name) : super(tw, tm, wl, vt, dg, zs);
}

