// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

void main() {
  runApp(ExampleApplication());
}

class ExampleApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    return MaterialApp(
      home: Provider<UserCubit>(create: (_) => UserCubit(), //UserCubit(),
      child: const TabController(),
        // home: MultiBlocProvider(
        //   providers: [
        //     BlocProvider<UserCubit>(create: (_) => UserCubit()),
        //     BlocProvider<ChartCubit>(create: (_) => ChartCubit(BlocProvider.of<UserCubit>(context))), //BlocProvider.of<UserCubit>(context)
        //   ],
    ),
    );
  }
}

class DataSensor {
  double tm;
  double tw;
  double pv;
  double st;
  double hs;
  double ks;
  double hd;
  double t;
  DataSensor([
    this.tm = 0,
    this.tw  = 0,
    this.pv  = 0,
    this.st  = 0,
    this.hs  = 0,
    this.ks  = 0,
    this.hd  = 0,
    this.t  = 0,
  ]);
}

class ChartCubit extends Cubit<DataChart> {
  DataSensor com = DataSensor();
  StreamSubscription? strimMessage;
  ChartCubit({required Stream<BluetoothUser> bluetoothUser}) : super(DataChart()) {
    strimMessage = bluetoothUser.listen((state) {_onDataReceived(state.dataStr);});
    // Stream potoc = Stream.periodic(Duration(seconds: 3) (){}).listen((event) { });
  }
  double funcCom(String command) {
    return int.parse(command.substring(2)) / 10;
  }
  void _onDataReceived(String data) {
    List<String> listTst = data.split('_');
    for (var command in listTst) {
      switch (command.substring(0, 2)) {
        case 'TM':
          com.tm = funcCom(command);
          break;
        case 'TW':
          com.tw = funcCom(command);
          break;
        case 'HS':
          com.hs = funcCom(command);
          break;
        case 'KS':
          com.ks = funcCom(command);
          break;
        case 'HD':
          com.hd = funcCom(command);
          break;
        case 'PV':
          com.pv = funcCom(command);
          break;
        case 'ST':
          com.st = funcCom(command) * 10;
          break;
        default:
      }
    }
        switch (com.st){
          case 0: com = DataSensor();
          break;
          case 1 || 2: com.t=com.hs;
          break;
          case 3: com.t=com.ks;
          break;
          case 4: com.t=com.hd;
          break;
          default:
        }
      final newState = state.copyWith(dataTM: [...state.dataTM, com.tm], dataTW: [...state.dataTW, com.tw], dataT: [...state.dataT, com.t], dataPV: [...state.dataPV, com.pv], dataST: [...state.dataST, com.st]);
      print(newState.toString());
      emit(newState);
    }
}
class DataChart {
  final List<double> dataTM;
  final List<double> dataTW;
  final List<double> dataT;
  final List<double> dataPV;
  final List<double> dataST;
  List<ChartElement>? chartElement;
  DataChart({
    this.dataTM = const <double>[] ,
    this.dataTW = const <double>[],
    this.dataT = const <double>[],
    this.dataPV = const <double>[],
    this.dataST = const <double>[],
  }){
    chartElement = [
          ChartElement(dataTM, 't молока TM', 'TM', Colors.orangeAccent),
          ChartElement(dataTW,'t рубашки TW', 'TW', Colors.blueAccent),
          ChartElement(dataT,'t установл.', 'HS_TS_KS_HD', Colors.greenAccent),
          ChartElement(dataPV,'Нагрев PV', 'PV', Colors.redAccent),
          ChartElement(dataST, 'Этап ST', 'ST', Colors.grey,)
    ];
  }

  DataChart copyWith({
    List<double>? dataTM,
    List<double>? dataTW,
    List<double>? dataT,
    List<double>? dataPV,
    List<double>? dataST,
  }) {
    return DataChart(
      dataTM: dataTM ?? this.dataTM,
      dataTW: dataTW ?? this.dataTW,
      dataT: dataT ?? this.dataT,
      dataPV: dataPV ?? this.dataPV,
      dataST: dataST ?? this.dataST
    );
  }

  @override
  String toString() {
    return '-----> dataTM: $dataTM, dataTW: $dataTW, dataT: $dataT, dataPV: $dataPV, dataST: $dataST';
  }

