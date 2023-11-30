import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'constant.dart';
import 'cubit_free.dart';
import 'cubit_two.dart';
import 'stage.dart';
import 'state_free.dart';
import 'state_two.dart';
import 'widgets.dart';

class PageTwo extends StatelessWidget {
  const PageTwo(this.stage, {super.key});
  final List<Stage> stage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Создать этап'),
        backgroundColor: mainFon,
      ),
      backgroundColor: mainFon,
      body: Container(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: BlocProvider(create: (context) => CubitFree(),
          child: BlocBuilder<CubitFree,StateFree>(builder: (context, state) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
              const ButtonListWidget(),
              const SizedBox(height: 16*2),

              state.btnList[1] ? const ToggleButtonsWidget('Заслонка') : Container(),
              state.btnList[2] ? const ToggleButtonsWidget('Пароген')  : Container(),
              state.btnList[3] ? const ToggleButtonsWidget('Компрессор') : Container(),

              state.btnList[5] ? TextControlWidget(true): Container(),
              const SizedBox(height: 16),

              state.btnList[0] || state.btnList[4] ? Container() : TextControlWidgetT(false),
              const SizedBox(height: 16),
        
              const SliderWidget(true), 
              const SizedBox(height: 16),
        
              const SliderWidget(false), 
              const SizedBox(height: 16),

              state.btnList[5] ? const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SwitchWidget(0),
                  SizedBox(width: 16),
                  SwitchWidget(1),
                  SizedBox(width: 16),
                  SwitchWidget(2),
                  SizedBox(width: 16),
                  SwitchWidget(3),
                  SizedBox(width: 16),
                  SwitchWidget(4),
                ],
              ) : Container(),           
              const Divider(),
              InkWell(
                onTap: (){
                  context.read<CubitTwo>().addItem(state.btnList);
                  context.read<CubitTwo>().restart();
                  Navigator.pop(context);
                },
                child: const ContanerRadius(Colors.amber, 'Добавить', 1)),

            ],
          ),),),
        ),
      ),
    );
  }
}

class ToggleButtonsWidget extends StatelessWidget {
  const ToggleButtonsWidget(this.data, {Key? key}) : super(key: key);
  final String data;

  @override
  Widget build(BuildContext context) {
    final listBool = [false,true];
    return Row(
      children: [
        Text('$data: '),
        const SizedBox(width: 20,),
        ToggleButtons(
          onPressed: (index) {},
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          borderColor: Colors.white,
          selectedBorderColor: Colors.white,
          selectedColor: mainFon,
          fillColor: Colors.white,
          color: Colors.white,
          constraints: const BoxConstraints(
            minHeight: 40.0,
            minWidth: 80.0,
          ),
          isSelected: listBool,
          children: data == 'Заслонка' ? const [Text('Закр.'), Text('Откр.')] : const [Text('Выкл.'), Text('Вкл.')]),
      ],
    );
  }
}

class SwitchWidget extends StatelessWidget {
  const SwitchWidget(this.isWho, {super.key});
  final int isWho;
  @override
  Widget build(BuildContext context) {
    const listName = ['Вытяжка','Дымоген', 'Пароген', 'Заслонка', 'ТЕН'];
    return Row(children: [
      Text('${listName[isWho]}: '),
      const SizedBox(width: 16),
      BlocBuilder<CubitTwo, StateTwo>(
        builder: (context, state) => Switch(
              value: isWho == 0 ? state.extractor : isWho == 1 ? state.smoke : isWho == 2 ? state.water : isWho == 3 ? state.flap : state.tens,
              onChanged: (value) => context.read<CubitTwo>().toggleButton(isWho, value),
              activeTrackColor: Colors.amberAccent,
              activeColor: Colors.amber,
            ))
    ],);
  }
}

class ButtonListWidget extends StatelessWidget {
  const ButtonListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CubitFree, StateFree>(
      builder: (context, state) => ToggleButtons(
          direction: Axis.horizontal,
          onPressed: (index) => context.read<CubitFree>().nextBtn(index),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          borderColor: Colors.white,
          selectedBorderColor: Colors.amber,
          selectedColor: mainFon,
          fillColor: Colors.amber,
          color: Colors.white,
          constraints: const BoxConstraints(minHeight: 50.0,minWidth: 152.0),
          isSelected: state.btnList,
          children: const [
            Text('Отепление'),
            Text('Сушка'),
            Text('Варка'),
            Text('Копчение'),
            Text('Жарка'),
            Text('Универсальный')
          ]),
    );
  }
}

