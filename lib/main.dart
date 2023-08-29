import 'package:flutter/material.dart';

void main() => runApp(ExampleApplication());

class ExampleApplication extends StatelessWidget {
  const ExampleApplication({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: ChartBlu());
  }
}

class ChartBlu extends StatelessWidget {
  const ChartBlu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}