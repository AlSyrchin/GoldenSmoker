import 'dart:io';
// import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;


class Simple extends ChangeNotifier {
void readFile() async {
  final directiry = await pathProvider.getApplicationDocumentsDirectory();
  final filePath = directiry.path + '/file.txt';
  final file = File(filePath);
  final isExist = await file.exists();


List<String> listTst = ['1','2','3','4','5'];

  if (!isExist) {await file.create();} 

  for (var element in listTst) {
    await file.writeAsString('$element ', mode: FileMode.writeOnlyAppend);
  }
  final result = await file.readAsString();
  print('Result: $result');
}
}

class SimpleNotif extends InheritedNotifier<Simple> {
  final Simple model;
  SimpleNotif({super.key, required this.model, required Widget child}) : super(notifier:model, child: child);

  static SimpleNotif? watch(BuildContext context){
    return context.dependOnInheritedWidgetOfExactType<SimpleNotif>();
  }

  static SimpleNotif? read(BuildContext context){
    final widget = context.getElementForInheritedWidgetOfExactType<SimpleNotif>()?.widget;
    return widget is SimpleNotif ? widget : null;
  }

}



//void foo() async {  const filepath = "path to your file";  var file = File(filepath);  
//try {    StreamListint stream = file.openRead();    
//var lines = stream.transform(utf8.decoder).transform(LineSplitter());    
//await for (var line in lines) {      print(line);    }  } catch (e) {    print(e);  }}

