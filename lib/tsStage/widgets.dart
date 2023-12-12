import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'constant.dart';
import 'stage.dart';


  String getTimeString(int value) {
    final int hour = value ~/ 60;
    final int minutes = value % 60;
    return '0:${hour.toString().padLeft(2, "0")}:${minutes.toString().padLeft(2, "0")}';
}

class TimeWidgetConvert extends StatelessWidget {
  const TimeWidgetConvert(this.timeMin, {Key? key}) : super(key: key);

  // final List<Stage> listStage;
  // final int index;
  final int timeMin;

  String getTimeString(int value) {
    final int hour = value ~/ 60;
    final int minutes = value % 60;
    return '${hour.toString().padLeft(2, "0")}:${minutes.toString().padLeft(2, "0")}';
}

  @override
  Widget build(BuildContext context) {
    return Text('${DateFormat.m().format(DateTime.parse('00000000T${getTimeString(timeMin)}00'))} мин', style: t24w500);
  }
}

class TimeWidget extends StatelessWidget {
  const TimeWidget({
    Key? key,
    required this.listStage,
    required this.index,
  }) : super(key: key);

  final List<Stage> listStage;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Text('${listStage[index].time} мин', style: t24w500, textAlign: TextAlign.center);
  }
}

class IndicateWidget extends StatelessWidget {
  const IndicateWidget({
    Key? key,
    required this.listStage,
    required this.index,
    required this.color,
    required this.size,
  }) : super(key: key);

  final List<Stage> listStage;
  final int index;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        listStage[index].extractor
            ? Icon(Icons.leak_add, color: color, size: size)
            : Icon(Icons.leak_add, color: noActive, size: size),
        listStage[index].smoke
            ? Icon(Icons.smoking_rooms_rounded, color: color, size: size)
            : Icon(Icons.smoking_rooms_rounded, color: noActive, size: size),
        listStage[index].water
            ? Icon(Icons.opacity, color: color, size: size)
            : Icon(Icons.opacity, color: noActive, size: size),
        listStage[index].flap
            ? Icon(Icons.extension, color: color, size: size)
            : Icon(Icons.extension, color: noActive, size: size),
      ],
    );
  }
}

class ContanerRadius extends StatelessWidget {
  const ContanerRadius(this.color, this.radius, {this.text, this.child, super.key});
  final Color color;
  final String? text;
  final double radius;
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Container(
        // width: w(context, 320 * width),
        // height: h(context, 320 * height),
        color: color,
        // decoration: BoxDecoration(color: color, borderRadius: BorderRadius.all(Radius.circular(16 * width))),
        child: child ?? Center(child: Text(text!, style: TextStyle(color: mainFon, fontSize: h(context, 48)), textAlign: TextAlign.center,))
      ),
    );
  }
}
// Поменять раскладку размеров
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
          padding: const EdgeInsets.symmetric(horizontal: 12),
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
