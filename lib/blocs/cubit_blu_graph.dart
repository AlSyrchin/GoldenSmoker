// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

void main() {
  // Bloc.observer = const CounterObserver();
  runApp(const ExampleApplication());
}

class ExampleApplication extends StatelessWidget {
  const ExampleApplication({super.key});

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

// class ChartBlu extends StatefulWidget {
//   const ChartBlu({super.key});
//   @override
//   State<ChartBlu> createState() => _ChartBluState();
// }
// class _ChartBluState extends State<ChartBlu> {
//   // _ChartBluState(){
//   //   timer = Timer.periodic(const Duration(milliseconds: 5000), _updateDataSource);
//   // }
//   Timer? timer;
//   @override
//   Widget build(BuildContext context) {
//     return ViewMain();
//   }
// }

class UserCubit extends Cubit<BluetoothUser> {
  final session = BluetoothUser();

  UserCubit() : super(BluetoothUser()) {
    _initialize();
  }

  Future<void> _initialize() async {
    print('Начало инициализации');
    await _connectBluetooth();
    await _setName();
    await _setAddres();
    await _setStateBluetooth();
    if (session.isConnect) await getListDevices();
    strimStateBluetooth();
    print('Строка: ${session.toString()}');
    emit(state.copyWith(session));
  }

  Future<void> _connectBluetooth() async {
    await session.bluetooth.requestEnable();
  }

  Future<void> _setName() async {
    await session.bluetooth.name.then((name) {
      session.nameDev = name!;
    });
  }

  Future<void> _setAddres() async {
    await session.bluetooth.address.then((address) {
      session.addresDev = address!;
    });
  }

  Future<void> _setStateBluetooth() async {
    await session.bluetooth.state.then((state) => session.bluetoothState = state);
    if (session.bluetoothState.stringValue == 'STATE_ON') session.isConnect = true;
  }

  void strimStateBluetooth() {
    session.bluetooth.onStateChanged().listen((BluetoothState state) {}).onData((data) {
       switch (data.stringValue) {
        case 'STATE_ON': session.isConnect = true; session.bluetoothState = data;emit(state.copyWith(session));
          break;
        case 'STATE_OFF': session.isConnect = false; session.bluetoothState = data;emit(state.copyWith(session));
          break;
          default:
       }});
  }
  
  // void listDevices() async {
  //   var session = state;
  //   await getListDevices();
  //   emit(state.copyWith(session));
  // }

  Future<void> getListDevices() async {
    await session.bluetooth.getBondedDevices().then((list) => session.devicesList = list);
  }

  void openSetting() {
    session.bluetooth.openSettings();
  }

  void openChat(){
    if (session.devicesList!.isNotEmpty){
      for (var device in session.devicesList!) {
        if (device.isBonded){
          session.device = device;
          emit(state.copyWith(session));
          connectChat(device);
        }
    }
    }
  }

  void connectChat(BluetoothDevice _device) {
    BluetoothConnection.toAddress(_device.address).then((connect) {
      session.connection = connect;
      session.connection!.input!.listen(_onDataReceived);
    }).catchError((error) {
      print('Ошибка: $error');
    });
  }
  double funcCom(String command) {
      return int.parse(command.substring(2)) / 10;
    }

  void _onDataReceived(Uint8List data) {
    String dataStr = utf8.decode(data).trim();
    List<String> listTst = dataStr.split('_');
    listTst.removeLast();
    for (var command in listTst) {
      switch (command.substring(0, 2)) {
        case 'TM':
          session.tm = funcCom(command);
          break;
        case 'TW':
          session.tw = funcCom(command);
          break;
        case 'HS':
          session.hs = funcCom(command);
          break;
        case 'KS':
          session.ks = funcCom(command);
          break;
        case 'HD':
          session.hd = funcCom(command);
          break;
        case 'PV':
          session.pv = funcCom(command);
          break;
        case 'ST':
          session.st = funcCom(command);
          break;
        default:
      }
    }
    print('Massege: ${listTst}');
    session.dataStr = dataStr;
    emit(state.copyWith(session));


if (session.st != 0) {
      session.dataTM.add(session.tm);
      session.dataTW.add(session.tw);
      session.dataPV.add(session.pv);
      session.dataST.add(session.st * 10);
      switch (session.st){
        case 1 || 2: session.dataT.add(session.hs);
        break;
        case 3: session.dataT.add(session.ks);
        break;
        case 4: session.dataT.add(session.hd);
        break;
        default:
      }
    } else {
      session.dataST.add(0);
      session.dataTM.add(0);
      session.dataTW.add(0);
      session.dataPV.add(0);
      session.dataT.add(0);
    }  
    emit(state.copyWith(session));
  }

