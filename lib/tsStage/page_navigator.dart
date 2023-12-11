import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'stage.dart';
import 'cubit_bluetooth.dart';
import 'page_creater.dart';
import 'constant.dart';
import 'state_bluetooth.dart';
import 'widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PageNavigator extends StatelessWidget {
  const PageNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: mainFon,
          title: BlocBuilder<CubitBluetooth, StateBluetooth>(
              builder: (context, state) => state.bluetoothState.stringValue == 'STATE_ON'
                  ? const Icon(Icons.bluetooth, color: Colors.amber)
                  : const Icon(Icons.bluetooth_disabled, color: Colors.grey)),
        ),
        backgroundColor: mainFon,
        body: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ButtonBookRecipe(),
            SizedBox(width: 20),
            Column(
              children: [
                ButtonDirectControl(),
                SizedBox(height: 20),
                Row(
                  children: [
                    ButtonCreateRecipe(),
                    SizedBox(width: 20),
                    ButtonRectangle()
                  ],
                )
              ],
            )
          ],
        ));
  }
}

class ButtonRectangle extends StatelessWidget {
  const ButtonRectangle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 150,
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, '/settings'),
        child: ContanerRadius(Colors.white, 24, child: Padding(padding: const EdgeInsets.all(24), child: SvgPicture.string(svgRectanle),)
        )
        ),
    );
  }
}

class ButtonCreateRecipe extends StatelessWidget {
  const ButtonCreateRecipe({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
    width: 150,
    height: 150,
    child: InkWell(
      onTap: () => Navigator.push(context,MaterialPageRoute(builder: (context) => PageCreater(Recipe('', '', '', []), true))),
      child: 
      ContanerRadius(Colors.white, 24, child: Stack(children: [
          Positioned(right: 0 ,child: SvgPicture.string(svgCreateRecipe)),
          const Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
                Padding(
                  padding: EdgeInsets.only(left: 18,  right: 50, bottom: 20),
                  child: Text('Создать рецепт', style: t20w500),
                )
          ],)
      ],)
      )
      ),
          );
  }
}

class ButtonDirectControl extends StatelessWidget {
  const ButtonDirectControl({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320,
      height: 300,
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, '/rules'),
        child: 
        ContanerRadius(Colors.white, 24, 
          child: Stack(children: [
            Positioned(right: 0, child: SvgPicture.string(svgDirectControl)),
            const Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextMainBtnWidget('Прямое управление', 'Получите прямой доступ к функциям сыроварни.'),
              ],
            )
          ],
        ))
        ),
    );
  }
}

class ButtonBookRecipe extends StatelessWidget {
  const ButtonBookRecipe({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      height: 470,
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, '/choise'),
        child: ContanerRadius(Colors.white, 24, child: 
        Stack(children: [
          Positioned(top: 55, left: 90, right: 90 ,child: SvgPicture.string(svgBookRecipe)),
          const Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextMainBtnWidget('Готовить \nпо рецепту', 'Выберите рецепт и готовьте в автоматическом или ручном режиме.')
          ],)
        ],)
        )
        ),
    );
  }
}

class TextMainBtnWidget extends StatelessWidget {
  const TextMainBtnWidget(this.title, this.trailing, {super.key});
  final String title;
  final String trailing;
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(left: 18, bottom: 24, right: 60),
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Text(title, style: t32w500),
        const SizedBox(height: 12),
        Text(trailing, style: t20w400,)
      ],),
    );
  }
}