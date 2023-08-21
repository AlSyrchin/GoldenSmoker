import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:csv/csv.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const ExampleApplication());
}

class ExampleApplication extends StatelessWidget {
  const ExampleApplication({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    return MaterialApp(
      theme: ThemeData.dark(),
      home: BlocProvider<CubitBluetooth>(
        create: (_) => CubitBluetooth(),
        child: const TabController(),
      ),
    );
  }
}

class CubitBluetooth extends Cubit<StateBluetooth> {
  //Переменные
  late BluetoothUser user;
  SensorItem sensor = SensorItem();
  BluetoothDevice? device;
  BluetoothConnection? connection;
  bool get isConnected => (connection?.isConnected ?? false);
  int indexRemove = 0;
  FileJob file = FileJob();
  //Инициализация
  CubitBluetooth() : super(StateBluetooth()) {
    _init();
  }

  //Логика
  Future<void> _init() async {
    user = BluetoothUser();
    await user._connectBluetooth();
    await user._setName();
    await user._setAddres();
    await user._setStateBluetooth();
    if (user.isConnect) await user.getListDevices();
    device = await user.getDev();
    if (device != null) await connectChat(device!);
    timerInit();
    file.toCSV(['st', 'tm', 'tw', 't', 'pv']);
  }

  Future<void> connectChat(BluetoothDevice device) async {
    await BluetoothConnection.toAddress(device.address).then((connect) {
      connection = connect;
      connection!.input!
      .listen(_onDataReceived)
      .onDone(() {
        // connection!.close(); 
        // user._connectBluetooth();
        });
    }).catchError((error) {
      print('Ошибка: $error');
    });
  }

  void _onDataReceived(Uint8List data) {
    String dataString = utf8.decode(data).trim();
    final newStateStr = state.copyWith(chatList: state.chatList.addMessage(dataString));
    emit(newStateStr);

    List<String> listTst = dataString.split('_');
    // listTst.removeLast();
    if (listTst.isEmpty) return;
    for (var command in listTst) {
      switch (command.substring(0, 2)) {
        case 'TM':
          sensor.tm = funcCom(command);
          break;
        case 'TW':
          sensor.tw = funcCom(command);
          break;
        case 'HS':
          sensor.hs = funcCom(command);
          break;
        case 'KS':
          sensor.ks = funcCom(command);
          break;
        case 'HD':
          sensor.hd = funcCom(command);
          break;
        case 'PV':
          sensor.pv = funcCom(command) * 10;
          break;
        case 'ST':
          sensor.st = funcCom(command) * 10;
          break;
        default:
      }
    }
    sensor.parseData();
  }

  // void removeLast() {
  //   if (state.graphList.pv.length > 99) {
  //     state.graphList.removeSensor(0);
  //   }
  // }

  void removeElement() {
    if (state.graphList.pv.length > 500) {
      indexRemove = (indexRemove + 4) % 500;
      state.graphList.removeSensor(indexRemove);
    }
  }

  // bool isDuble() {
  //   indexRemove++;
  //   if (state.graphList.pv.last == sensor.pv &&
  //       state.graphList.tw.last == sensor.tw &&
  //       state.graphList.tm.last == sensor.tm &&
  //       state.graphList.t.last == sensor.t &&
  //       state.graphList.st.last == sensor.st &&
  //       indexRemove % 2 == 0) {
  //     return true;
  //   }
  //   return false;
  // }

  void timerInit() {
    Timer.periodic(const Duration(seconds: 5), (_) {
      if (isConnected) {
        //Запись в файл
        file.toCSV([sensor.st, sensor.tm, sensor.tw, sensor.t, sensor.pv]);
        //Удаление старых элементов с графика
        removeElement();
        //Запись в state
        final newStateSens = state.copyWith(
            graphList: state.graphList.addSensor(
                sensor.tm, sensor.tw, sensor.t, sensor.pv, sensor.st));
        emit(newStateSens);
      }
    });
  }

  Future<void> sendMessage(String text) async {
    if (text.isNotEmpty) {
      try {
        connection!.output
            .add(Uint8List.fromList(utf8.encode('${text.toUpperCase()}\r\n')));
        await connection!.output.allSent;
        final newMessage =
            state.copyWith(chatList: state.chatList.addMessage(text));
        emit(newMessage);
      } catch (e) {
        print(e);
      }
    }
  }

  double funcCom(String command) {
    return int.parse(command.substring(2)) / 10;
  }
}

class StateBluetooth {
  late List<ChartElement>? chartElement;
  final ChatConnect chatList;
  final GraphConnect graphList;
  StateBluetooth([
    this.chatList = const ChatConnect(),
    this.graphList = const GraphConnect(),
    this.chartElement,
  ]) {
    chartElement = [
      ChartElement(graphList.tm, 't молока TM', Colors.orangeAccent),
      ChartElement(graphList.tw, 't рубашки TW', Colors.blueAccent),
      ChartElement(graphList.t, 't установл. T', Colors.greenAccent),
      ChartElement(graphList.pv, 'Нагрев PV', Colors.redAccent),
      ChartElement(
        graphList.st,
        'Этап ST',
        Colors.grey,
      )
    ];
  }

