import 'package:intl/intl.dart';
import '../constant.dart';

import '../etap.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';




class NewStep extends StatelessWidget {
  const NewStep( {super.key});
  @override
  Widget build(BuildContext context) {
      // final recCubit = context.read<HomePageCubit>();
     return Scaffold(
      appBar: AppBar(title: const Text('Создать'),),
      body: SafeArea(child: SingleChildScrollView(
          child: Column(
            children: [
            const FeildTxt('Name'),
            const FeildTxt('Temperature box'),
            const FeildTxt('Temperature prod'),
            const FeildTxt('Time'),
            const SwichWidg('Вытяжка', false),
            const SwichWidg('Заслонка', false),
            const SwichWidg('Дымоген', false),
            const SwichWidg('Пароген', false),
             ElevatedButton(
                  onPressed: () {
                    // recCubit.addEtap();
                    Navigator.pop(context);
                  },
                  child: const Text('Добавить'))
          ],),
        ),
      ),
    );
  }
}



class FeildTxt extends StatelessWidget {
  const FeildTxt(this.name, {super.key});
  final String name;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
          decoration: InputDecoration(
          errorText: null,
          isDense: true,
          contentPadding: const EdgeInsets.all(5),
          border: InputBorder.none,
          labelText: name,
        ),);
  }
}

class SwichWidg extends StatelessWidget {
  const SwichWidg(this.name, this.data, {super.key});
  final bool data;
  final String name;
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Text(name),
      SwitchP(data)
    ],);
  }
}

class SwitchP extends StatefulWidget {
  SwitchP(this.data ,{super.key});
  bool data;
  @override
  State<SwitchP> createState() => _SwitchPState();
}
class _SwitchPState extends State<SwitchP> {
  @override
  Widget build(BuildContext context) {
    return Switch(
              value: widget.data,
              onChanged: (value) {
                setState(() {
                  widget.data = value;
                });
              },
              activeTrackColor: Colors.amberAccent,
              activeColor: Colors.amber,
            );
  }
}