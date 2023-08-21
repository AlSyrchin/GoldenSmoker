// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

// late List<List<dynamic>> employeeData;
// employeeData  = List<List<dynamic>>.empty(growable: true);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CSV file',
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

  late FileJob file = FileJob();
  late List<List<dynamic>> _data = [];
  final List<dynamic> dat = ['st', 'tm', 'tw', 't', 'pv'];

  @override
  void initState() {
    super.initState();
    }

  // List<List<dynamic>> _data = [];

  // // Функция по кнопке
  // void _loadCSV() async {
  //   String dir = (await getExternalStorageDirectory())!.path + "test.csv";
  //   File f = File(dir);
  //   final input = f.openRead();
  //   final fields = await input
  //       .transform(utf8.decoder)
  //       .transform(const CsvToListConverter())
  //       .toList();
  //   List<List<dynamic>> listData = fields;
  //   setState(() {
  //     _data = listData;
  //   });
  // }

  // void _toFileCSV() async{
  //   late List<DataFile> data = List<DataFile>.empty(growable: true);
  //   data.add(DataFile(id: 21, name: 'Nick', age: 16));
  //   data.add(DataFile(id: 9, name: 'Make', age: 20));
  //   data.add(DataFile(id: 11, name: 'Alex', age: 40));
  //   late List<List<dynamic>> rows = List<List<dynamic>>.empty(growable: true);
  //   for (var element in data) {
  //     rows.add([element.id, element.name, element.age]);
  //   }
  //   String dir = (await getExternalStorageDirectory())!.path + "test.csv";
  //   File f = File(dir);
  //   String csv = const ListToCsvConverter().convert(rows);
  //   f.writeAsString(csv);
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(children: [
        Flexible(
          flex: 10,
          child: ListView.builder(
        itemCount: _data.length,
        itemBuilder: (_, index) {
          return Card(
            margin: const EdgeInsets.all(3),
            color: index == 0 ? Colors.amber : Colors.white,
            child: ListTile(
              leading: Text('${_data[index][0]}'),
              title: Text('${_data[index][1]} | ${_data[index][2]}'),
              trailing: Text('${_data[index][3]} | ${_data[index][4]}'),
            ),
          );
        },
      ),),
      Flexible(
        flex: 2,
        child: IconButton(onPressed: () => file.toCSV(dat), icon: const Icon(Icons.access_alarms_outlined)))
      ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){file.loadCSV().then((value) {_data = value; setState(() {});});}, 
          child: const Icon(Icons.add)
          ),
    );
  }
}

class FileJob {
  late List<List<dynamic>> rows = List<List<dynamic>>.empty(growable: true);

  FileJob();
  Future<List<List<dynamic>>> loadCSV() async {
    Directory? dir = await getExternalStorageDirectory();
    File f = File('${dir}test.csv');
    final input = f.openRead();
    final fields = await input.transform(utf8.decoder).transform(const CsvToListConverter()).toList();
    return fields;
  }

  // Future<void> toCSV(List<dynamic> data) async {
  //   Directory? dir = await getExternalStorageDirectory();
  //   File f = File('${dir!.path}test.csv');
  //   for (var element in data) {
  //     rows.add([element.id, element.name, element.age]);
  //   }
  //   String csv = const ListToCsvConverter().convert(rows);
  //   f.writeAsString(csv, mode: FileMode.writeOnlyAppend);
  // }
  Future<void> toCSV(List<dynamic> data) async {
    Directory? dir = await getExternalStorageDirectory();
    File f = File('${dir}test.csv');
    rows.add(data);
    String csv = const ListToCsvConverter().convert(rows);
    f.writeAsString(csv, mode: FileMode.writeOnlyAppend);
  }
}

class DataFile {
  int id;
  String name;
  int age;
  DataFile({
    required this.id,
    required this.name,
    required this.age,
  });
}

// import 'package:csv/csv.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// void main() {
//   runApp(const MyApp());
// }
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: ReadCsvFile(),
//     );
//   }
// }
// class ReadCsvFile extends StatefulWidget {
//   const ReadCsvFile({Key? key}) : super(key: key);
//   @override
//   _ReadCsvFileState createState() => _ReadCsvFileState();
// }
// class _ReadCsvFileState extends State<ReadCsvFile> {
//   List<List<dynamic>> _data = [];
//   @override
//   void initState() {
//     super.initState();
//     _loadCSV();
//   }
//   void _loadCSV() async {
//     final rawData = await rootBundle.loadString("assets/test.csv");
//     List<List<dynamic>> listData = const CsvToListConverter().convert(rawData);
//     setState(() {
//       _data = listData;
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text("read csv file"),
//         ),
//         body: ListView.builder(
//           itemCount: _data.length,
//           itemBuilder: (_, index) {
//             return Card(
//               margin: const EdgeInsets.all(3),
//               color: Colors.white,
//               child: ListTile(
//                 leading: Text(_data[index][0].toString()),
//                 title: Text(_data[index][1]),
//                 trailing: Text(_data[index][2].toString()),
//               ),
//             );
//           },
//         ));
//   }
// }
// // </List<dynamic></List<dynamic></ReadCsvFile>