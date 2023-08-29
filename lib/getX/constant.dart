import 'package:flutter/material.dart';

const stWidg = VisualDensity(horizontal: 0, vertical: -4);
const Color mainFon = Color.fromRGBO(31, 10, 9, 1);
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