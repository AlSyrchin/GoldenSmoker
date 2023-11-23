// Из соображений безопасности Android и iOS не позволяют нам читать и писать где-либо на жестком диске. Нам нужно сохранить наши текстовые файлы в каталоге Documents , где приложение может получить доступ только к своим собственным файлам. Эти файлы будут удалены только при удалении приложения.
//Каталог документов — это NSDocumentDirectory на iOS и AppData на Android.

import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kindacode.com',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // This will be displayed on the screen
  String? _content;

  // Find the Documents path
  Future<String> _getDirPath() async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  // This function is triggered when the "Read" button is pressed
  Future<void> _readData() async {
    final dirPath = await _getDirPath();
    final myFile = File('$dirPath/data.txt');
    final data = await myFile.readAsString(encoding: utf8);
    setState(() {
      _content = data;
    });
  }

  // TextField controller
  final _textController = TextEditingController();
  // This function is triggered when the "Write" buttion is pressed
  Future<void> _writeData() async {
    final dirPath = await _getDirPath();

    final myFile = File('$dirPath/data.txt');
    // If data.txt doesn't exist, it will be created automatically

    await myFile.writeAsString(_textController.text);
    _textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kindacode.com'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _textController,
              decoration: const InputDecoration(labelText: 'Enter your name'),
            ),
            ElevatedButton(
              onPressed: _writeData,
              child: const Text('Save to file'),
            ),
            const SizedBox(
              height: 150,
            ),
            Text(_content ?? 'Press the button to load your name',
                style: const TextStyle(fontSize: 24, color: Colors.pink)),
            ElevatedButton(
              onPressed: _readData,
              child: const Text('Read my name from the file'),
            )
          ],
        ),
      ),
    );
  }
}




// // Данный способ используется только для чтения
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart' show rootBundle;
// import 'dart:async';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Kindacode.com',
//       home: HomePage(),
//     );
//   }
// }

// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   String? _data;

//   // This function is triggered when the user presses the floating button
//   Future<void> _loadData() async {
//     final loadedData = await rootBundle.loadString('assets/data.txt');
//     setState(() {
//       _data = loadedData;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Kindacode.com'),
//       ),
//       body: Center(
//           child: SizedBox(
//               width: 300,
//               child: Text(_data ?? 'Nothing to show',
//                   style: const TextStyle(fontSize: 24)))),
//       floatingActionButton: FloatingActionButton(
//           onPressed: _loadData, child: const Icon(Icons.add)),
//     );
//   }
// }