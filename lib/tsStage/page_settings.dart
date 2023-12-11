import 'package:flutter/material.dart';
import 'constant.dart';

class PageSettings extends StatelessWidget {
  const PageSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: mainFon,
          title: const Text('Настройки'),
          centerTitle: true,
        ),
        backgroundColor: mainFon,
        body: Container());
  }
}

