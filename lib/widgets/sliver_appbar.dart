import 'package:flutter/material.dart';

class PageOne extends StatelessWidget {
  const PageOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
                const SliverAppBar(
                  expandedHeight: 40,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text('2435'),
                  ),
                )
              ],
          body: const Column(
            children: [Text('11'),
            Text('11'),
            Text('11'),
            Text('11'),
            Text('11')],
          )),
    );
  }
}

class PageTwo extends StatelessWidget {
  const PageTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
                const SliverAppBar(
                  pinned: true,
                  snap: true,
                  floating: true,
                  expandedHeight: 40,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text('2435'),
                  ),
                )
              ],
          body: const Column(
            children: [Text('11'),
            Text('11'),
            Text('11'),
            Text('11'),
            Text('11')],
          )),
    );
  }
}