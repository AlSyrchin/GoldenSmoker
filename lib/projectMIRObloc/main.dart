import 'etap.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    return MaterialApp(
      theme: ThemeData.dark(),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              ElevatedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => const Recipe()));}, child: const Text('Рецепты')),
              ElevatedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => Create()));}, child: const Text('Создать рецепт')),
              ElevatedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => const Rules()));}, child: const Text('Прямое управление'))
            ],),
          )),
    );
  }
}

class Recipe extends StatelessWidget {
  const Recipe({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Рецепты'),),
      body: SafeArea(child: 
      ListView.builder(
        itemBuilder: (context, index) => InkWell(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Cooking(index))),
          child: SizedBox(height: 80, width: double.maxFinite, child: Text(listRecipe[index].name, style: const TextStyle(color: Colors.amber))),
          ),
        itemCount: listRecipe.length,
      )),
    );
  }
}

class Create extends StatelessWidget {
  Create({super.key});
  List<Stage> stages = [Drying(10, 24, 43)];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Создать рецепт'),),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
              children: [
          const FeildTxt('Name'),
          SizedBox(
            height: 350,
            child: ListView.builder(
              itemBuilder: (context, index) => Text(stages[index].name),
              itemCount: stages.length,
            ),
          ),
          ElevatedButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => NewStep(stages))), child: const Text('Создать')),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: (){}, child: const Text('Сохранить')),
              ElevatedButton(onPressed: (){}, child: const Text('Готовить'))
              ],
          )
              ],
            ),
        )),
    );
  }
}

class Rules extends StatelessWidget {
  const Rules({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Прямое управление'),),
      body: SafeArea(child: SingleChildScrollView(
          child: Column(
            children: [
            SizedBox(width: double.maxFinite, child: Text('t box: ${plata.cTB}')),
            SizedBox(width: double.maxFinite, child: Text('t prod: ${plata.cTP}')),
            const FeildTxt('Temperature box'),
            const FeildTxt('Temperature prod'),
            const FeildTxt('Time'),
             SwichWidg('Вытяжка', plata.vit),
             SwichWidg('Заслонка', plata.flap),
             SwichWidg('Дымоген', plata.smoke),
             SwichWidg('Пароген', plata.parogen),
          ],),
        ),
      ),
    );
  }
}

class Cooking extends StatelessWidget {
  const Cooking(this.indexR, {super.key});
  final int indexR;
  @override
  Widget build(BuildContext context) {
    final list = listRecipe[indexR];
    final stage = listRecipe[indexR].stages;
    return Scaffold(
      appBar: AppBar(title: Text('Готовка ${list.name}'),),
      body: SafeArea(
        child: ListView.builder(
          itemCount: stage.length,
          itemBuilder: (context, index) => Text(stage[index].name, style: const TextStyle(color: Colors.blue),),
          ),
    ));
  }
}

class NewStep extends StatelessWidget {
  const NewStep(this.stages, {super.key});
  final List<Stage> stages;
  @override
  Widget build(BuildContext context) {

     return Scaffold(
      appBar: AppBar(title: const Text('Создать'),),
      body: SafeArea(child: SingleChildScrollView(
          child: Column(
            children: [
            const FeildTxt('Name'),
            const FeildTxt('Temperature box'),
            const FeildTxt('Temperature prod'),
            const FeildTxt('Time'),
            const SwichWidg('Вытяжка', false),
            const SwichWidg('Заслонка', false),
            const SwichWidg('Дымоген', false),
            const SwichWidg('Пароген', false),
             ElevatedButton(onPressed: (){stages.add(Unique('Eff', 10, 20, 10, true, false, false, false, false)); Navigator.pop(context);}, child: const Text('Добавить'))
          ],),
        ),
      ),
    );
  }
}







class FeildTxt extends StatelessWidget {
  const FeildTxt(this.name, {super.key});
  final String name;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
          decoration: InputDecoration(
          errorText: null,
          isDense: true,
          contentPadding: EdgeInsets.all(5),
          border: InputBorder.none,
          labelText: name,
        ),);
  }
}

class SwichWidg extends StatelessWidget {
  const SwichWidg(this.name, this.data, {super.key});
  final bool data;
  final String name;
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Text(name),
      SwitchP(data)
    ],);
  }
}

class SwitchP extends StatefulWidget {
  SwitchP(this.data ,{super.key});
  bool data;
  @override
  State<SwitchP> createState() => _SwitchPState();
}
class _SwitchPState extends State<SwitchP> {
  @override
  Widget build(BuildContext context) {
    return Switch(
              value: widget.data,
              onChanged: (value) {
                setState(() {
                  widget.data = value;
                });
              },
              activeTrackColor: Colors.amberAccent,
              activeColor: Colors.amber,
            );
  }
}