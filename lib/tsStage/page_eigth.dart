import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goldensmoker/tsStage/cubit_eigth.dart';
import 'package:goldensmoker/tsStage/page_two_copy.dart';
import 'package:goldensmoker/tsStage/state_eigth.dart';
import 'constant.dart';
import 'page_seven.dart';
import 'stage.dart';
import 'widgets.dart';


class PageEigth extends StatelessWidget {
  const PageEigth(this.recipe, {super.key});
  final Recipe recipe;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Коррекция рецепта\n${recipe.name}', textAlign: TextAlign.center),
        centerTitle: true,
        backgroundColor: mainFon,
        actions: [
          const ButtonSettingsWidget(),
          ButtonStartWidget(recipe: recipe),
        ],
      ),
      backgroundColor: mainFon,
      body: BlocBuilder<CubitEigth, StateEigth>(
        builder: (context, state) => ReorderableListWidget(recipe.stages, state.isSettings),
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
      context.read<CubitEigth>().start(recipe);
      Navigator.push(context,MaterialPageRoute(builder: (context) => PageSeven(recipe)));
      }, 
      icon: const Icon(Icons.not_started_outlined, color: Colors.amber, size: 40));
  }
}

class ButtonSettingsWidget extends StatelessWidget {
  const ButtonSettingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CubitEigth, StateEigth>(builder: (context, state) => IconButton(onPressed: (){context.read<CubitEigth>().toggleBtn();}, icon: Icon(Icons.settings, color: state.isSettings ? Colors.amber : Colors.white, size: 40,)));
  }
}


class ReorderableListWidget extends StatelessWidget {
  const ReorderableListWidget(this.stage, this.isReorder, {super.key});
  final List<Stage> stage;
  final bool isReorder;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
            height: h(context, 800),
            child: ReorderableListView.builder(
              header: stage.isNotEmpty ? const HeaderTitleWidget() : Container(),
            buildDefaultDragHandles: false,
            padding: EdgeInsets.symmetric(horizontal: w(context, isReorder ? 130 : 100)),
            itemCount: stage.length,
            itemBuilder: (context, index) => ListTile(
              horizontalTitleGap: 8,
              key: ValueKey(stage[index]),
              leading: isReorder 
              ? ReorderableDragStartListener(
                index: index,
                child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.apps, size: 22, color: Color.fromRGBO(255, 255, 255, 0.6))),
              )
              : Container(child: Text(''),),
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
              trailing: isReorder
              ? IconButton(
                  onPressed: () => {context.read<CubitEigth>().delet(stage, index)},
                  icon: const Icon(Icons.delete_outline, size: 22, color: Color.fromRGBO(255, 255, 255, 0.6)))
                  : Container(child: Text(''),),
            ),
            onReorder: (oldIndex, newIndex) => {context.read<CubitEigth>().fromTo(stage, oldIndex, newIndex)},
            footer: isReorder
            ? InkWell(
              onTap: () => {Navigator.push(context, MaterialPageRoute(builder: (context) => PageTwoCopy(stage)))},
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
            )
            : Container(child: Text(''),),
          ),
        ),
        // isReorder ? const Divider() : Container(),
        // isReorder ? const BtnSaveWidget() : Container(child: Text(''),)
      ],
    );
  }
}

class HeaderTitleWidget extends StatelessWidget {
  const HeaderTitleWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 80, right: 80, bottom: 12),
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Expanded(flex: 2,child: Text('')),
        Expanded(child: Text('t камеры', textAlign: TextAlign.center)),
        Expanded(child: Text('t продукта', textAlign: TextAlign.center)),
        Expanded(flex: 2, child: Text('время этапа', textAlign: TextAlign.center)),
        Expanded(flex: 2, child: Text('')),              
      ],),
    );
  }
}

