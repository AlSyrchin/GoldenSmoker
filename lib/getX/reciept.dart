// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'goldenWidget.dart';
import 'timer.dart';

const String indicate = '°';
    const style20t = TextStyle(fontSize: 20, color: Colors.black);
    const style24t = TextStyle(fontSize: 24, color: Colors.black);
    const style20f = TextStyle(fontSize: 20, color: Colors.black26);
    const style24f = TextStyle(fontSize: 24, color: Colors.black26);

String convertDoubleFromString(double param) {
  return '${(param * 10).toInt()}';
}

abstract class Stage {
  String generateStringCommand();
  Widget generateWidgetInfo();
}


class RecipeController {
  List<Stage> listStages = [Related(50), Drying(60, 60), Boiling(70,60), Smoking(80, 20), Smoking(10, 10)];
  int indexCurrentStage  = 1;

  Widget widgetCurrentStage() {
    return listStages[indexCurrentStage].generateWidgetInfo();
  }

   Widget widgetAllStage() {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: listStages.map((e) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
                width: 260,
                height: 325,
                color: Colors.white,
                child: e.generateWidgetInfo()
    )
    ).toList(),);
  }

  void nextStage(){}

  void sendRecipe() {
    String result = listStages.map<String>((e) => e.generateStringCommand()).join('_'); // "MB500~M!W_MB600~M!S"
    
  }

}

//Отепление
class Related extends Stage {
  final double value;
  final String name = 'Отепление';
  Related(this.value);

  @override
  String generateStringCommand() {
    return "MP${convertDoubleFromString(value)}~M!TF";
  }

  @override
  Widget generateWidgetInfo() {
    return ListViewCard(name: name, tProd: value); // + ten
  }
}

//Сушка
class Drying extends Stage {
  final double value;
  final int valueMT;
  final String name = 'Сушка';
  Drying(this.value, this.valueMT);

  @override
  String generateStringCommand() {
    return "MP${convertDoubleFromString(value)}MT$valueMT~M!TFA";
  }

  @override
  Widget generateWidgetInfo() {
    return ListViewCard(name: name, tProd: value, zaslon: true, time: valueMT,);// + ten + vitzhka
  }
}

//Варка
class Boiling extends Stage {
   final double value;
  final int valueMT;
  final String name = 'Варка';
  Boiling(this.value, this.valueMT);

  @override
  String generateStringCommand() {
    return "MP${convertDoubleFromString(value)}MT$valueMT~M!WTF";
  }

  @override
  Widget generateWidgetInfo() {
    return ListViewCard(name: name, tProd: value, parogen: true, time: valueMT,); // + ten
  }

}

//Копчение
class Smoking extends Stage {
  final double value;
  final int valueMT;
  final String name = 'Копчение';
  Smoking(this.value, this.valueMT);

  @override
  String generateStringCommand() {
    return "MB${convertDoubleFromString(value)}MT$valueMT~M!TFS";
  }

  @override
  Widget generateWidgetInfo() {
    return ListViewCard(name: name, tBox: value, compres: true, time: valueMT,); // + ten + vitzhka
  }
}

//Жарка / Прогрев
class Frying extends Stage {
  final double value;
  final String name = 'Жарка';
  Frying(this.value);

  @override
  String generateStringCommand() {
    return "MB${convertDoubleFromString(value)}~M!TF";
  }

  @override
  Widget generateWidgetInfo() {
    return ListViewCard(name: name, tProd: value); //+ ten
  }
}


///////////////////////////////////////////////////////////////////////Шаблон
class ListViewCard extends StatelessWidget {
  const ListViewCard({
    Key? key,
    required this.name,
    this.tBox,
    this.tProd,
    this.time,
    this.parogen,
    this.compres,
    this.zaslon,
  }) : super(key: key);
  final String name;
  final double? tBox;
  final double? tProd;
  final int? time;
  final bool? parogen;
  final bool? compres;
  final bool? zaslon;
  @override
  Widget build(BuildContext context) {
    const stWidg = VisualDensity(horizontal: 0, vertical: -4);
    return 
    Column(
      children: [
        Text(name, style: style24t),
        ListTile(
          onTap: () => tBox!= null ? dialog(context, deviceStep[0],) :() {},
          visualDensity: stWidg,
          dense:true,
          title: tBox != null ? Text(deviceStep[0], style: style24t) : Text(deviceStep[0], style: style24f),
          trailing: tBox != null ? Text('${tBox!.toInt()}$indicate', style: style24t) : Text('1$indicate', style: style24f),
        ),
        ListTile(
          visualDensity: stWidg,
          dense:true,
          onTap: () => tProd!= null ? dialog(context, deviceStep[1],) :() {},
          title: tProd != null ? Text(deviceStep[1], style: style24t) : Text(deviceStep[1], style: style24f),
          trailing: tProd != null ? Text('${tProd!.toInt()}$indicate', style: style24t) : Text('1$indicate', style: style24f),
        ),
        ListTile(
          visualDensity: stWidg,
          dense:true,
          title: parogen != null ? Text(deviceStep[2], style: style24t) : Text(deviceStep[2], style: style24f),
          trailing: parogen != null ? Text('Вкл.', style: style20t) : Text('Выкл.', style: style20f),
        ),
        ListTile(
          visualDensity: stWidg,
          dense:true,
          title: compres != null ? Text(deviceStep[3], style: style24t) : Text(deviceStep[3], style: style24f),
          trailing: compres != null ? Text('Вкл.', style: style20t) : Text('Выкл.', style: style20f),
        ),
        ListTile(
          visualDensity: stWidg,
          dense:true,
          title: zaslon != null ? Text(deviceStep[4], style: style24t) : Text(deviceStep[4], style: style24f),
          trailing: zaslon != null ? Text('Откр.', style: style20t) : Text('Закр.', style: style20f),
        ),
        const Divider(color: Colors.black26,),
        time !=null ? Text('00:$time', style: style24t) : Text('00:00', style: style24f)
      ] //TimerSec(DateTime.now().add(Duration(seconds: time!)))
    );
  }

  TimerBuilder TimerSec(DateTime alert) {
    return TimerBuilder.scheduled([alert], builder: (context) {
            var now = DateTime.now();
            var reached = now.compareTo(alert) >= 0;
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  !reached
                      ? TimerBuilder.periodic(Duration(seconds: 1),
                          alignment: Duration.zero, builder: (context) {
                          var now = DateTime.now();
                          var remaining = alert.difference(now);
                          return Text(
                            formatDuration(remaining), style: style24t
                          );
                        })
                      : Text("00:00", style: style24f,),
                ],
              ),
            );
          });
  }

  Future<dynamic> dialog(BuildContext context, String name) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.amber,
            title: Text(name),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Picker(),
                ElevatedButton(child: Text("Select"), onPressed: () {})
              ],
            ),
          );
        });
  }
}

List<String> deviceStep = [
  't камеры',
  't продукта',
  'Пароген',
  'Компрессор',
  'Заслонка',  
];



