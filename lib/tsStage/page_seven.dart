import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goldensmoker/tsStage/page_five.dart';
import 'package:intl/intl.dart';
import 'cubit_seven.dart';
import 'state_seven.dart';
import 'constant.dart';
import 'stage.dart';
import 'widgets.dart';

class PageSeven extends StatelessWidget {
  const PageSeven(this.recipe, {super.key});
  final Recipe recipe;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          TitleBlocWidget('Готовим', recipe.name),
          TitleBlocWidget('Продолдительность', getTimeString(recipe.calculateRecipe())),
          TitleBlocWidget('Время', DateFormat('hh:mm:ss').format(DateTime.now())),
          ],
        ),
        leading: BackButton(
          onPressed: () {
            context.read<CubitSeven>().btnBack();
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
              onPressed: () => context.read<CubitSeven>().toggleLamp(),
              icon: BlocBuilder<CubitSeven, StateSeven>(builder: (context, state) => Icon(
                Icons.light_mode_sharp, size: 40, color: state.lamp ? Colors.amber : Colors.white)
                ,)),
        ],
        backgroundColor: mainFon,
      ),
      backgroundColor: mainFon,
      body: SliderWidget(recipe.stages),
    );
  }
}

class TitleBlocWidget extends StatelessWidget {
  const TitleBlocWidget(this.name, this.info, {super.key});
  final String name;
  final String info;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name, style: t16w400),
        Text(info, style: t29w500w),
      ],
    );
  }
}

class SliderWidget extends StatelessWidget {
  const SliderWidget(this.listStages, {super.key});
  final List<Stage> listStages;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CubitSeven, StateSeven>(
      builder: (context, state) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 420,
            width: double.maxFinite,
            child: PageView.builder(
              controller: state.pageController,
              // onPageChanged: (value) {},
              // pageSnapping: true,
              itemCount: listStages.length,
              itemBuilder: (context, index) => Opacity(
                opacity: (state.activePage == index) ? 1 : 0.75,
                child: AnimatedContainer(
                  width: 538,
                  height: 385,
                  padding: const EdgeInsets.only(bottom: 20),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(16))),
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOutCubic,
                  margin: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Container(
                        width: double.maxFinite,
                        height: 44,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: (state.activePage == index)
                                ? Colors.amber
                                : mainFon,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16))),
                        child: Text(listStages[index].name,
                            style:
                                (state.activePage == index) ? t26w500 : t29w500w),
                      ),
                      Container(
                          height: 331,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(16),
                                  bottomRight: Radius.circular(16))),
                          child: Column(
                            children: [
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text('t камеры:', style: t24w500),
                                  Text('t продукта:', style: t24w500),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text('${state.tbox}$indicate', style: t62w500),
                                  Text('${state.tprod}$indicate', style: t62w500),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text('${listStages[index].tempB}$indicate',
                                      style: t34w500a),
                                  Text('${listStages[index].tempP}$indicate',
                                      style: t34w500a),
                                ],
                              ),
                              Container(
                                width: double.maxFinite,
                                alignment: Alignment.center,
                                child: IndicateWidget(
                                  listStage: listStages,
                                  index: index,
                                  color: mainFon,
                                  size: 75,
                                ),
                              ),
                              const Divider(color: Color.fromARGB(255, 214, 214, 214)),
                              const SizedBox(height: 5),
                              (listStages[index].time == 0)
                                  ? ContanerRadius(Colors.white,
                                      getTimeString(listStages[index].time), 1)
                                  : ContanerRadius(Colors.amber,
                                    (state.activePage == index) ? getTimeString(state.time) : getTimeString(listStages[index].time), 1)
                            ],
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ),
          

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(onPressed: (){}, icon: const Icon(Icons.timer, size: 40, color: Colors.amber)),
                CircleIndicateWidget(listStages.length, state.activePage),
                IconButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => const PageFive()));}, icon: const Icon(Icons.back_hand, size: 40, color: Colors.amber))
              ],
            ),
          )


        ],
      ),
    );
  }
}

class CircleIndicateWidget extends StatelessWidget {
  const CircleIndicateWidget(this.length, this.activePage, {super.key});
  final int length;
  final int activePage;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ...List.generate(
            length,
            (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 3.25),
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: activePage == index ? const Color.fromRGBO(255, 255, 255, 1) : const Color.fromRGBO(255, 255, 255, 0.2),
                    shape: BoxShape.circle,
                  ),
                )),
      ],
    );
  }
}
