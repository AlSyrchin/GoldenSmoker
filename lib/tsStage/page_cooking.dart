import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit_time.dart';
import 'page_rules.dart';
import 'cubit_cooking.dart';
import 'state_cooking.dart';
import 'constant.dart';
import 'stage.dart';
import 'widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PageCooking extends StatelessWidget {
  const PageCooking(this.recipe, {super.key});
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
          BlocBuilder<CubitTime, String>(builder: (context, state) => TitleBlocWidget('Время', state),),
          const SizedBox(width: 180)
          ],
        ),
        leading: IconButton(
          onPressed: (){
            context.read<CubitCooking>().btnBack();
            Navigator.of(context).pop();
        }, 
        icon: const Icon(Icons.close, color: Colors.red,)
        ),

        actions: [
          IconButton(
              onPressed: () => context.read<CubitCooking>().toggleLamp(),
              icon: BlocBuilder<CubitCooking, StateCooking>(builder: (context, state) =>  SvgPicture.string(svgLamp, color: state.lamp ? Colors.amber : Colors.white)
              // Icon(Icons.light_mode_sharp, size: 40, color: state.lamp ? Colors.amber : Colors.white)
                ,)),
        ],
        backgroundColor: mainFon,
      ),
      backgroundColor: mainFon,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: SliderWidget(recipe.stages),
      ),
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
    PageController pageController = PageController(viewportFraction: 0.65);
    return BlocBuilder<CubitCooking, StateCooking>(
      builder: (context, state) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 450,
            width: double.maxFinite,
            child: PageView.builder(
              controller: pageController,
              onPageChanged: (value) {context.read<CubitCooking>().btnNext(value);},
              itemCount: listStages.length,
              itemBuilder: (context, index) => FittedBox(
                child: AnimatedContainer(
                  width: 538,
                  decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(16))),
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOutCubic,
                  margin: (state.activePage == index) ? const EdgeInsets.all(0) : const EdgeInsets.all(30),
                  child: Opacity(
                    opacity: (state.activePage == index) ? 1 : 0.75,
                    child: Transform.scale(
                      scale: (state.activePage == index) ? 1 : 0.9,
                      child: Column(
                        children: [
                          Container(
                            width: double.maxFinite,
                            height: 44,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: (state.cookingPage == index)
                                    ? Colors.amber
                                    : mainFon,
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    topRight: Radius.circular(16))),
                            child: Text(listStages[index].name, style: (state.cookingPage == index) ? t24w700 : t24w700w),
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 16, top: 24),
                              height: 331,
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(16),
                                      bottomRight: Radius.circular(16))),
                              child: Column(
                                children: [
                                  
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      TemperatureTextWidget(name: 't камеры:' ,nowIndicate: state.tbox, indicates: listStages[index].tempB,),
                                      TemperatureTextWidget(name: 't продукта:' ,nowIndicate: state.tprod, indicates: listStages[index].tempP,),
                                    ],
                                  ),
                                    
                                  const SizedBox(height: 24),
                                    
                                  Container(
                                    width: double.maxFinite,
                                    alignment: Alignment.center,
                                    child: IndicateWidget(
                                      listStage: listStages,
                                      index: index,
                                      color: mainFon,
                                      size: 64,
                                    ),
                                  ),
                                  const Spacer(),
                                  const Divider(color: Color.fromARGB(255, 214, 214, 214)),
                                  const SizedBox(height: 16),
                                  SizedBox(
                                    width: 142,
                                    height: 54,
                                    child: ContanerRadius(Colors.amber, 4, text: (listStages[index].time == 0) ? '∞' : (state.cookingPage == index) ? getTimeString(state.time)  : getTimeString(listStages[index].time), textSize: 1),
                                  )
                                ],
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          
          const Spacer(),
          FooterWidget(listStages: listStages, activePage: state.activePage)


        ],
      ),
    );
  }
}

class FooterWidget extends StatelessWidget {
  const FooterWidget({
    super.key,
    required this.listStages,
    required this.activePage
  });

  final List<Stage> listStages;
  final int activePage;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.timer, size: 40, color: Colors.amber)),
          CircleIndicateWidget(listStages.length, activePage),
          IconButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => const PageRules()));}, icon: const Icon(Icons.back_hand, size: 40, color: Colors.amber))
        ],
      ),
    );
  }
}

class TemperatureTextWidget extends StatelessWidget {
  const TemperatureTextWidget({super.key,required this.nowIndicate,required this.indicates, required this.name});

  final String name;
  final double nowIndicate;
  final double indicates;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name, style: t20w400),
        Row(
          children: [
            Text('$nowIndicate$indicate', style: t56w700),
            const SizedBox(width: 6),
            const Icon(Icons.arrow_forward, color: Colors.red),
            Text('$indicates$indicate', style: t32w700a),
          ],
        ),
      ],
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