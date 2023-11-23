import 'package:flutter/material.dart';
import 'main_page.dart';

void main() => runApp(const ExampleApplication());

class ExampleApplication extends StatelessWidget {
  const ExampleApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MainPage());
  }
}