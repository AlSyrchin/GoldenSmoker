import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'dart:io';
import 'package:path_provider/path_provider.dart';

import 'package:flutter/services.dart';

void main() {
  runApp(ExampleApplication());
}

class ExampleApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Provider<UserCubit>(
      create: (_) => UserCubit(),
      child: TabController(),
      dispose: (context, value) => value.close(),
    ),
    );
  }
}

class UserCubit extends Cubit<BluetoothUser> {
  late Directory dir;
  late File myFile;
  double tm=0,tw=0,hs=0,ks=0,hd=0,pv=0,st=0,t=0;
  UserCubit() : super(BluetoothUser()) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    _initialize();
    _getDirPath();
    // Timer timer = Timer.periodic(const Duration(seconds: 5),(_){});
    // _readData();
  }
  
  Future<void> _initialize() async {
    await _connectBluetooth();
    await _setName();
    await _setAddres();
    await _setStateBluetooth();
    emit(state.copyWith(nameDev: state.nameDev, addresDev: state.addresDev, bluetoothState: state.bluetoothState, isConnect: state.isConnect));
    if (state.isConnect) await getListDevices();
    strimStateBluetooth();
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

  void connectChat(BluetoothDevice _device) {
    BluetoothConnection.toAddress(_device.address).then((_connect) {
      state.connection = _connect;
      state.connection!.input!.listen( _onDataReceived);
    }).catchError((error) {
      print('Ошибка: $error');
    });
  }
  double funcCom(String command) {
      return int.parse(command.substring(2)) / 10;
    }

  // void _timerOnData(Uint8List data) {
  //   Timer.periodic(const Duration(seconds: 5), ((_) => _onDataReceived(data)));
  // }

  void _onDataReceived(Uint8List data) {
    
    String dataStr = utf8.decode(data).trim();
    List<String> listTst = dataStr.split('_');
    listTst.removeLast();
    if (listTst.isEmpty) return;
    for (var command in listTst) {
      switch (command.substring(0, 2)) {
        case 'TM':
          tm = funcCom(command);
          break;
        case 'TW':
          tw = funcCom(command);
          break;
        case 'HS':
          hs = funcCom(command);
          break;
        case 'KS':
          ks = funcCom(command);
          break;
        case 'HD':
          hd = funcCom(command);
          break;
        case 'PV':
          pv = funcCom(command);
          break;
        case 'ST':
          st = funcCom(command) * 10;
          break;
        default:
      }
    }
        switch (st){
          case 0: st=0;tm=0;tw=0;pv=0;t=0;
          break;
          case 1 || 2: t=hs;
          break;
          case 3: t=ks;
          break;
          case 4: t=hd;
          break;
          default:
        }
      // _writeData('${tm}_${tw}_${t}_${pv}_${st}!');
      final newState = state.copyWith(dataTM: [...state.dataTM, tm], dataST: [...state.dataST, st],  dataPV: [...state.dataPV, pv], dataTW: [...state.dataTW, tw], dataT: [...state.dataT, t], dataStr: dataStr, messageList: [...state.messageList, dataStr]);
      emit(newState);
      print(state.toString());
    }

  Future<void> _getDirPath() async {
    dir = await getApplicationDocumentsDirectory();
    myFile = File('${dir.path}/data.txt');

    final data = await myFile.readAsString(encoding: utf8);
    print(data);
  }

  Future<void> _readData() async {
    final data = await myFile.readAsString(encoding: utf8);
    print(data);
  }

  Future<void> _writeData(String text) async {
    await myFile.writeAsString(text, mode: FileMode.append);
  }
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
  final List<double> dataTM;
  final List<double> dataTW;
  final List<double> dataT;
  final List<double> dataPV;
  final List<double> dataST;
  bool get isConnected => (connection?.isConnected ?? false);
  List<ChartElement>? chartElement;
  List<String> messageList = ['start'];

  BluetoothUser([
    this.nameDev = '',
    this.addresDev = '',
    this.isConnect = false,
    this.devicesList,
    this.device,
    this.bluetoothState = BluetoothState.UNKNOWN,
    this.connection,
    this.dataStr = '',
    this.dataTM = const <double>[] ,
    this.dataTW = const <double>[],
    this.dataT = const <double>[],
    this.dataPV = const <double>[],
    this.dataST = const <double>[],
    this.chartElement,
    this.messageList = const<String>[]
  ]){
    chartElement = [
          ChartElement(dataTM, 't молока TM', 'TM', Colors.orangeAccent),
          ChartElement(dataTW,'t рубашки TW', 'TW', Colors.blueAccent),
          ChartElement(dataT,'t установл.', 'HS_TS_KS_HD', Colors.greenAccent),
          ChartElement(dataPV,'Нагрев PV', 'PV', Colors.redAccent),
          ChartElement(dataST, 'Этап ST', 'ST', Colors.grey,)
    ];
    // messageList = [...messageList, dataStr];
  }

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
    List<double>? dataTM,
    List<double>? dataTW,
    List<double>? dataT,
    List<double>? dataPV,
    List<double>? dataST,
    List<String>? messageList
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
      dataTM ?? this.dataTM,
      dataTW ?? this.dataTW,
      dataT ?? this.dataT,
      dataPV ?? this.dataPV,
      dataST ?? this.dataST,
      chartElement ?? this.chartElement,
      messageList ?? this.messageList,
    );
  }

  @override
  String toString() {
    return '------->(nameDev: $nameDev, addresDev: $addresDev, isConnect: $isConnect, bluetooth: $bluetooth, devicesList: $devicesList, device: $device, bluetoothState: $bluetoothState, connection: $connection, dataStr: $dataStr, dataTM: $dataTM, dataTW: $dataTW)';
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
      other.dataStr == dataStr &&
      listEquals(other.dataTM, dataTM) &&
      listEquals(other.dataTW, dataTW) &&
      listEquals(other.dataT, dataT) &&
      listEquals(other.dataPV, dataPV) &&
      listEquals(other.dataST, dataST) &&
      listEquals(other.messageList, messageList);
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
      dataStr.hashCode ^
      dataTM.hashCode ^
      dataTW.hashCode ^
      dataT.hashCode ^
      dataPV.hashCode ^
      dataST.hashCode ^
      messageList.hashCode;
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
    final cubit = context.read<UserCubit>();

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
                    ElevatedButton(onPressed: cubit.openChat, child: Text('Connect'),),
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


          // Flexible(
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceAround,
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     children: cubit.state.chartElement!.map((e) => SensorContainer(name: e.name, data: e.data.last.toString(), colorData: e.color)).toList()
          //     ),
          //   flex: 2,
          // ),


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
    BlocBuilder<UserCubit, BluetoothUser>(
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
    final List<Row> list = cubit.state.messageList.map((e) => Row(children: [
          Container(
            child: TextWidget(txt: e),
            padding: EdgeInsets.all(12.0),
            margin: EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(7.0)),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.start,
        )).toList();
    // return ListView(children: list);

    // final cubit = context.read<UserCubit>();
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
            Flexible(
              child: ListView(
                  padding: const EdgeInsets.all(12.0),
                  // controller: listScrollController,
                  children: list ,
                  ),
            ),
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
// List<String> messages = List<String>.empty(growable: true);
//   MassegeList({Key? key, required this.messages}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     final cubit = context.read<UserCubit>();
//     final List<Row> list = cubit.state.messageList.map((e) => Row(children: [
//           Container(
//             child: TextWidget(txt: e),
//             padding: EdgeInsets.all(12.0),
//             margin: EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
//             decoration: BoxDecoration(
//                 color: Colors.grey,
//                 borderRadius: BorderRadius.circular(7.0)),
//           ),
//         ],
//         mainAxisAlignment: MainAxisAlignment.start,
//         )).toList();
//     return ListView(children: list);
//   }
// }