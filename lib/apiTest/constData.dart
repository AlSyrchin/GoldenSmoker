import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'state/stateControl.dart';



const pad16 = 16.0;
const pad8 = 8.0;
const padAll16 = EdgeInsets.all(pad16);
const padAll8 = EdgeInsets.all(pad8);
const padSym1610 = EdgeInsets.symmetric(horizontal: 16, vertical: 10);
const padSym1613 = EdgeInsets.symmetric(horizontal: 16, vertical: 13);
const padSym1612 = EdgeInsets.symmetric(horizontal: 16, vertical: 12);
const padTop8 = EdgeInsets.only(top: 8);

const borderRad5 = BorderRadius.all(Radius.circular(5));
const borderRad15 = BorderRadius.all(Radius.circular(15));

const decor = BoxDecoration(color: kWhite, borderRadius: BorderRadius.all(Radius.circular(12)));

const titleblue = TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: kBlue);
const title14 = TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: kGrey);
const title14sm = TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: kGrey);
const titleblue16 = TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: kBlue);
const titleblue16L = TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: kBlue);
const titleGrey = TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: kGrey, );
const titleGreyH = TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: kGrey);
const litleTitle = TextStyle(fontSize: 16, fontWeight: FontWeight.w400);
const litleTitleH = TextStyle(fontSize: 16, fontWeight: FontWeight.w500);
const titleName = TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: kBlack);
const headTitle = TextStyle(fontSize: 22,  fontWeight: FontWeight.w500,);
const titlePrice = TextStyle(fontSize: 30, fontWeight: FontWeight.w600, );

var formRu = NumberFormat.decimalPattern('ru');

const kOrange = Color.fromRGBO(255, 168, 0, 1);
const kOrange02 = Color.fromRGBO(255, 199, 0, 0.2);
const kBlue = Color.fromRGBO(13, 114, 255, 1);
const kBlue01 = Color.fromRGBO(13, 114, 255, 0.1);
const kGrey = Color.fromRGBO(130, 135, 150, 1);
const kLightGrey = Color.fromRGBO(251, 251, 252, 1);
const kDarkGrey = Color.fromRGBO(44, 48, 53, 1);
const kInputBack = Color.fromRGBO(246, 246, 249, 1);
const kInputLable = Color.fromRGBO(169, 171, 183, 1);
const kInputText = Color.fromRGBO(20, 20, 43, 1);
const kBlack = Color.fromRGBO(0, 0, 0, 0.9);
const kBlack09 = Color.fromRGBO(0, 0, 0, 0.9);
const kBlack02 = Color.fromRGBO(0, 0, 0, 0.22);
const kBlack01 = Color.fromRGBO(0, 0, 0, 0.17);
const kWhite = Color.fromRGBO(255, 255, 255, 1);
const kLine = Color.fromRGBO(232, 233, 236, 1);

class InputList {
  final String title;
  final TextInputType type;
  InputList({
    required this.title,
    required this.type,
  });
}

class TitleListInfo {
  final String title;
  final String body;
  TitleListInfo({
    required this.title,
    required this.body,
  });
}

class ListTit {
  final String title;
  final Image leading;
  ListTit({
    required this.title,
    required this.leading,
  });
}

List<ListTit> listTit = [
  ListTit(title: 'Удобства', leading: Image.asset('assets/images/emoji_happy.png')),
  ListTit(title: 'Что включено', leading: Image.asset('assets/images/tick_square.png')),
  ListTit(title: 'Что не включено', leading: Image.asset('assets/images/close_square.png')),
];

final List<TitleListInfo> listBron = [
  TitleListInfo(title: 'Вылет из', body: Get.put(StateBron()).bron.departure!),
  TitleListInfo(title: 'Страна, город', body: Get.put(StateBron()).bron.arrivalCountry!),
  TitleListInfo(title: 'Даты', body: '${Get.put(StateBron()).bron.tourDateStart!} — ${Get.put(StateBron()).bron.tourDateStop!}'),
  TitleListInfo(title: 'Кол-во ночей',body: '${Get.put(StateBron()).bron.numberNights!} ночей'),
  TitleListInfo(title: 'Отель', body: Get.put(StateBron()).bron.hotelName!),
  TitleListInfo(title: 'Номер', body: Get.put(StateBron()).bron.room!),
  TitleListInfo(title: 'Питание', body: Get.put(StateBron()).bron.nutrition!),
];

final List<InputList> strTitle = [
  InputList(title: 'Имя', type: TextInputType.name),
  InputList(title: 'Фамилия', type: TextInputType.name),
  InputList(title: 'Дата рождения', type: TextInputType.datetime),
  InputList(title: 'Гражданство', type: TextInputType.name),
  InputList(title: 'Номер загранпаспорта', type: TextInputType.number),
  InputList(title: 'Срок действия загранпаспорта', type: TextInputType.datetime),
];

final List<TitleListInfo> listPrice = [
  TitleListInfo(title: 'Тур',body: formRu.format(Get.put(StateBron()).bron.tourPrice!)),
  TitleListInfo(title: 'Топливный сбор',body: formRu.format(Get.put(StateBron()).bron.fuelCharge!)),
  TitleListInfo(title: 'Сервисный сбор',body: formRu.format(Get.put(StateBron()).bron.serviceCharge!)),
  TitleListInfo(title: 'К оплате', body: formRu.format(Get.put(StateBron()).getSum())),
];

const imgIconString = 'https://s3-alpha-sig.figma.com/img/b5dc/d34d/d2abd25e1e2a28fb0d889f2cae7cffb2?Expires=1694995200&Signature=i-Mb67EFiGSzKU8vlWMk11WnZqhHH~oceK6F-jHE05EI1Y6N4HG36yJELqnWAcbhB~IlRg0uWDK2SG1aXmnH4U6VKBpJMnt3N4SKLY3~D0wGPS0awvNOQ-OPzzIRUI~DVIJS4E08Fhs7EN8DwH~HXV4GboxaZ~fJrbv4Aob7XvCskbVheB~WtdWCCnfymRA83YsR35dembqKYLSwZ8HqwGaPff~TJU58HH0AphShSti5ZraKVNYekPti-gu7xuvaBWAiHf7npuGOVUcJ-syKDjqnGsuWfjK50hpxx7uWJU2KqO28mM9TtW67oPtmt26xNbISvDCnZiZVGDmjOd5jdg__&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4';

