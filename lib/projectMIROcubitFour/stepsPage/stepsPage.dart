import 'package:intl/intl.dart';
import '../constant.dart';
import 'cubit.dart';
import '../etap.dart';
import '../recipeCreatePage/stepsPage.dart';
import 'state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class StepsPage extends StatelessWidget {
  const StepsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final recCubit = context.read<HomePageCubit>(); 
    return Scaffold(
      appBar: AppBar(
        title: const Text('Шаги рецепта', style: TextStyle(fontSize: 26)),
        centerTitle: true,
        backgroundColor: mainFon,
      ),
      backgroundColor: mainFon,
      body: SafeArea(
        child: Column(
          children: [
          BlocBuilder<HomePageCubit, ListState>(
            bloc: recCubit,
            builder: (context, state) => StepsReorder(state.stage)
          ),
        ],
      )
      ),
    );
  }

}

class StepsReorder extends StatelessWidget {
  const StepsReorder(this.listStage, {super.key});
  final List<Stage> listStage;
  @override
  Widget build(BuildContext context) {
    final recCubit = context.read<HomePageCubit>();
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
      SizedBox(
          height: h(context, 662),
          child: ReorderableListView.builder(
              buildDefaultDragHandles: false,
              padding: EdgeInsets.symmetric(horizontal: w(context, 152)),
              itemCount: listStage.length,
              itemBuilder: (context, index) => ListTile(
                horizontalTitleGap: 8,
                key: ValueKey(listStage[index]),
                leading: ReorderableDragStartListener(
                  index: index,
                  child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.apps,
                          size: 22,
                          color: Color.fromRGBO(255, 255, 255, 0.6))),
                ),
                title: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: w(context, 40), vertical: h(context, 25)),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                          flex: 3,
                          child: Text(listStage[index].name, style: t32w700)),
                      Expanded(
                          child: Text(
                              '${DateFormat.m().format(DateTime.parse('00000000${listStage[index].time}'))} мин',
                              style: t32w700)),
                      Expanded(
                          child: Text(
                        '${listStage[index].tempB}$indicate C',
                        style: t32w700,
                      )),
                      Expanded(
                          child: Text(
                              '${listStage[index].tempP}$indicate C',
                              style: t32w700)),
                      Expanded(
                          child: Row(
                        children: [
                          listStage[index].extractor
                              ? const Icon(Icons.place, color: Colors.black)
                              : const Text(''),
                          listStage[index].smoke
                              ? const Icon(Icons.cabin, color: Colors.black)
                              : const Text(''),
                          listStage[index].water
                              ? const Icon(Icons.kayaking,
                                  color: Colors.black)
                              : const Text(''),
                          listStage[index].flap
                              ? const Icon(Icons.label, color: Colors.black)
                              : const Text(''),
                        ],
                      ))
                    ],
                  ),
                ),
                trailing: IconButton(
                    onPressed: () => {recCubit.remStage(index)},
                    icon: const Icon(Icons.delete_outline,
                        size: 22,
                        color: Color.fromRGBO(255, 255, 255, 0.6))),
              ),
              onReorder: (oldIndex, newIndex) => {recCubit.fromTo(oldIndex, newIndex)},
              footer: InkWell(
                onTap: () => {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => NewStep()))
                  // recCubit.addStage()
                  },
                child: Container(
                    margin: EdgeInsets.only(
                        left: 70, right: 500, top: h(context, 20), bottom: h(context, 20)),
                    padding: EdgeInsets.symmetric(
                        horizontal: w(context, 24), vertical: h(context, 13)),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8))),
                    child: const Text(
                      'Новое действие',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    )),
              ),
            )),
      const Divider(),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
              onTap: () => {},
              child: const ContanerRadius(Colors.white, 'Готовить')),
          const SizedBox(width: 50),
          InkWell(
              onTap: () => {},
              child: const ContanerRadius(Colors.amber, 'Сохранить'))
        ],
      )
        ],
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
      width: w(context, 320),
      height: h(context, 128),
      decoration: BoxDecoration(color: color, borderRadius: const BorderRadius.all(Radius.circular(16))),
      child: Center(child: Text(text, style: TextStyle(color: mainFon, fontSize: h(context, 48)))),
    );
  }
}