class TextControlWidget extends StatelessWidget {
  TextControlWidget(this.isWho, {super.key});
  final bool isWho;
  final TextEditingController _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CubitTwo, StateTwo>(builder: (context, state) => TextFormField(
      controller: _textEditingController,
      style: const TextStyle(color: Colors.white),
      keyboardType: isWho ? TextInputType.name : TextInputType.number,
      onChanged: (value) => isWho ? context.read<CubitTwo>().addName(value) : context.read<CubitTwo>().addTime(value),
      decoration: InputDecoration(
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 13, horizontal: 24),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Colors.white)),
        labelText: isWho ? 'Название' : 'Время',
        labelStyle: const TextStyle(color: Color.fromRGBO(255, 255, 255, 0.8)),
      ),
      onTapOutside: (event) => {
        SystemChannels.textInput.invokeMethod('TextInput.hide'),
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky)
      }
    )
    );
  }
}

class TextControlWidgetT extends StatelessWidget {
  TextControlWidgetT(this.isWho, {super.key});
  final bool isWho;
  final TextEditingController _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CubitTwo, StateTwo>(builder: (context, state) => TextFormField(
      controller: _textEditingController,
      style: const TextStyle(color: Colors.white),
      keyboardType: isWho ? TextInputType.name : TextInputType.number,
      onChanged: (value) => isWho ? context.read<CubitTwo>().addName(value) : context.read<CubitTwo>().addTime(value),
      decoration: InputDecoration(
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 13, horizontal: 24),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Colors.white)),
        labelText: isWho ? 'Название' : 'Время',
        labelStyle: const TextStyle(color: Color.fromRGBO(255, 255, 255, 0.8)),
      ),
      onTapOutside: (event) => {
        SystemChannels.textInput.invokeMethod('TextInput.hide'),
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky)
      }
    )
    );
  }
}

class SliderWidget extends StatelessWidget {
  const SliderWidget(this.isWho, {super.key});
  final bool isWho;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        isWho ? const Text('t камеры:') : const Text('t продукта:'),
        const SizedBox(width: 20),
        SizedBox(
          width: 800,
          child: BlocBuilder<CubitTwo, StateTwo>(builder: (context, state) => SliderTheme(
                          data: SliderThemeData(
                            trackHeight: 16 * 0.5,
                            thumbShape: SliderThemeRectangle(0.5),
                            showValueIndicator: ShowValueIndicator.always,
                            valueIndicatorColor: const Color.fromARGB(0, 254, 201, 43),
                          ),
                          child: Slider(
                            label: isWho ? state.tbox.round().toString() : state.tprod.round().toString(),
                              activeColor: Colors.amber,
                              inactiveColor: Colors.white24,
                              min: 0.0,
                              max: 100.0,
                              value: isWho ? state.tbox : state.tprod,
                              onChanged: (value) {
                                if (isWho) {context.read<CubitTwo>().addTbox(value.roundToDouble());}
                                else {context.read<CubitTwo>().addTprod(value.roundToDouble());}
                              },
                            ),
                        ),),
        ),
      ],
    );
  }
}

class SliderThemeRectangle extends SliderComponentShape {
  final double scale;
  SliderThemeRectangle(this.scale);
  @override Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return const Size(0,0);
  }
  @override void paint(PaintingContext context, Offset center, {required Animation<double> activationAnimation, required Animation<double> enableAnimation, required bool isDiscrete, required TextPainter labelPainter, required RenderBox parentBox, required SliderThemeData sliderTheme, required TextDirection textDirection, required double value, required double textScaleFactor, required Size sizeWithOverflow}) {
    final canvas = context.canvas;
    final paint = Paint()
      ..strokeWidth = 10
      ..color = Colors.white
      ..style = PaintingStyle.fill;
      RRect rRect = RRect.fromRectAndRadius(Rect.fromCenter(center: center, width: 24 * scale, height: 64 * scale), Radius.circular(8 * scale));
    canvas.drawRRect(rRect, paint);
  }
  
}