  @override
  bool operator ==(covariant DataChart other) {
    if (identical(this, other)) return true;
    return 
      listEquals(other.dataTM, dataTM) &&
      listEquals(other.dataTW, dataTW) &&
      listEquals(other.dataT, dataT) &&
      listEquals(other.dataPV, dataPV) &&
      listEquals(other.dataST, dataST);
  }

  @override
  int get hashCode {
    return dataTM.hashCode ^
      dataTW.hashCode ^
      dataT.hashCode ^
      dataPV.hashCode ^
      dataST.hashCode;
  }
}

class UserCubit extends Cubit<BluetoothUser> {
  // late Directory dir;
  // late File myFile;
  // Timer timer = Timer.periodic(const Duration(seconds: 5),(_){});

  UserCubit() : super(BluetoothUser()) {
    _initialize();
    // _getDirPath();
  }
  
  Future<void> _initialize() async {
    await _connectBluetooth();
    await _setName();
    await _setAddres();
    await _setStateBluetooth();
    emit(state.copyWith(nameDev: state.nameDev, addresDev: state.addresDev, bluetoothState: state.bluetoothState, isConnect: state.isConnect));
    strimStateBluetooth();
    if (state.isConnect) await getListDevices();
    print(state.toString());
    await openChat();
  }

  Future<void> _connectBluetooth() async {
    await state.bluetooth.requestEnable();
  }

  Future<void> _setName() async {
    await state.bluetooth.name.then((name) {
      state.nameDev = name!;
    });
  }

  Future<void> _setAddres() async {
    await state.bluetooth.address.then((address) {
      state.addresDev = address!;
    });
  }

  Future<void> _setStateBluetooth() async {
    await state.bluetooth.state.then((_state) => state.bluetoothState = _state);
    if (state.bluetoothState.stringValue == 'STATE_ON') state.isConnect = true;
  }

  void strimStateBluetooth() {
    state.bluetooth.onStateChanged().listen((BluetoothState state) {}).onData((data) {
       switch (data.stringValue) {
        case 'STATE_ON': 
            state.isConnect = true; 
            state.bluetoothState = data; 
            emit(state.copyWith(bluetoothState: state.bluetoothState));
          break;
        case 'STATE_OFF': 
            state.isConnect = false; 
            state.bluetoothState = data;
            emit(state.copyWith(bluetoothState: state.bluetoothState));
          break;
          default:
       }});
  }

  Future<void> getListDevices() async {
    await state.bluetooth.getBondedDevices().then((list) => state.devicesList = list);
    emit(state.copyWith(devicesList: state.devicesList));
  }

  void openSetting() {
    state.bluetooth.openSettings();
  }

  Future<void> openChat() async{
    if (state.devicesList!.isNotEmpty){
      for (var deviceItem in state.devicesList!) {
        if (deviceItem.isBonded){
          state.device = deviceItem;
          emit(state.copyWith(device: state.device));
          connectChat(deviceItem);
        }
     }
    }
  }

  void connectChat(BluetoothDevice deviceI) {
    BluetoothConnection.toAddress(deviceI.address).then((connectI) {
      state.connection = connectI;
      state.connection!.input!.listen((event) {
        state.dataStr = utf8.decode(event).trim();
        emit(state.copyWith(dataStr: state.dataStr));
      });
    }).catchError((error) {print('Ошибка: $error');});
  }
  

  // Future<void> _getDirPath() async {
  //   dir = await getApplicationDocumentsDirectory();
  //   myFile = File('${dir.path}/data.txt');
  //   final data = await myFile.readAsString(encoding: utf8);
  //   print(data);
  // }
  // Future<void> _readData() async {
  //   final data = await myFile.readAsString(encoding: utf8);
  //   print(data);
  // }
  // Future<void> _writeData(String text) async {
  //   await myFile.writeAsString(text, mode: FileMode.append);
  // }
    void _sendMessage(String text) async {
    if (text.length > 0) {
      try {
        state.connection!.output.add(Uint8List.fromList(utf8.encode(text.toUpperCase() + "\r\n")));
        await state.connection!.output.allSent;
        // state.messages.add(text);
      } catch (e) {}
    }
  }
}
class BluetoothUser{
  String nameDev;
  String addresDev;
  bool isConnect;
  FlutterBluetoothSerial bluetooth = FlutterBluetoothSerial.instance;
  List<BluetoothDevice>? devicesList = [];
  BluetoothDevice? device;