  void _sendMessage(String text) async {
    if (text.length > 0) {
      try {
        session.connection!.output.add(Uint8List.fromList(utf8.encode(text.toUpperCase() + "\r\n")));
        await session.connection!.output.allSent;
        session.messages.add(text);
      } catch (e) {}
    }
  }
}

class BluetoothUser {
  late FlutterBluetoothSerial bluetooth = FlutterBluetoothSerial.instance;
  bool isConnect= false;
  BluetoothDevice? device;

  String nameDev;
  String addresDev;
  BluetoothState bluetoothState;
  List<BluetoothDevice>? devicesList;
  String dataStr;
  // StreamSubscription<BluetoothDiscoveryResult>? discoveryStreamSubscription;  

  BluetoothConnection? connection;
  List<String> messages = List<String>.empty(growable: true);
  late double st;
  late double tm;
  late double tw;
  late double hs;
  late double ks;
  late double hd;
  late double pv;
  bool get isConnected => (connection?.isConnected ?? false);

  List<double> dataTM;
  List<double> dataTW;
  List<double> dataT;
  List<double> dataPV;
  List<double> dataST;

  late List<ChartElement> chartElement = [
    ChartElement(dataTM, 't молока TM', 'TM', Colors.orangeAccent),
    ChartElement(dataTW,'t рубашки TW', 'TW', Colors.blueAccent),
    ChartElement(dataT,'t установл.', 'HS_TS_KS_HD', Colors.greenAccent),
    ChartElement( dataPV,'Нагрев PV', 'PV', Colors.redAccent),
    ChartElement(dataST, 'Этап ST', 'ST', Colors.grey,)
  ];

  BluetoothUser([
    this.nameDev = '',
    this.addresDev = '',
    this.bluetoothState = BluetoothState.UNKNOWN,
    this.devicesList,
    this.isConnect = false,
    this.device,
    this.connection,
    this.dataStr = '',
    this.dataTM = const [0],
    this.dataTW = const [0],
    this.dataT = const [0],
    this.dataPV = const [0],
    this.dataST = const [0],

    // messages,
    // st,tm,tw,hs,ks,hd,pv
    // this.discoveryStreamSubscription,
  ]){
dataTM = [1, 10];
dataTW = [0, 15];
dataT = [10, 45];
dataPV = [25, 34];
dataST = [4, 2];
    st=0;
    tm=0;
    tw=0;
    hs=0;
    ks=0;
    hd=0;
    pv=0;
  }

 
// Future <void> startStrimDevice() async{
//    discoveryStreamSubscription = await bluetooth.startDiscovery().listen((r) {
//       Iterator i = devicesList!.iterator;
//         while (i.moveNext()) {
//           var _device = i.current;
//           if (_device.device == r.device) {
//             _device.rssi = r.rssi;
//           }
//         }
//     });
//   }

  // BluetoothUser copyWith({
  //   FlutterBluetoothSerial? bluetooth,
  //   String? nameDev,
  //   String? addresDev,
  //   List<BluetoothDevice>? devicesList,
  //   StreamSubscription<BluetoothDiscoveryResult>? discoveryStreamSubscription,
  //   bool? isConnect,
  //   BluetoothState? bluetoothState,
  // }) {
  //   return BluetoothUser(
  //     nameDev ?? this.nameDev,
  //     addresDev ?? this.addresDev,
  //     devicesList ?? this.devicesList,
  //     discoveryStreamSubscription ?? this.discoveryStreamSubscription,
  //     isConnect ?? this.isConnect,
  //     bluetoothState ?? this.bluetoothState,
  //   );
  // }

