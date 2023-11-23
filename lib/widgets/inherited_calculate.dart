import 'package:flutter/material.dart';

void main() => runApp(const ExampleApplication());

class ExampleApplication extends StatelessWidget {
  const ExampleApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: SafeArea(child: WidFullNotif()),
      ),
    );
  }
}


/////////////////////////////////////////////////////////////////////////////////////////////


class WidFullNotif extends StatefulWidget {
  const WidFullNotif({super.key});

  @override
  State<WidFullNotif> createState() => _WidFullState();
}

class _WidFullState extends State<WidFullNotif> {
  final _model = SimpleCalcWidgetModelNotif();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: SimpleCalsWidNotif(
          model: _model,
          child: const Column(mainAxisSize: MainAxisSize.min, children: [
            WidgPrNotif1(),
            SizedBox(
              height: 10,
            ),
            WidgPrNotif2(),
            SizedBox(
              height: 10,
            ),
            WidgPrNotif3(),
            SizedBox(
              height: 10,
            ),
            WidgPrNotif4(),
          ]),
        ),
      ),
    );
  }
}

class WidgPrNotif1 extends StatelessWidget {
  const WidgPrNotif1({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(border: OutlineInputBorder()),
      onChanged: (value) => SimpleCalsWidNotif.of(context)?.firstNumber = value, //обновили модель и получили данные
    );
  }
}

class WidgPrNotif2 extends StatelessWidget {
  const WidgPrNotif2({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(border: OutlineInputBorder()),
      onChanged: (value) => SimpleCalsWidNotif.of(context)?.secondNumber = value, //обновили модель и получили данные
    );
  }
}

class WidgPrNotif3 extends StatelessWidget {
  const WidgPrNotif3({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => SimpleCalsWidNotif.of(context)?.summ(), 
      child: const Text('Summ'),
      );
  }
}

class WidgPrNotif4 extends StatelessWidget {
  const WidgPrNotif4({super.key});

  @override
  Widget build(BuildContext context) {
    final value = SimpleCalsWidNotif.of(context)?.summResult ?? '-1';
    return Text('Result: $value');
  }
}


class SimpleCalcWidgetModelNotif extends ChangeNotifier {
  int? _firstNumber;
  int? _secondNumber;
  int? summResult;

  set firstNumber(String value) => _firstNumber = int.tryParse(value);
  set secondNumber(String value) => _secondNumber = int.tryParse(value);

  void summ() {
    int? summResult;
    if (_firstNumber != null && _secondNumber != null) {
      summResult = _firstNumber! + _secondNumber!;
    } else {
      summResult = null;
    }

    if (this.summResult != summResult) {
      this.summResult = summResult;
      notifyListeners();
    }
  }
}

class SimpleCalsWidNotif extends InheritedNotifier<SimpleCalcWidgetModelNotif> {
  final SimpleCalcWidgetModelNotif model;
  const SimpleCalsWidNotif({super.key, required this.model, required Widget child}) : super(notifier:model, child: child);

  static SimpleCalcWidgetModelNotif? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<SimpleCalsWidNotif>()?.model;
  } 
}



/////////////////////////////////////////////////////////////////////////////////////////////



// class WidFull extends StatefulWidget {
//   const WidFull({super.key});

//   @override
//   State<WidFull> createState() => _WidFullState();
// }

