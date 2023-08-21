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
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<String>>? _contacts;

  @override
  void initState() {
    super.initState();
    _contacts = _readData();
  }

  Future<List<String>> _readData() async {
    final dir = await getApplicationDocumentsDirectory();
    final dirPath = dir.path;
    final myFile = File('$dirPath/data.csv');
    await myFile.writeAsString('id, name, age \n 1, jo, 33 \n 2, bil, 25 \n 3, margo, 15');

    final data = await myFile.readAsString(encoding: utf8);
    final List<String> dataList = data.split('\n');
    // final List<List<String>> dataDueList = List.unmodifiable(dataList.map((e) => e.split(',')));
    return Future.value(dataList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: [
              FutureBuilder<List<String>?>(
                  future: _contacts,
                  builder: (context, snapshot) {
                    List<Widget> children;
                    if (snapshot.connectionState == ConnectionState.done) {
                      children = <Widget>[
                        Flexible(
                          flex: 10,
                          child: ListView.builder(
                            itemCount: 3,
                            itemBuilder: (_, index) {
                              return Card(
                                margin: const EdgeInsets.all(3),
                                color: index == 0 ? Colors.amber : Colors.white,
                                child: Text(snapshot.data![index].toString()),
                              );
                            },
                          ),
                        ),
                      ];
                    } else {
                      children = <Widget>[
                        const Icon(
                          Icons.error_outline,
                          color: Colors.red,
                          size: 60,
                        ),
                      ];
                    }
                    return Center(
                      child: Column(
                        children: children,
                      ),
                    );
                  }),

             
        
            ],
          ),
        ),
      ),
    );
  }
}
