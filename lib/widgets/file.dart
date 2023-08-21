import 'package:flutter/material.dart';
import 'example_wid_model.dart';

void main() => runApp(new ExampleApplication());

class ExampleApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(child: ExampleWid()),
      ),
    );
  }
}

class ExampleWid extends StatefulWidget {
  const ExampleWid({super.key});

  @override
  State<ExampleWid> createState() => _ExampleWidState();
}

class _ExampleWidState extends State<ExampleWid> {
  final _model = Simple();
  
  @override
  Widget build(BuildContext context) {
    return SimpleNotif(
      model: _model,
      child: Column(
        children: [
          const _ReadFileBtn(),
        ],
      ),
    );
  }
}

class _ReadFileBtn extends StatelessWidget {
  const _ReadFileBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: SimpleNotif.read(context)!.model.readFile, child: const Text('Read file'));
  }
}