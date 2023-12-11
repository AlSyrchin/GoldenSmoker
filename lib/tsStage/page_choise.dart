import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'page_creater.dart';
import 'stage.dart';
import 'state_choise.dart';
import 'constant.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit_choise.dart';

class PageChoise extends StatelessWidget {
  const PageChoise({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: mainFon,
          title: BlocBuilder<CubitChoise, StateChoise>(
            builder: (context, state) => state.isSearch
                ? const SearchTextWidget()
                : const Text('Выберите рецепт'),
          ),
          actions: [
            BlocBuilder<CubitChoise, StateChoise>(
                builder: (context, state) => IconButton(
                    icon: Icon(state.isSearch ? Icons.clear : Icons.search),
                    onPressed: () {
                      state.isSearch
                          ? context.read<CubitChoise>().offSearch()
                          : context.read<CubitChoise>().onSearch();
                    }))
          ],
        ),
        backgroundColor: mainFon,
        body: BlocBuilder<CubitChoise, StateChoise>(builder: (context, state) => GridWidget(state.queryStages)));
  }
}

class SearchTextWidget extends StatelessWidget {
  const SearchTextWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        height: 55,
        width: 700,
        child: TextField(
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search),
            hintText: 'search...',
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Colors.white)),
          ),
        onChanged: (value) => context.read<CubitChoise>().addString(value),
        onTapOutside: (event) => {
          SystemChannels.textInput.invokeMethod('TextInput.hide'),
          SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky)
          }
        ),
      );
  }
}

class SliderWidget extends StatelessWidget {
  const SliderWidget(this.listRecipe, {super.key});
  final List<Recipe> listRecipe;
  @override
  Widget build(BuildContext context) {
    final pageController = PageController();
    return PageView.builder(
      controller: pageController,
      pageSnapping: true,
      itemCount: listRecipe.length,
      itemBuilder: (context, index) => Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Image.asset(listRecipe[index].image,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) =>
                    const Center(child: Text('Error load image'))),
          ),
          Text(listRecipe[index].name)
        ],
      ),
    );
  }
}

class GridWidget extends StatelessWidget {
  const GridWidget(this.listRecipe, {super.key});
  final List<Recipe> listRecipe;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, mainAxisSpacing: 5, crossAxisSpacing: 5, childAspectRatio: 0.85),
        itemCount: listRecipe.length,
        itemBuilder: (context, index) => InkWell(
              onTap: () => Navigator.push(context,MaterialPageRoute(builder: (context) => PageCreater(listRecipe[index], false))),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    width: 240,
                    height: 220,
                    child: Image.asset(listRecipe[index].image,
                        fit: BoxFit.contain,
                        color: Colors.amber,
                        errorBuilder: (context, error, stackTrace) =>
                            const Center(child: Text('Error load image'))),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    listRecipe[index].name,
                    style: const TextStyle(fontSize: 20),
                  )
                ],
              ),
            ));
  }
}