// class _WidFullState extends State<WidFull> {
//   final _model = SimpleCalcWidgetModel();

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Padding(padding: const EdgeInsets.symmetric(horizontal: 30), child: SimpleCalsWid(model: _model, child: Column(mainAxisSize: MainAxisSize.min, children: [
//           const WidgPr0(),
//           const SizedBox(height: 10,),
//           const WidgPr1(),
//           const SizedBox(height: 10,),
//           const WidgPr2(),
//           const SizedBox(height: 10,),
//           const WidgPr3(),
//       ]),),),
//     );
//   }
// }

// class WidgPr0 extends StatelessWidget {
//   const WidgPr0({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       decoration: const InputDecoration(border: OutlineInputBorder()),
//       onChanged: (value) => SimpleCalsWid.of(context)?.model.firstNumber = value, //обновили модель и получили данные
//     );
//   }
// }

// class WidgPr1 extends StatelessWidget {
//   const WidgPr1({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       decoration: const InputDecoration(border: OutlineInputBorder()),
//       onChanged: (value) => SimpleCalsWid.of(context)?.model.secondNumber = value, //обновили модель и получили данные
//     );
//   }
// }

// class WidgPr2 extends StatelessWidget {
//   const WidgPr2({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: () => SimpleCalsWid.of(context)?.model.summ(), 
//       child: const Text('Summ'),
//       );
//   }
// }

// class WidgPr3 extends StatefulWidget {
//   const WidgPr3({super.key});

//   @override
//   State<WidgPr3> createState() => _WidgPr3State();
// }

// class _WidgPr3State extends State<WidgPr3> {
//   String _value = '-1';

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();

//     final model = SimpleCalsWid.of(context)?.model;
//     model?.addListener(() { _value = '${model.summResult}';
//     setState(() {});
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Text('Result: $_value');
//   }
// }

// class SimpleCalcWidgetModel extends ChangeNotifier {
//   int? _firstNumber;
//   int? _secondNumber;
//   int? summResult;

//   set firstNumber(String value) => _firstNumber = int.tryParse(value);
//   set secondNumber(String value) => _secondNumber = int.tryParse(value);

//   void summ() {
//     int? summResult;
//     if (_firstNumber != null && _secondNumber != null) {
//       summResult = _firstNumber! + _secondNumber!;
//     } else {
//       summResult = null;
//     }

//     if (this.summResult != summResult) {
//       this.summResult = summResult;
//       notifyListeners();
//     }
//   }
// }

// class SimpleCalsWid extends InheritedWidget {
//   final SimpleCalcWidgetModel model;
//   SimpleCalsWid({super.key, required this.model, required Widget child}) : super(child: child);

//   static SimpleCalsWid? of(BuildContext context) {
//     return context.dependOnInheritedWidgetOfExactType<SimpleCalsWid>();
//   }

//   @override
//   bool updateShouldNotify(SimpleCalsWid oldWidget) {
//     return model !=oldWidget.model;
//   }
// }




////////////////////////////////////////////////////////////////////////////////////




class FierWid extends StatefulWidget {
  const FierWid({super.key});

  @override
  State<FierWid> createState() => _FierWidState();
}

class _FierWidState extends State<FierWid> {
  var _valueOne = 0;
  var _valueTwo = 0;

  void _incrOne(){
    _valueOne+=1;
    setState(() {});
  }

  void _incrTwo(){
    _valueTwo+=1;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ElevatedButton(onPressed: _incrOne, child: const Text('Press1')),
      ElevatedButton(onPressed: _incrTwo, child: const Text('Press2')),
      Name(
        valueOne: _valueOne,
        valueTwo: _valueTwo, 
        child: const StWid(),
        ),
    ]);
  }
}

class StWid extends StatelessWidget {
  const StWid({super.key});

  @override
  Widget build(BuildContext context) {
    final value = context.dependOnInheritedWidgetOfExactType<Name>(aspect: 'one')?.valueOne ?? 0;
    return Column(children: [
      Text('$value'),
      const StWid2(),
    ]);
  }
}

class StWid2 extends StatelessWidget {
  const StWid2({super.key});

  @override
  Widget build(BuildContext context) {
     final value = context.dependOnInheritedWidgetOfExactType<Name>(aspect: 'two')?.valueTwo ?? 0;
    return Text('$value');
  }
}

class Name extends InheritedModel<String> {
  final int valueOne;
  final int valueTwo;

  const Name({super.key, required this.valueOne, required this.valueTwo, required this.child}) : super(child: child);

  final Widget child;

  @override
  bool updateShouldNotify(Name oldWidget) {
    return valueOne !=oldWidget.valueOne || valueTwo !=oldWidget.valueTwo;
  }
  
  @override
  bool updateShouldNotifyDependent(covariant Name oldWidget, Set<String> aspect) {
    final isValueOneUpdated = valueOne != oldWidget.valueOne && aspect.contains('one');
    final isValueTwoUpdated = valueTwo !=oldWidget.valueTwo && aspect.contains('one');
    return isValueOneUpdated || isValueTwoUpdated;
  }
}
