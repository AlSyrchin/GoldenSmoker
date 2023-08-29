// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import 'commandFile.dart';
// import 'recieptsStep.dart';

// String convertDoubleFromString(double param) {
//   return '${(param * 10).toInt()}';
// }

// class RecipeController extends GetxController {
//   RxList<Stage> listStages = <Stage>[].obs;
//   int indexCurrentStage = 1;

//   Widget widgetCurrentStage() {
//     return listStages[indexCurrentStage].generateWidgetInfo(indexCurrentStage);
//   }

//   Widget widgetAllStage() {
//     return ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: listStages.length,
//         itemBuilder: (context, index) => Card(
//               color: Colors.white,
//               margin: const EdgeInsets.symmetric(horizontal: 20),
//               child: SizedBox(
//                   width: 260,
//                   height: 325,
//                   child: Column(
//                     children: [
//                       listStages[index].generateWidgetInfo(index),
//                       IconButton(
//                         onPressed: () => removeStageIndex(index),
//                         icon: const Icon(Icons.delete, color: Colors.red),
//                       )
//                     ],
//                   )),
//             ));
//   }

//   void removeStageIndex(int index) {
//     if (listStages.isNotEmpty) listStages.removeAt(index);
//   }

//   void editStageIndex(int index, double val, int? time) {
//     listStages[index].copyW(val, time);
//     update();
//   }

//   void nextStage() {}

//   String sendRecipe() {
//     return listStages.map<String>((e) => e.generateStringCommand()).join('_');
//   }
// }

// abstract class Stage {
//   String generateStringCommand();
//   Widget generateWidgetInfo(int index);
//   void copyW(double? d, int? i);
// }

// //Отепление
// class Related extends Stage {
//   double value;
//   final String name = 'Отепление';
//   Related(this.value);

//   @override
//   String generateStringCommand() {
//     return "$RECIPE_ADD${ACTION_INPUT}MP${convertDoubleFromString(value)}~M!TF";
//   }

//   @override
//   Widget generateWidgetInfo(int index) {
//     return ListViewCard(name: name, tProd: value, index: index); // + ten
//   }

//   void copyWith(double? val) {
//     value = val!;
//   }

//   @override
//   void copyW(double? d, int? i) {
//     copyWith(d);
//   }
// }

// //Сушка
// class Drying extends Stage {
//   double value;
//   int valueMT;
//   final String name = 'Сушка';
//   Drying(this.value, this.valueMT);

//   @override
//   String generateStringCommand() {
//     return "$RECIPE_ADD${ACTION_INPUT}MP${convertDoubleFromString(value)}MT$valueMT~M!TFA";
//   }

//   @override
//   Widget generateWidgetInfo(int index) {
//     return ListViewCard(
//         name: name,
//         tProd: value,
//         flap: true,
//         time: '$valueMT',
//         index: index); // + ten + vitzhka
//   }

//   Drying copyWith(
//     double? value,
//     int? valueMT,
//   ) {
//     return Drying(
//       value ?? this.value,
//       valueMT ?? this.valueMT,
//     );
//   }

//   @override
//   Stage copyW(double? d, int? i) {
//     return copyWith(d, i);
//   }
// }

// //Варка
// class Boiling extends Stage {
//   double value;
//   int valueMT;
//   final String name = 'Варка';
//   Boiling(this.value, this.valueMT);

//   @override
//   String generateStringCommand() {
//     return "$RECIPE_ADD${ACTION_INPUT}MP${convertDoubleFromString(value)}MT$valueMT~M!WTF";
//   }

//   @override
//   Widget generateWidgetInfo(int index) {
//     return ListViewCard(
//         name: name,
//         tProd: value,
//         water: true,
//         time: '$valueMT',
//         index: index); // + ten
//   }

//   Boiling copyWith(
//     double? value,
//     int? valueMT,
//   ) {
//     return Boiling(
//       value ?? this.value,
//       valueMT ?? this.valueMT,
//     );
//   }

//   @override
//   Stage copyW(double? d, int? i) {
//     return copyWith(d, i);
//   }
// }

// //Копчение
// class Smoking extends Stage {
//   double value;
//   int valueMT;
//   final String name = 'Копчение';
//   Smoking(this.value, this.valueMT);

//   @override
//   String generateStringCommand() {
//     return "$RECIPE_ADD${ACTION_INPUT}MB${convertDoubleFromString(value)}MT$valueMT~M!TFS";
//   }

//   @override
//   Widget generateWidgetInfo(int index) {
//     return ListViewCard(
//         name: name,
//         tBox: value,
//         smoke: true,
//         time: '$valueMT',
//         index: index); // + ten + vitzhka
//   }

//   Smoking copyWith(
//     double? value,
//     int? valueMT,
//   ) {
//     return Smoking(
//       value ?? this.value,
//       valueMT ?? this.valueMT,
//     );
//   }

//   @override
//   Stage copyW(double? d, int? i) {
//     return copyWith(d, i);
//   }
// }

// //Жарка / Прогрев
// class Frying extends Stage {
//   double value;
//   final String name = 'Жарка';
//   Frying(this.value);

//   @override
//   String generateStringCommand() {
//     return "$RECIPE_ADD${ACTION_INPUT}MB${convertDoubleFromString(value)}~M!TF";
//   }

//   @override
//   Widget generateWidgetInfo(int index) {
//     return ListViewCard(name: name, tProd: value, index: index); //+ ten
//   }

//   Frying copyWith(
//     double? value,
//   ) {
//     return Frying(
//       value ?? this.value,
//     );
//   }

//   @override
//   Stage copyW(double? d, int? i) {
//     return copyWith(d);
//   }
// }
