import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit_creater.dart';
import 'page_navigator.dart';
import 'page_new_step.dart';
import 'state_creater.dart';
import 'constant.dart';
import 'cubit_text_input.dart';
import 'cubit_choise.dart';
import 'page_cooking.dart';
import 'stage.dart';
import 'widgets.dart';


class PageCreater extends StatelessWidget {
  const PageCreater(this.recipe, this.isCreate, {super.key});
  final Recipe recipe;
  final bool isCreate;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(isCreate ? 'Создать рецепт' : 'Коррекция рецепта\n${recipe.name}', textAlign: TextAlign.center),
        centerTitle: true,
        backgroundColor: mainFon,
        actions: [
          Visibility(visible: !isCreate, child: const ButtonSettingsWidget()),
          Visibility(visible: !isCreate, child: ButtonStartWidget(recipe: recipe)),
        ],
      ),
      backgroundColor: mainFon,
      body: BlocBuilder<CubitCreater, StateCreater>(
        builder: (context, state) => ReorderableListWidget(recipe, state.isSettings, isCreate),
      ),
    );
  }
}

class ButtonStartWidget extends StatelessWidget {
  const ButtonStartWidget({super.key, required this.recipe});

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: (){
      context.read<CubitCreater>().start(recipe);
      Navigator.push(context,MaterialPageRoute(builder: (context) => PageCooking(recipe)));
      }, 
      icon: const Icon(Icons.not_started_outlined, color: Colors.amber, size: 40));
  }
}

class ButtonSettingsWidget extends StatelessWidget {
  const ButtonSettingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CubitCreater, StateCreater>(builder: (context, state) => IconButton(onPressed: (){context.read<CubitCreater>().toggleBtn();}, icon: Icon(Icons.settings, color: state.isSettings ? Colors.amber : Colors.white, size: 40,)));
  }
}


class ReorderableListWidget extends StatelessWidget {
  const ReorderableListWidget(this.recipe, this.isReorder, this.isCreate, {super.key});
  final Recipe recipe;
  final bool isReorder;
  final bool isCreate;
  @override
  Widget build(BuildContext context) {
    List<Stage> stage = recipe.stages;
    bool isVisible = isReorder || isCreate;
    return Column(
      children: [
        SizedBox(
          height: h(context, isCreate ? 662 : 800),
          child: ReorderableListView.builder(
            header: Visibility(visible: stage.isNotEmpty, child: const HeaderTitleWidget()),
            buildDefaultDragHandles: false,
            padding: EdgeInsets.symmetric(horizontal: w(context, isVisible ? 130 : 100)),
            itemCount: stage.length,
            itemBuilder: (context, index) => ListTile(
              horizontalTitleGap: 8,
              key: ValueKey(stage[index]),
              leading: Visibility(visible: isVisible, child: ReorderableIconWidget(index)),
              title: ContentItemWidget(index, stage: stage),
              trailing: Visibility(visible: isVisible, child: DeleteIconWidget(index, stage: stage)),
            ),
            onReorder: (oldIndex, newIndex) => context.read<CubitCreater>().fromTo(stage, oldIndex, newIndex),
            footer: Visibility(visible: isVisible, child: ButtonNewItemWidget(stage: stage)),
          ),
        ),

        Visibility(
          visible: isCreate,
          child:  Column(
            children: [
               const Divider(),
               const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BtnCookWidget(recipe),
                  const SizedBox(width: 50),
                  BtnSaveWidget(stage)
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}

class ContentItemWidget extends StatelessWidget {
  const ContentItemWidget(this.index, {super.key,required this.stage});

  final List<Stage> stage;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}

class ButtonNewItemWidget extends StatelessWidget {
  const ButtonNewItemWidget({super.key, required this.stage});

  final List<Stage> stage;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => PageNewStep(stage))),
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
          child: const Text('Новое действие',style: t20w400w,
          )),
    );
  }
}

class DeleteIconWidget extends StatelessWidget {
  const DeleteIconWidget(this.index, {super.key,required this.stage});

  final List<Stage> stage;
  final int index;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () => context.read<CubitCreater>().delet(stage, index),
        icon: const Icon(Icons.delete_outline, size: 22, color: white06));
  }
}

class ReorderableIconWidget extends StatelessWidget {
  const ReorderableIconWidget(this.index, {super.key});
  final int index;

  @override
  Widget build(BuildContext context) {
    return ReorderableDragStartListener(
      index: index,
      child: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.apps, size: 22, color: white06)),
    );
  }
}

class HeaderTitleWidget extends StatelessWidget {
  const HeaderTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 80, right: 80, bottom: 12),
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Spacer(flex: 2),
        Expanded(child: Text('t камеры', textAlign: TextAlign.center)),
        Expanded(child: Text('t продукта', textAlign: TextAlign.center)),
        Expanded(flex: 2, child: Text('время этапа', textAlign: TextAlign.center)),
        Spacer(flex: 2),              
      ],),
    );
  }
}

class BtnCookWidget extends StatelessWidget {
  const BtnCookWidget(this.recipe, {super.key});
  final Recipe recipe;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: w(context, 320),
      height: h(context, 128),
      child: InkWell(
          onTap: () => {if (recipe.stages.isNotEmpty) Navigator.push(context, MaterialPageRoute(builder: (context) => PageCooking(recipe)))},
          child: const ContanerRadius(Colors.white, 16 ,text: 'Готовить', textSize: 1)),
    );
  }
}

class BtnSaveWidget extends StatelessWidget {
  const BtnSaveWidget(this.stage, {super.key});
  final List<Stage> stage;
  @override
    Widget build(BuildContext context) {
    return SizedBox(
      width: w(context, 320),
      height: h(context, 128),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
          onPanDown: (_) => {
            FocusScope.of(context).requestFocus(FocusNode()),
            showDialog(context: context, builder: (context) => DialogWidget(stage)),
          },
          child: const ContanerRadius(Colors.amber, 16 ,text: 'Сохранить', textSize: 1)),
    );
  }
}

class DialogWidget extends StatelessWidget {
  const DialogWidget(this.stage, {super.key});
  final List<Stage> stage;
  @override
  Widget build(BuildContext context) {
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
              const Text('Сохранение рецепта', style: t32w500),
              const SizedBox(height: 20),
              TextControlWidget(),
              const SizedBox(height: 20),
              SizedBox(
                width: 186,
                height: 54,
                child: InkWell(
                  onTap: () {
                      context.read<CubitChoise>().addRecipe(stage);
                      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
                      // Navigator.popUntil(context, (route) =>  false);
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const PageNavigator()), (route) => false);
                      // Navigator.of(context).pop();
                      // Navigator.of(context).pop();
                  },
                  child: const ContanerRadius(Colors.amber, 8, text: 'Готово', textSize: 1),
                  ),
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
    return BlocBuilder<CubitTextInput, String>(builder: (context, state) => TextFormField(
      controller: _textEditingController,
      style: const TextStyle(color: mainFon),
      keyboardType: TextInputType.name,
      onChanged: (value) =>context.read<CubitTextInput>().addName(value),
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