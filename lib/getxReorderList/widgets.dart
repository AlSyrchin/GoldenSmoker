import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'constant.dart';
import 'state_menager.dart';

class StackContaner extends StatelessWidget {
  const StackContaner(this.header, this.body, {super.key});
  final Widget header;
  final Widget body;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 20, bottom: 5),
          padding: const EdgeInsets.only(left: 20, right: 20, top: 25, bottom: 20),
          decoration: BoxDecoration(border: Border.all(color: Colors.white, width: 2), borderRadius: BorderRadius.circular(8)),
          child: body,
        ),
        Positioned(
          height: 40,
          child: Container(padding: const EdgeInsets.symmetric(horizontal: 2), alignment: Alignment.center ,color: mainFon ,child: header),
          )
      ],);
  }
}

class TextInput extends StatelessWidget {
  const TextInput(this.name, this.type, {super.key});
  final String name;
  final TextInputType type;

  @override
  Widget build(BuildContext context) {
    return ObxValue((control) => TextFormField(
      controller: control.value,
      style: const TextStyle(color: Colors.white),
      keyboardType: type,
      decoration: InputDecoration(
        errorText: null,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 13, horizontal: 24),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Colors.white)),
        labelText: name,
        labelStyle: const TextStyle(color: Color.fromRGBO(255, 255, 255, 0.4)),
      ),
    ), TextEditingController().obs);
  }
}

class ButtonRule extends StatelessWidget {
  const ButtonRule({super.key});
  @override
  Widget build(BuildContext context) {
    return ObxValue(
            (trigger) => ToggleButtons(
                direction: Axis.horizontal,
                onPressed: (int index) {
                  for (int i = 0; i < trigger.length; i++) {trigger[i] = i == index;}
                },
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
                isSelected: trigger,
                children: const [Icon(Icons.close), Icon(Icons.pause), Icon(Icons.play_arrow)]
                ), [true, false, false].obs
          );
  }
}

class ItemEdit extends StatelessWidget {
  const ItemEdit(this.name, this.widget, {super.key});
  final String name;
  final Widget widget;
  @override
  Widget build(BuildContext context) {
    return ObxValue(
                (isV) => Column(
                  children: [
                    CheckboxListTile(
                        checkColor: mainFon,
                        activeColor: Colors.amber,
                        value: isV.value,
                        onChanged: (value) => isV.toggle(),
                        title: Text(name),
                        controlAffinity: ListTileControlAffinity.leading),
                        const SizedBox(height: 5),
                        Container(
                          margin: const EdgeInsets.only(left: 55),
                          width: double.maxFinite, 
                          child: widget)
                  ],
                ),
                true.obs);
  }
}

class SliderCast extends StatelessWidget {
  const SliderCast({super.key});

  @override
  Widget build(BuildContext context) {
    return ObxValue(
                  (v) => SliderTheme(
                    data: SliderThemeData(
                      trackHeight: 16 * 0.5,
                      thumbShape: SliderThemeRectangle(0.5),
                      showValueIndicator: ShowValueIndicator.always,
                      valueIndicatorColor: const Color.fromARGB(0, 254, 201, 43),
                    ),
                    child: Slider(
                      label: v.value.round().toString(),
                        activeColor: Colors.amber,
                        inactiveColor: Colors.white24,
                        min: 0.0,
                        max: 100.0,
                        value: v.value,
                        onChanged: (value) {
                          v.value = value;
                        },
                      ),
                  ),
                  0.0.obs);
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

class ToggleBtn extends StatelessWidget {
  const ToggleBtn(this.name, {Key? key}) : super(key: key);
  final String name;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: 203,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name),
          const SizedBox(height: 10),
          ButtonValue(name)
        ],
      ),
    );
  }
}

class ButtonValue extends StatelessWidget {
  const ButtonValue(this.name, {super.key});
  final String name;
  @override
  Widget build(BuildContext context) {
    return ObxValue(
            (trigger) => ToggleButtons(
                direction: Axis.horizontal,
                onPressed: (int index) {
                  for (int i = 0; i < trigger.length; i++) {trigger[i] = i == index;}
                },
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
                isSelected: trigger,
                children: name == 'Заслонка' ? const [Text('Откр.'), Text('Закр.')] : const [Text('Вкл.'), Text('Выкл.')]
                ), [false, true].obs
          );
  }
}


class ContanerRadius extends StatelessWidget {
  const ContanerRadius(this.color,this.text, {super.key});
  final Color color;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: w(320),
      height: h(128),
      decoration: BoxDecoration(color: color, borderRadius: const BorderRadius.all(Radius.circular(16))),
      child: Center(child: Text(text, style: TextStyle(color: mainFon, fontSize: h(48)),)),
    );
  }
}