  BluetoothState bluetoothState;
  BluetoothConnection? connection;
  String dataStr;
  bool get isConnected => (connection?.isConnected ?? false);

  BluetoothUser([
    this.nameDev = '',
    this.addresDev = '',
    this.isConnect = false,
    this.devicesList,
    this.device,
    this.bluetoothState = BluetoothState.UNKNOWN,
    this.connection,
    this.dataStr = '',
  ]);

  BluetoothUser copyWith({
    String? nameDev,
    String? addresDev,
    bool? isConnect,
    FlutterBluetoothSerial? bluetooth,
    List<BluetoothDevice>? devicesList,
    BluetoothDevice? device,
    BluetoothState? bluetoothState,
    BluetoothConnection? connection,
    String? dataStr,    
  }) {
    return BluetoothUser(
      nameDev ?? this.nameDev,
      addresDev ?? this.addresDev,
      isConnect ?? this.isConnect,
      devicesList ?? this.devicesList,
      device ?? this.device,
      bluetoothState ?? this.bluetoothState,
      connection ?? this.connection,
      dataStr ?? this.dataStr,
    );
  }

  @override
  String toString() {
    return '-------> nameDev: $nameDev, addresDev: $addresDev, isConnect: $isConnect, bluetooth: $bluetooth, devicesList: $devicesList, device: $device, bluetoothState: $bluetoothState, connection: $connection, dataStr: $dataStr';
  }

  @override
  bool operator ==(covariant BluetoothUser other) {  
    return
      identical(this, other) ||
      other.nameDev == nameDev &&
      other.addresDev == addresDev &&
      other.isConnect == isConnect &&
      listEquals(other.devicesList, devicesList) &&
      other.device == device &&
      other.bluetoothState == bluetoothState &&
      other.connection == connection &&
      other.dataStr == dataStr ;
  }

  @override
  int get hashCode {
    return nameDev.hashCode ^
      addresDev.hashCode ^
      isConnect.hashCode ^
      devicesList.hashCode ^
      device.hashCode ^
      bluetoothState.hashCode ^
      connection.hashCode ^
      dataStr.hashCode ;
  }
}

class ComandStr {
  final String command;
  final String number;
  ComandStr(this.command, this.number);
}

class ChartElement {
  final List<double> data;
  final String itamTxt;
  final String name;
  final Color color;
  ChartElement(this.data, this.itamTxt, this.name, this.color);
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
            WindowGraph(),
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
    // final cubit = context.read<UserCubit>();
    // final cubit = context.read<ChartCubit>().strimMessage;

    return Container(
      color: const Color.fromRGBO(31, 10, 9, 1),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Flexible(
            child: BlocBuilder<UserCubit, BluetoothUser>(
              builder: (context, state) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextWidget(txt: '${state.nameDev} / ${state.addresDev}'),
                    TextWidget(txt: '${state.bluetoothState}'),
                    // ElevatedButton(onPressed: cubit.openChat, child: Text('Connect'),),
                    state.isConnected ? TextWidget(txt: 'Connect: ${state.device!.name}') : TextWidget(txt: ''),
                    state.isConnected ? TextWidget(txt: 'Message: ${state.dataStr}') : TextWidget(txt: ''),
                  ],
                );
              },
            ),
            flex: 2,
          ),
          Flexible(
            child: GraphsView(),
            flex: 10,
          ),
        ],
      ),
    );
  }
}

class TextWidget extends StatelessWidget {
  final String txt;
  const TextWidget({super.key, required this.txt});

  @override
  Widget build(BuildContext context) {
    return Text(txt, style: const TextStyle(color: Colors.white));
  }
}

class SensorContainer extends StatelessWidget {
  final String name;
  final String data;
  final Color colorData;

  const SensorContainer({
    Key? key,
    required this.name,
    required this.data,
    required this.colorData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorData,
      child: Row(
        children: [
          TextWidget(
            txt: '$name: ',
          ),
          TextWidget(
            txt: data,
          ),
        ],
      ),
    );
  }
}

