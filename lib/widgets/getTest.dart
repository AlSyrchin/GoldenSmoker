import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() => runApp(new App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: HomePage(),
      getPages: [
        GetPage(name: "/", page: ()=>HomePage()),
        GetPage(name: "/two", page: ()=>PageTwo()),
      ],
    );
  }
}
 
class HomePage extends StatelessWidget {
  // const HomePage({super.key});
  // Control controller = Get.put(Control());
  @override
  Widget build(BuildContext context) {
    ValueController valueController = Get.put(ValueController());
    return Scaffold(
      appBar: AppBar(title: Text('Snack')),
      body: SafeArea(
          child: Container(
        // height: 100,
        color: Colors.indigo,
        padding: EdgeInsets.all(20),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [

          MaterialButton(
            child: Text('Snack'),
            onPressed: (){
            Get.snackbar('Snack', 'Message', snackPosition: SnackPosition.BOTTOM);
          }, color: Colors.amber,),

          MaterialButton(
            child: Text('Dialog'),
            onPressed: (){
            Get.defaultDialog(title: 'Dialog', content: Text('Content '));
          }, color: Colors.green,),

          MaterialButton(
            child: Text('Sheet'),
            onPressed: (){
            Get.bottomSheet(
              Container(
                height: 100,
                color: Colors.red,
                child: Text('Text'),
              )
            );
          }, color: Colors.red,),


          MaterialButton(
            child: Text('Page 2'),
            onPressed: (){
            // Get.to(PageTwo());
            Get.toNamed('two',arguments: ['The','two', 'page']);
          }, color: Colors.blue,),

          GetBuilder<Control>(
            init: Control(),
            builder: (control){
              return Text('Count is ${control.count}');}
            ),

          MaterialButton(
            child: Text('+1'),
            onPressed: (){
              // controller.increment();
              Get.find<Control>().increment();
          }, color: Colors.purple,),


          // GetX<ValueController>(
          //   init: ValueController(),
          //   builder: (controller) {
          //     return Text('Value 1 = ${controller.valueModel.value.val1}');
          //   },),

          // Obx(() => Text('Value 2 = ${Get.find<ValueController>().valueModel.value.val2}')),
          Obx(() => Text(valueController.valueModel.value.val1)),

          MaterialButton(
            child: Text('+1'),
            onPressed: (){

              Get.find<ValueController>().updateTheValues('111', '222');
          }, color: Colors.orange,),
        ],
        ),
      )),
    );
  }
}
class Control extends GetxController{
  int count =  0;
  increment(){
    count++;
    update();
  }
}

class PageTwo extends StatelessWidget {
  const PageTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(
      child: MaterialButton(
            child: Text(Get.arguments.toString()),
            onPressed: (){
            // Get.offAll(HomePage());
            Get.offAllNamed('/');
          }, color: Colors.blue,),),);
  }
}

class ValueModel{
  String val1= '1';
  String val2 = '2';
}
class ValueController extends GetxController{
  final valueModel = ValueModel().obs;

  updateTheValues(String newV1, String newV2){
    valueModel.update((model) {
      model!.val1 = newV1;
      model.val2 = newV2;
    });
  }
}