  BluetoothUser copyWith(BluetoothUser isOld) {
    return BluetoothUser(
      isOld.nameDev ?? this.nameDev,
      isOld.addresDev ?? this.addresDev,
      isOld.bluetoothState ?? this.bluetoothState,
      isOld.devicesList ?? this.devicesList,
      isOld.isConnect ?? this.isConnect,
      isOld.device ?? this.device,
      isOld.connection ?? this.connection,
      isOld.dataStr ?? this.dataStr,
      isOld.dataTM ?? this.dataTM,
      isOld.dataTW ?? this.dataTW,
      isOld.dataT ?? this.dataT,
      isOld.dataPV ?? this.dataPV,
      isOld.dataST ?? this.dataST

      // isOld.messages ?? this.messages,
      // isOld.st ?? this.st,
      // isOld.tm ?? this.tm,
      // isOld.tw ?? this.tw,
      // isOld.hs ?? this.hs,
      // isOld.ks ?? this.ks,
      // isOld.hd ?? this.hd,
      // isOld.pv ?? this.pv,
      // isOld.discoveryStreamSubscription ?? this.discoveryStreamSubscription,
    );
  }

  @override
  String toString() {
    return 'BluetoothUser(bluetooth: $bluetooth, nameDev: $nameDev, addresDev: $addresDev, _devicesList: $devicesList, isConnect: $isConnect, _bluetoothState: $bluetoothState)';
  }

