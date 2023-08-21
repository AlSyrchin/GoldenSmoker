import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(new ExampleApplication());

class ExampleApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(child: WidgetProvider()),
      ),
    );
  }
}




class Model extends ChangeNotifier{
  var one = 0;
  var two = 0;
  var res = 0;

  void inc1(){
    one++;
    notifyListeners();
  }
  void inc2(){
    two++;
    notifyListeners();
  }
  void inc3(){
    res = one + two;
    notifyListeners();
  }
}

class ForExamle extends ChangeNotifier{
  var one = 0;

  void inc1(){
    one++;
    notifyListeners();
  }
}

class Wrapper{
  final Model model;
  final ForExamle forExamle;

  Wrapper(this.model, this.forExamle);
}

class WidgetProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => Model()),
          ChangeNotifierProvider(create: (_) => ForExamle()),
          //Прокси для объединения нескольких провайдерах
          ProxyProvider2(update: (
            BuildContext context, Model model, ForExamle forExample,prev){
            return Wrapper(model, forExample);
            })
        ],
        child: const _View(),
      );
}  


class _View extends StatelessWidget {
  const _View({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.read<Model>();
 
    return Scaffold(
      body: SafeArea(child: Column(children: [
        ElevatedButton(onPressed: state.inc1, child: Text('one'),),
        ElevatedButton(onPressed: state.inc2, child: Text('two'),),
        ElevatedButton(onPressed: state.inc3, child: Text('res'),),
        _OneTxt(),
        _TwoTxt(),
        _ThreeTxt(),

        // Consumer(builder: (context, model, _){
        //   return Text('${model}');
        //   }),
        // Consumer2(builder: (context, model, forExamle, _){
        //   return Text('${model}');
        //   }),

//Есть выборка и запоминание предыдущего значения. 
        // Selector<Model, int>(
        //   builder: (context, value, _){
        //     return Text('${value}');
        //   },
        //   selector: (_, model) => model.one,
        //   shouldRebuild: (prev, current) => current - prev > 1,
        // ),

      ],),),
    );
  }
}

class _OneTxt extends StatelessWidget {
  const _OneTxt({super.key});

  @override
  Widget build(BuildContext context) {
    final value = context.select((Model value) => value.one,);
    return Text('$value');
  }
}

class _TwoTxt extends StatelessWidget {
  const _TwoTxt({super.key});

  @override
  Widget build(BuildContext context) {
    final value = context.select((Model value) => value.two,);
    return Text('$value');
  }
}

class _ThreeTxt extends StatelessWidget {
 const _ThreeTxt({super.key});

  @override
  Widget build(BuildContext context) {
    final value = context.select((Model value) => value.res,);
    return Text('$value');
  }
}







/////////////////////////////////////////////////////////////////////////////////////////////


// class Model extends ChangeNotifier{
//   var one = 0;
//   var two = 0;
//   var res = 0;

//   void inc1(){
//     one++;
//     notifyListeners();
//   }
//   void inc2(){
//     two++;
//     notifyListeners();
//   }
//   void inc3(){
//     res = one + two;
//     notifyListeners();
//   }
// }


// class WidgetProvider extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) => ChangeNotifierProvider(
//         create: (context) => Model(), //Замыкание. Функция которая вернёт значение.
//         child: const _View(),
//       );
// }  


// class _View extends StatelessWidget {
//   const _View({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final model = context.read<Model>();
 
//     return Scaffold(
//       body: SafeArea(child: Column(children: [
//         ElevatedButton(onPressed: model.inc1, child: Text('one'),),
//         ElevatedButton(onPressed: model.inc2, child: Text('two'),),
//         ElevatedButton(onPressed: model.inc3, child: Text('res'),),
//         _OneTxt(),
//         _TwoTxt(),
//         _ThreeTxt(),
//       ],),),
//     );
//   }
// }

// class _OneTxt extends StatelessWidget {
//   const _OneTxt({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final value = context.select((Model value) => value.one,);
//     return Text('$value');
//   }
// }

// class _TwoTxt extends StatelessWidget {
//   const _TwoTxt({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final value = context.select((Model value) => value.two,);
//     return Text('$value');
//   }
// }

// class _ThreeTxt extends StatelessWidget {
//  const _ThreeTxt({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final value = context.select((Model value) => value.res,);
//     return Text('$value');
//   }
// }