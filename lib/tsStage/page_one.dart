import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit_six.dart';
import 'constant.dart';
import 'cubit_one.dart';
import 'page_seven.dart';
import 'page_two.dart';
import 'stage.dart';
import 'state_one.dart';
import 'widgets.dart';

class PageOne extends StatelessWidget {
  const PageOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Создать рецепт'),
          centerTitle: true,
          backgroundColor: mainFon,
        ),
        backgroundColor: mainFon,
        body: BlocBuilder<CubitOne, StateOne>(
          builder: (context, state) {
            return ReorderableListWidget(state.stage);
          },
        ));
  }
}

class ReorderableListWidget extends StatelessWidget {
  const ReorderableListWidget(this.stage, {super.key});
  final List<Stage> stage;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
            height: h(context, 662),
            child: ReorderableListView.builder(
              header: stage.isNotEmpty ? const Padding(
                padding: EdgeInsets.symmetric(horizontal: 80),
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Expanded(flex: 2,child: Text('')),
                  Expanded(child: Text('t камеры', textAlign: TextAlign.center)),
                  Expanded(child: Text('t продукта', textAlign: TextAlign.center)),
                  Expanded(flex: 2, child: Text('время этапа', textAlign: TextAlign.center)),
                  Expanded(flex: 2, child: Text('')),              
                ],),
              ) : Container(),
            buildDefaultDragHandles: false,
            padding: EdgeInsets.symmetric(horizontal: w(context, 135)),
            itemCount: stage.length,
            itemBuilder: (context, index) => ListTile(
              horizontalTitleGap: 8,
              key: ValueKey(stage[index]),
              leading: ReorderableDragStartListener(
                index: index,
                child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.apps, size: 22, color: Color.fromRGBO(255, 255, 255, 0.6))),
              )
              ,
              title: Container(
                padding: EdgeInsets.symmetric(horizontal: w(context, 40), vertical: h(context, 25)),
                decoration: const BoxDecoration(color: Colors.white,borderRadius: BorderRadius.all(Radius.circular(8))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(flex: 2, child: Text(stage[index].name, style: t24w500)),
                    Expanded(child: Text('${stage[index].tempB.round()}$indicate',style: t24w500, textAlign: TextAlign.center)),
                    Expanded(child: Text('${stage[index].tempP.round()}$indicate',style: t24w500, textAlign: TextAlign.center)),
                    Expanded(flex: 2, child: TimeWidget(listStage: stage, index: index)),
                    Expanded(flex: 2, child: IndicateWidget(listStage: stage, index: index, color: Colors.black, size: 30))
                  ],
                ),
              ),
              trailing: IconButton(
                  onPressed: () => {context.read<CubitOne>().delet(index)},
                  icon: const Icon(Icons.delete_outline, size: 22, color: Color.fromRGBO(255, 255, 255, 0.6))),
            ),
            onReorder: (oldIndex, newIndex) => {context.read<CubitOne>().fromTo(oldIndex, newIndex)},
            footer: InkWell(
              onTap: () => {Navigator.push(context, MaterialPageRoute(builder: (context) => const PageTwo()))},
              child: Container(
                  margin: EdgeInsets.only(
                      left: 70,
                      right: 500,
                      top: h(context, 20),
                      bottom: h(context, 20)),
                  padding: EdgeInsets.symmetric(horizontal: w(context, 24), vertical: h(context, 13)),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 2),
                      borderRadius: const BorderRadius.all(Radius.circular(8))),
                  child: const Text('Новое действие',style: TextStyle(fontSize: 20, color: Colors.white),
                  )),
            ),
          ),
        ),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BtnCookWidget(stage),
            const SizedBox(width: 50),
            const BtnSaveWidget()
            ],
          )
          ],
    );
  }
}


class BtnCookWidget extends StatelessWidget {
  const BtnCookWidget(this.stageList, {super.key});
  final List<Stage> stageList;
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => {if (stageList.isNotEmpty) Navigator.push(context, MaterialPageRoute(builder: (context) => PageSeven(Recipe('Новый', '', '', stageList))))},
        child: const ContanerRadius(Colors.white, 'Готовить', 1));
  }
}

class BtnSaveWidget extends StatelessWidget {
  const BtnSaveWidget({super.key});
  @override
    Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
        onPanDown: (_) => {
          FocusScope.of(context).requestFocus(FocusNode()),
          showDialog(context: context, builder: (context) => const DialogWidget()),
        },
        child: const ContanerRadius(Colors.amber, 'Сохранить', 1));
  }
}

class DialogWidget extends StatelessWidget {
  const DialogWidget({super.key});
  @override
  Widget build(BuildContext context) {
    const style1 = TextStyle(color: mainFon, fontSize: 36);
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      backgroundColor: Colors.white,
      child: Container(
        padding: const EdgeInsets.all(30),
        width: 610,
        height: 270,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text('Сохранение рецепта', style: style1),
              const SizedBox(height: 20),
              TextControlWidget(),
              const SizedBox(height: 20),
              InkWell(
                onTap: () {
                    SystemChannels.textInput.invokeMethod('TextInput.hide');
                    context.read<CubitSix>().addRecipe();
                    context.read<CubitOne>().clearStages();
                    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                },
                child: const ContanerRadius(Colors.amber, 'Готово', 1),
                )
            ],
          ),
        ),
      ),
    );
  }
}

class TextControlWidget extends StatelessWidget {
  TextControlWidget({super.key});
  final TextEditingController _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CubitOne, StateOne>(builder: (context, state) => TextFormField(
      controller: _textEditingController,
      style: const TextStyle(color: mainFon),
      keyboardType: TextInputType.name,
      onChanged: (value) =>context.read<CubitOne>().addName(value),
      decoration: InputDecoration(
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 13, horizontal: 24),
        enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: mainFon), borderRadius: BorderRadius.circular(8)),
        border: OutlineInputBorder(borderSide: const BorderSide(color: mainFon), borderRadius: BorderRadius.circular(8)),
        labelText: 'Название',
        labelStyle: const TextStyle(color: mainFon),
      ),
    )
    );
  }
}