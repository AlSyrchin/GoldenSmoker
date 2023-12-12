import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'state_new_step.dart';
import 'constant.dart';
import 'cubit_creater.dart';
import 'cubit_line_btn.dart';
import 'cubit_new_step.dart';
import 'stage.dart';
import 'state_line_btn.dart';
import 'widgets.dart';

class PageNewStep extends StatelessWidget {
  const PageNewStep(this.stage, {super.key});
  final List<Stage> stage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Создать этап'),
        backgroundColor: mainFon,
      ),
      backgroundColor: mainFon,
      body:  BlocProvider(
        create: (context) => CubitNewStep(),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: BlocProvider(create: (context) => CubitLineBTN(),
            child: BlocBuilder<CubitLineBTN,StateLineBTN>(builder: (context, state) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const ButtonListWidget(),
                const SizedBox(height: 32),
                Visibility(visible: state.btnList[1], child: const ToggleButtonsWidget('Заслонка')),
                Visibility(visible: state.btnList[2], child: const ToggleButtonsWidget('Пароген')),
                Visibility(visible: state.btnList[3], child: const ToggleButtonsWidget('Компрессор')),
                Visibility(visible: state.btnList[5], child: TextControlWidget(true)),
                const SizedBox(height: 16),
                Visibility(visible: !(state.btnList[0] || state.btnList[4]), child: TextControlWidget(false)),
                const SizedBox(height: 16),
                const SliderWidget(true), 
                const SizedBox(height: 16),
                const SliderWidget(false), 
                const SizedBox(height: 16),
                Visibility(
                      visible: state.btnList[5],
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: Iterable.generate(5, (index) => SwitchWidget(index)).toList(),
                            ),
                    ),
                const Divider(),
                const SizedBox(height: 12),
                ButtonAddStage(state.btnList, stage: stage),
              ],
            ),),),
          ),
        ),
      ),
    );
  }
}

class ButtonAddStage extends StatelessWidget {
  const ButtonAddStage(this.list, {super.key, required this.stage});

  final List<Stage> stage;
  final List<bool> list;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: w(context, 320),
      height: h(context, 128),
      child: InkWell(
        onTap: (){
          context.read<CubitNewStep>().addItem(stage, list);
          context.read<CubitNewStep>().restart();
          context.read<CubitCreater>().restart();
          Navigator.pop(context);
        },
        child: const ContanerRadius(Colors.amber, 16, text: 'Добавить')),
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
      BlocBuilder<CubitNewStep, StateNewStep>(
        builder: (context, state) => Switch(
              value: isWho == 0 ? state.extractor : isWho == 1 ? state.smoke : isWho == 2 ? state.water : isWho == 3 ? state.flap : state.tens,
              onChanged: (value) => context.read<CubitNewStep>().toggleButton(isWho, value),
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
    return BlocBuilder<CubitLineBTN, StateLineBTN>(
      builder: (context, state) => ToggleButtons(
          direction: Axis.horizontal,
          onPressed: (index) => context.read<CubitLineBTN>().nextBtn(index),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          borderColor: Colors.white,
          selectedBorderColor: Colors.amber,
          selectedColor: mainFon,
          fillColor: Colors.amber,
          color: Colors.white,
          constraints: const BoxConstraints(minHeight: 50.0,minWidth: 152.0),
          isSelected: state.btnList,
          children: etapName.map((e) => Text(e)).toList()),
    );
  }
}

class TextControlWidget extends StatelessWidget {
  TextControlWidget(this.isWho, {super.key});
  final bool isWho;
  final TextEditingController _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CubitNewStep, StateNewStep>(builder: (context, state) => TextFormField(
      controller: _textEditingController,
      style: const TextStyle(color: Colors.white),
      keyboardType: isWho ? TextInputType.name : TextInputType.number,
      onChanged: (value) => isWho ? context.read<CubitNewStep>().addName(value) : context.read<CubitNewStep>().addTime(value),
      decoration: InputDecoration(
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 13, horizontal: 24),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Colors.white)),
        labelText: isWho ? 'Название' : 'Время',
        labelStyle: const TextStyle(color: Color.fromRGBO(255, 255, 255, 0.8)),
      ),
      onTapOutside: (event) => {
        // SystemChannels.textInput.invokeMethod('TextInput.hide'),
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
        Text(isWho ? 't камеры:' : 't продукта:'),
        const SizedBox(width: 20),
        SizedBox(
          width: 800,
          child: BlocBuilder<CubitNewStep, StateNewStep>(builder: (context, state) => SliderTheme(
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
                                if (isWho) {context.read<CubitNewStep>().addTbox(value.roundToDouble());}
                                else {context.read<CubitNewStep>().addTprod(value.roundToDouble());}
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