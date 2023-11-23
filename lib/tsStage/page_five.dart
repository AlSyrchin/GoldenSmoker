import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit_five.dart';
import 'state_five.dart';
import 'constant.dart';
import 'widgets.dart';

class PageFive extends StatelessWidget {
  const PageFive({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Прямое управление'),
        centerTitle: true,
        backgroundColor: mainFon,
      ),
      backgroundColor: mainFon,
      body: Container(
        padding: const EdgeInsets.all(20),
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
             Row(
              mainAxisAlignment: MainAxisAlignment.center,
               children: [
                const StackContaner(name: 'Температура', content: SizedBox(width: 400, height: 120, child: SliderWidget()),),
                const SizedBox(width: 20),
                StackContaner(name: 'T камеры', content: SizedBox(width: 150, height: 120, child: Center(
                  child: BlocBuilder<CubitFive, StateFive>(builder: (context, state) => TextAndArrowWidget(state.tbox, state.tboxUp)),
                )),),
                const SizedBox(width: 20),
                StackContaner(name: 'T продукта', content: SizedBox(width: 150, height: 120, child: Center(
                  child: BlocBuilder<CubitFive, StateFive>(builder: (context, state) => TextAndArrowWidget(state.tprod, state.tprodUp)),
                )),),
             ],
             ),
             Container(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              height: 250,
              width: double.maxFinite,
               child: GridView.custom(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 2.5, mainAxisSpacing: 20, crossAxisSpacing: 20), 
                childrenDelegate: SliverChildBuilderDelegate((context, index) => ButtonValue(index), childCount: 5),
                ),
             )
          ],
        ),
      ),     
    );
  }
}

class TextAndArrowWidget extends StatelessWidget {
  const TextAndArrowWidget(this.temperature, this.isUp, {super.key});
  final double temperature;
  final bool isUp;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('$temperature$indicate', style: t46w700),
        Transform.rotate(angle: (isUp ? -90 : 90) * pi /180, child: Icon(Icons.arrow_right_alt_outlined, size: 27, color: isUp ? Colors.green : Colors.red)),
      ],
    );
  }
}

class ButtonValue extends StatelessWidget {
  const ButtonValue(this.isWho, {super.key});
  final int isWho;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        isWho == 0 ? const Text('Вытяжка',): isWho == 1 ? const Text('Дымоген') : isWho == 2 ? const Text('Пароген') : isWho == 3 ? const Text('Заслонка') : const Text('Тен'),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isWho == 0 ? Icon(Icons.leak_add, size: 50, color: white02) : isWho == 1 ? Icon(Icons.smoking_rooms_rounded, size: 50, color: white02) : isWho == 2 ? Icon(Icons.opacity, size: 50, color: white02) : isWho == 3 ? Icon(Icons.extension, size: 50, color: white02) : Icon(Icons.texture_rounded, size: 50, color: white02),
        const SizedBox(width: 20),
            BlocBuilder<CubitFive, StateFive>(builder: (context, state) => ToggleButtons(
                        direction: Axis.horizontal,
                        onPressed: (int index) => context.read<CubitFive>().nextBtn(index, isWho),
                        borderRadius: const BorderRadius.all(Radius.circular(8)),
                        borderColor: Colors.white,
                        selectedBorderColor: Colors.white,
                        selectedColor: mainFon,
                        fillColor: Colors.white,
                        color: Colors.white,
                        constraints: const BoxConstraints(
                          minHeight: 50.0,
                          minWidth: 85.0,
                        ),
                        isSelected: isWho == 0 ? state.btnExtractor : isWho == 1 ? state.btnSmoke : isWho == 2 ? state.btnWater : isWho == 3 ? state.btnFlap : state.btnTens,
                        children: isWho == 3 ? const [Text('Закр.'), Text('Откр.')] : const [Text('Выкл.'), Text('Вкл.')]
                        ),
                        ),
          ],
        ),
      ],
    );
  }
}

class SliderWidget extends StatelessWidget {
  const SliderWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CubitFive, StateFive>(builder: (context, state) => SliderTheme(
                    data: SliderThemeData(
                      trackHeight: 16 * 0.5,
                      thumbShape: SliderThemeRectangle(0.5),
                      showValueIndicator: ShowValueIndicator.always,
                      valueIndicatorColor: const Color.fromARGB(0, 254, 201, 43),
                    ),
                    child: Slider(
                      label: state.temperature.round().toString(),
                        activeColor: Colors.amber,
                        inactiveColor: Colors.white24,
                        min: 0.0,
                        max: 200.0,
                        value: state.temperature,
                        onChanged: (value) => context.read<CubitFive>().addT(value.roundToDouble()),
                        onChangeEnd: (value) => context.read<CubitFive>().upD(),
                      ),
                  ),
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