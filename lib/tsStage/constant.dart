import 'package:flutter/material.dart';

const t24w500 = TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: mainFon);
const t14w500 = TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: mainFon);
const t26w500 = TextStyle(fontSize: 26, fontWeight: FontWeight.w500, color: mainFon);
const t29w500w = TextStyle(fontSize: 29, fontWeight: FontWeight.w500, color: Colors.white);
const t62w500 = TextStyle(fontSize: 62, fontWeight: FontWeight.w500, color: mainFon);
const t32w500 = TextStyle(fontSize: 32, fontWeight: FontWeight.w500, color: mainFon);
const t34w500a = TextStyle(fontSize: 34, fontWeight: FontWeight.w500, color: Colors.amber);
const t24w500a = TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: Colors.amber);
const t46w700 = TextStyle(fontSize: 46, fontWeight: FontWeight.w700);
const t16w400 = TextStyle(fontSize: 16, fontWeight: FontWeight.w400);

const stWidg = VisualDensity(horizontal: 0, vertical: -4);
const Color mainFon = Color.fromRGBO(31, 10, 9, 1);
const Color noActive = Color.fromRGBO(179, 179, 179, 1);
const Color mainFon04 = Color.fromRGBO(31, 10, 9, 0.4);
const Color white02 = Color.fromRGBO(255, 255, 255, 0.2);
const String indicate = '°';
const defaultPadding = 12.0;

const List<String> deviceCard = [
  't камеры',
  't продукта',
  'Пароген',
  'Компрессор',
  'Заслонка',
  'Вытяжка'
];

class IdName {
  final int index;
  final String name;
  IdName(
    this.index,
    this.name,
  );
}

List<IdName> nameStep = [
  IdName(0, 'Отепление'),
  IdName(1, 'Сушка'),
  IdName(2, 'Варка'),
  IdName(3, 'Копчение'),
  IdName(4, 'Жарка'),
];

double h(context, double height){
  return MediaQuery.of(context).size.height * height/990; 
}
double w(context, double width){
  return MediaQuery.of(context).size.width * width/1440; 
}