  StateBluetooth copyWith(
      {ChatConnect? chatList,
      GraphConnect? graphList,
      List<ChartElement>? chartElement}) {
    return StateBluetooth(
      chatList ?? this.chatList,
      graphList ?? this.graphList,
      chartElement ?? this.chartElement,
    );
  }

  @override
  String toString() =>
      'StateBluetooth(chatList: $chatList, graphList: $graphList)';

  @override
  bool operator ==(covariant StateBluetooth other) {
    if (identical(this, other)) return true;

    return other.chatList == chatList &&
        other.graphList == graphList &&
        listEquals(other.chartElement, chartElement);
  }

  @override
  int get hashCode =>
      chatList.hashCode ^ graphList.hashCode ^ chartElement.hashCode;
}

class FileJob {
  String nowTime = DateFormat('yyyy-MM-dd_HH-mm-ss').format(DateTime.now());
  FileJob();
  Future<List<List<dynamic>>> loadCSV() async {
    Directory? dir = await getExternalStorageDirectory();
    File f = File('${dir!.path}/$nowTime.csv');
    final input = f.openRead();
    final fields = await input.transform(utf8.decoder).transform(const CsvToListConverter()).toList();
    return fields;
  }

  Future<void> toCSV(List<dynamic> data) async {
    Directory? dir = await getExternalStorageDirectory();
    File f = File('${dir!.path}/$nowTime.csv');
    List<List<dynamic>> rows = List<List<dynamic>>.empty(growable: true);
    rows.add(data);
    String csv = const ListToCsvConverter().convert(rows);
    f.writeAsString('$csv\n', mode: FileMode.writeOnlyAppend);
  }
}

class ChatConnect {
  final List<String> message;
  const ChatConnect([this.message = const []]);

  ChatConnect addMessage(String newStr) {
    List<String> newMessages = message.toList();
    if (newMessages.length > 100) {
      newMessages.removeAt(0);
    }
    newMessages.add(newStr);
    return ChatConnect(newMessages);
  }
}

class GraphConnect {
  final List<double> tm;
  final List<double> tw;
  final List<double> t;
  final List<double> pv;
  final List<double> st;
  const GraphConnect([
    this.tm = const [0],
    this.tw = const [0],
    this.t = const [0],
    this.pv = const [0],
    this.st = const [0],
  ]);
  GraphConnect addSensor(double tmItem, twItem, tItem, pvItem, stItem) {
    return GraphConnect([...tm, tmItem], [...tw, twItem], [...t, tItem],
        [...pv, pvItem], [...st, stItem]);
  }

  void removeSensor(int index) {
    tm.removeAt(index);
    tw.removeAt(index);
    t.removeAt(index);
    pv.removeAt(index);
    st.removeAt(index);
  }
}

class BluetoothUser {
  final FlutterBluetoothSerial bluetooth = FlutterBluetoothSerial.instance;
  String nameDev;
  String addresDev;
  BluetoothState bluetoothState;
  bool isConnect;
  List<BluetoothDevice>? devicesList = [];
  BluetoothUser([
    this.nameDev = '',
    this.addresDev = '',
    this.bluetoothState = BluetoothState.UNKNOWN,
    this.isConnect = false,
  ]);

  Future<void> _connectBluetooth() async {
    await bluetooth.requestEnable();
  }

  Future<void> _setName() async {
    await bluetooth.name.then((name) {
      nameDev = name!;
    });
  }

  Future<void> _setAddres() async {
    await bluetooth.address.then((address) {
      addresDev = address!;
    });
  }

  Future<void> _setStateBluetooth() async {
    await bluetooth.state.then((stateS) => bluetoothState = stateS);
    if (bluetoothState.stringValue == 'STATE_ON') isConnect = true;
  }

  Future<void> getListDevices() async {
    await bluetooth.getBondedDevices().then((list) => devicesList = list);
  }

  Future<BluetoothDevice?> getDev() async {
    if (devicesList!.isNotEmpty) {
      for (var item in devicesList!) {
        if (item.isBonded) {
          return item;
        }
      }
    }
    return null;
  }
}

class ChartElement {
  final List<double> data;
  final String name;
  final Color color;
  const ChartElement(this.data, this.name, this.color);
}

class SensorItem {
  double tm;
  double tw;
  double hs;
  double ks;
  double hd;
  double pv;
  double st;
  double t;
  SensorItem([
    this.tm = 0,
    this.tw = 0,
    this.hs = 0,
    this.ks = 0,
    this.hd = 0,
    this.pv = 0,
    this.st = 0,
    this.t = 0,
  ]);
  void parseData() {
    switch (st) {
      case 0:
        st = 0;
        pv = 0;
        t = 0;
        break;
      case 1 || 2:
        t = hs;
        break;
      case 3:
        t = ks;
        break;
      case 4:
        t = hd;
        break;
      default:
    }
  }
}

class TabController extends StatelessWidget {
  const TabController({super.key});