class GraphsView extends StatelessWidget {
  GraphsView({super.key});
  @override
  Widget build(BuildContext context) {
    return     
    BlocBuilder<ChartCubit, DataChart>(
              builder: (context, state) {
                return SfCartesianChart(
      plotAreaBorderWidth: 0,
      legend: const Legend(
          isVisible: true,
          position: LegendPosition.left,
          textStyle: TextStyle(color: Colors.white)),
      primaryXAxis: NumericAxis(
          majorGridLines: const MajorGridLines(width: 0),
          edgeLabelPlacement: EdgeLabelPlacement.shift),
      primaryYAxis: NumericAxis(
          opposedPosition: true,
          maximum: 100,
          axisLine: const AxisLine(width: 0),
          labelFormat: r'{value}°',
          majorTickLines: const MajorTickLines(size: 0)),
      series: 
      state.chartElement!.map((ChartElement chElement) => LineSeries<double, int>(
                dataSource: chElement.data,
                width: 2,
                xValueMapper: (double sales, i) => i,
                yValueMapper: (double sales, _) => sales,
                color: chElement.color,
                name: chElement.name,
                legendItemText: chElement.itamTxt,
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
        markerSettings: const TrackballMarkerSettings(
          markerVisibility: TrackballVisibilityMode.visible,
          height: 10,
          width: 10,
          borderWidth: 1,
        ),
        hideDelay: 2 * 1000,
        activationMode: ActivationMode.singleTap,
        tooltipDisplayMode: TrackballDisplayMode.floatAllPoints,
        shouldAlwaysShow: true,
      ),
    );
              },
            );
  }
}

class WindowChat extends StatelessWidget {
  WindowChat({super.key});
TextEditingController _nameController = TextEditingController();
//  final ScrollController listScrollController = new ScrollController();
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UserCubit>();
    return SafeArea(
        child: Container(
          color: Color.fromRGBO(31, 10, 9, 1),
          child: Column(
          children: <Widget>[
            FloatingActionButton(
              child: Icon(Icons.pin_end),
              onPressed: () {
                // if (listScrollController.hasClients) {
                //   final position =
                //       listScrollController.position.maxScrollExtent;
                //   listScrollController.animateTo(
                //     position,
                //     duration: Duration(seconds: 2),
                //     curve: Curves.easeOut,
                //   );
                // }
            }),
            // Flexible(
            //   child: ListView.builder(
            //     itemCount: list.length,
            //     itemBuilder: (context, index) => MassageTitle(),
            //       padding: const EdgeInsets.all(12.0),
            //       controller: listScrollController,
            //       children:  list,?
            //       ),
            // ),
            Row(
              children: <Widget>[
                Flexible(
                  child: Container(
                    margin: const EdgeInsets.only(left: 16.0),
                    child: TextField(
                      style: const TextStyle(fontSize: 15.0, color: Colors.white),
                      // controller: _nameController,
                      decoration: InputDecoration.collapsed(
                        hintText: 'Введите сообщение...',
                        hintStyle: const TextStyle(color: Colors.white),
                      ),
                      enabled: cubit.state.isConnected,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(8.0),
                  child: IconButton(
                      icon: const Icon(Icons.send),
                      color: Colors.white,
                      onPressed: cubit.state.isConnected
                          ? () => cubit._sendMessage(_nameController.text)
                          : null),
                ),
              ],
            )
          ],
        ),
        ),
      );
  }
}

// class MassegeList extends StatelessWidget {
// final List<String> messages = List<String>.empty(growable: true);
//   MassegeList({Key? key, required this.messages}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     final cubit = context.read<UserCubit>();
//     final List<Row> list = messages.map((_message) {
//       Row(
//         children: <Widget>[
//           Container(
//             child: TextWidget(txt: _message),
//             padding: EdgeInsets.all(12.0),
//             margin: EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
//             decoration: BoxDecoration(
//                 color: Colors.grey,
//                 borderRadius: BorderRadius.circular(7.0)),
//           ),
//         ],
//         mainAxisAlignment: MainAxisAlignment.start,
//       );
//     }).toList();
//     return ListView(children: list);
//   }
// }