  @override
  bool operator ==(covariant BluetoothUser other) {
    if (identical(this, other)) return true;

    return
        // other.bluetooth == bluetooth &&
        // other.nameDev == nameDev &&
        // other.addresDev == addresDev &&
        // listEquals(other.devicesList, devicesList) &&
        // other.discoveryStreamSubscription == discoveryStreamSubscription &&
        // other.isConnect == isConnect &&
        other.bluetoothState == bluetoothState &&
        other.devicesList == devicesList &&
        other.device == device &&
         other.dataStr == other &&
         other.dataTM == dataTM &&
         other.dataTW == dataTW &&
         other.dataST == dataST;
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
  TabController({super.key});

  static const List<Widget> tabs = [
    Tab(icon: Icon(Icons.home)),
    // Tab(icon: Icon(Icons.graphic_eq)),
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
            // WindowChat(),
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
      color: Color.fromRGBO(31, 10, 9, 1),
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
          //     children: cubit.chartElement.map((e) => SensorContainer(name: e.name, data: e.data.last.toString(), colorData: e.color)).toList()
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
    return Text(txt, style: TextStyle(color: Colors.white));
  }
}

// class WindowChat extends StatelessWidget {
//   const WindowChat({super.key});
// TextEditingController _nameController = TextEditingController();
//  final ScrollController listScrollController = new ScrollController();
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Container(
//           color: Color.fromRGBO(31, 10, 9, 1),
//           child: Column(
//           children: <Widget>[
//             FloatingActionButton(
//               child: Icon(Icons.pin_end),
//               onPressed: () {
//                 if (listScrollController.hasClients) {
//                   final position =
//                       listScrollController.position.maxScrollExtent;
//                   listScrollController.animateTo(
//                     position,
//                     duration: Duration(seconds: 2),
//                     curve: Curves.easeOut,
//                   );
//                 }
//             }),
//             Flexible(
//               child: ListView(
//                   padding: const EdgeInsets.all(12.0),
//                   controller: listScrollController,
//                   children: list,
//                   ),
//             ),
//             Row(
//               children: <Widget>[
//                 Flexible(
//                   child: Container(
//                     margin: const EdgeInsets.only(left: 16.0),
//                     child: TextField(
//                       style: const TextStyle(fontSize: 15.0, color: Colors.white),
//                       controller: _nameController,
//                       decoration: InputDecoration.collapsed(
//                         hintText: 'Введите сообщение...',
//                         hintStyle: const TextStyle(color: Colors.white),
//                       ),
//                       enabled: isConnected,
//                     ),
//                   ),
//                 ),
//                 Container(
//                   margin: const EdgeInsets.all(8.0),
//                   child: IconButton(
//                       icon: const Icon(Icons.send),
//                       color: Colors.white,
//                       onPressed: isConnected
//                           ? () => _sendMessage(_nameController.text)
//                           : null),
//                 ),
//               ],
//             )
//           ],
//         ),
//         ),
//       );
//   }
// }

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

  
// final List<LineSeries<double, int>> series = <LineSeries<double, int>>[
//       LineSeries<double, int>(
//         dataSource: chartElement[0].data,
//         width: 2,
//         xValueMapper: (double sales, i) => i,
//         yValueMapper: (double sales, _) => sales,
//         color: chartElement[0].color,
//         name: chartElement[0].name,
//         legendItemText: chartElement[0].itamTxt,
//       ),
//       LineSeries<double, int>(
//         dataSource: chartElement[1].data,
//         width: 2,
//         xValueMapper: (double sales, i) => i,
//         yValueMapper: (double sales, _) => sales,
//         color: chartElement[1].color,
//         name: chartElement[1].name,
//         legendItemText: chartElement[1].itamTxt,
//       ),
//       LineSeries<double, int>(
//         dataSource: chartElement[2].data,
//         width: 2,
//         xValueMapper: (double sales, i) => i,
//         yValueMapper: (double sales, _) => sales,
//         color: chartElement[2].color,
//         name: chartElement[2].name,
//         legendItemText: chartElement[2].itamTxt,
//       ),
//       LineSeries<double, int>(
//         dataSource: chartElement[3].data,
//         width: 2,
//         xValueMapper: (double sales, i) => i,
//         yValueMapper: (double sales, _) => sales,
//         color: chartElement[3].color,
//         name: chartElement[3].name,
//         legendItemText: chartElement[3].itamTxt,
//       ),
//       LineSeries<double, int>(
//         dataSource: chartElement[4].data,
//         width: 1,
//         xValueMapper: (double sales, i) => i,
//         yValueMapper: (double sales, _) => sales,
//         color: chartElement[4].color,
//         name: chartElement[4].name,
//         legendItemText: chartElement[4].itamTxt,
//         dashArray: const [6, 6],
//       ),
//     ];

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UserCubit>();
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
      series: cubit.state.chartElement
          .map((ChartElement chElement) => LineSeries<double, int>(
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
  }
}

// class MassegeList extends StatelessWidget {
//   final clientID = 0;
// final List<String> messages = List<String>.empty(growable: true);
//   MassegeList({
//     Key? key,
//     required this.messages,
//   }) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     final List<Row> list = messages.map((_message) {
//       Row(
//         children: <Widget>[
//           Container(
//             child: TextWidget(txt: _message.text.trim(),),
//             padding: EdgeInsets.all(12.0),
//             margin: EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
//             decoration: BoxDecoration(
//                 color:
//                     _message.whom == clientID ? Colors.blueAccent : Colors.grey,
//                 borderRadius: BorderRadius.circular(7.0)),
//           ),
//         ],
//         mainAxisAlignment: _message.whom == clientID
//             ? MainAxisAlignment.end
//             : MainAxisAlignment.start,
//       );
//     }).toList();
//     return ListView(children: list);
//   }
// }

// class BluetoothModel {
//   List<String> messages = List<String>.empty(growable: true);
//   late BluetoothDevice device;
//   late CharUser chat;
//   BluetoothModel();
//   BluetoothUser blut = BluetoothUser();
//   void startModel() {
//     if (blut.isConnect) {
//       blut.getListDevices();
//       device = blut.devicesList!.first;
//     }
//     //  chat = CharUser(device);
//     //  if (chat.isConnected) chat.connectChat();
//   }
// //  void _updateDataSource(Timer timer) {
// //     setState(() {
// //  if (st!=0 && isConnected) {
// //     dataTM.add(tm);
// //     dataTW.add(tw);
// //     if (st == 1 || st == 2) dataT.add(hs);
// //     if (st == 3) dataT.add(ks);
// //     if (st == 4) dataT.add(hd);
// //     dataPV.add(pv);
// //     dataST.add(st*10);
// //  }
// //     });
// //   }
// }

class CounterObserver extends BlocObserver {
  const CounterObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    print('${bloc.runtimeType} $change');
  }
}