  static const List<Widget> tabs = [
    Tab(icon: Icon(Icons.home)),
    Tab(icon: Icon(Icons.graphic_eq)),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        bottomNavigationBar: BottomAppBar(
          child: TabBar(
            labelColor: Colors.amber,
            indicatorColor: Colors.amber,
            tabs: tabs.map((Widget el) => el).toList(),
          ),
        ),
        body: TabBarView(
          children: [
            const WindowGraph(),
            WindowChat(),
          ],
        ),
      ),
    );
  }
}

class WindowGraph extends StatelessWidget {
  const WindowGraph({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CubitBluetooth>();
    return Container(
      color: const Color.fromRGBO(31, 10, 9, 1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            flex: 2,
            child: Column(
              children: [

                BlocBuilder<CubitBluetooth, StateBluetooth>(
                  builder: (context, state) {
                    print('--------------------Status');
                    return Column(children: [
                      Text('${cubit.user.bluetoothState}'),
                      cubit.isConnected ? Text('${cubit.device!.name}') : Text('Not device'),
                    ],);
                  },
                ),

                
                BlocBuilder<CubitBluetooth, StateBluetooth>(
                  builder: (context, state) {
                    return cubit.isConnected
                        ? Text('Message: ${state.chatList.message.last}')
                        : const Text('');
                  },
                ),
              ],
            ),
          ),
          Flexible(
            flex: 2,
            child: BlocBuilder<CubitBluetooth, StateBluetooth>(
                builder: (context, state) {
              return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: state.chartElement!
                      .map((ChartElement element) => BoxCircle(
                            text: element.data.last.toString(),
                            color: element.color,
                          ))
                      .toList());
            }),
          ),
          const Flexible(
            flex: 10,
            child: GraphsView(),
          )
        ],
      ),
    );
  }
}

class GraphsView extends StatelessWidget {
  const GraphsView({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CubitBluetooth, StateBluetooth>(
      builder: (context, state) {
        print('build graph');
        return SfCartesianChart(
          plotAreaBorderWidth: 0,
          legend: const Legend(
              isVisible: true,
              position: LegendPosition.top,
              textStyle: TextStyle(color: Colors.white)),
          primaryXAxis: NumericAxis(
            majorGridLines: const MajorGridLines(width: 0),
            edgeLabelPlacement: EdgeLabelPlacement.shift,
            // interval: 1,
          ),
          primaryYAxis: NumericAxis(
              opposedPosition: true,
              maximum: 100,
              axisLine: const AxisLine(width: 0),
              labelFormat: r'{value}°',
              majorTickLines: const MajorTickLines(size: 0)),
          series: state.chartElement!
              .map((ChartElement chElement) => LineSeries<double, int>(
                    dataSource: chElement.data,
                    width: 1,
                    xValueMapper: (double sales, i) => i,
                    yValueMapper: (double sales, _) => sales,
                    color: chElement.color,
                    name: chElement.name,
                    legendItemText: chElement.name,
                    animationDuration: 0,
                  ))
              .toList(),
          zoomPanBehavior: ZoomPanBehavior(
              maximumZoomLevel: 0.1,
              enablePinching: true,
              zoomMode: ZoomMode.x,
              enablePanning: true,
              enableMouseWheelZooming: true),
          trackballBehavior: TrackballBehavior(
            lineColor: Colors.amber,
            lineWidth: 4,
            enable: true,
            hideDelay: 1000,
            activationMode: ActivationMode.singleTap,
            shouldAlwaysShow: true,
          ),
        );
      },
    );
  }
}

class BoxCircle extends StatelessWidget {
  String text;
  Color color;
  BoxCircle({
    Key? key,
    required this.text,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 70,
      decoration: BoxDecoration(
          shape: BoxShape.circle, border: Border.all(width: 5, color: color)),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

class WindowChat extends StatelessWidget {
  WindowChat({super.key});
  TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CubitBluetooth>();
    return SafeArea(
      child: Container(
        color: const Color.fromRGBO(31, 10, 9, 1),
        child: Column(
          children: <Widget>[
            Flexible(
              child: BlocBuilder<CubitBluetooth, StateBluetooth>(
                  builder: (context, state) {
                    print('build message');
                return ListView(
                    padding: const EdgeInsets.all(12.0),
                    children: state.chatList.message
                        .map((e) => Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: Container(
                                    padding: const EdgeInsets.all(12.0),
                                    margin: const EdgeInsets.only(
                                        bottom: 8.0, left: 8.0, right: 8.0),
                                    decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius:
                                            BorderRadius.circular(7.0)),
                                    child: Text(e),
                                  ),
                                ),
                              ],
                            ))
                        .toList());
              }),
            ),
            Row(
              children: <Widget>[
                Flexible(
                  child: Container(
                    margin: const EdgeInsets.only(left: 16.0),
                    child: TextField(
                      controller: nameController,
                      decoration: const InputDecoration.collapsed(
                        hintText: 'Введите сообщение...',
                      ),
                      enabled: cubit.isConnected,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(8.0),
                  child: IconButton(
                      icon: const Icon(Icons.send),
                      color: Colors.white,
                      onPressed: () {
                        cubit.sendMessage(nameController.text);
                        nameController.clear();
                      }),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
