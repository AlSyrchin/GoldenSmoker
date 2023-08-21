// import 'package:flutter/material.dart';
// import 'package:goldensmoker/usb_connect/usb.dart';
// // import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
// // import 'package:flutter_blue/flutter_blue.dart';

// const colorDark = Color.fromRGBO(31, 10, 9, 1);
// const colorOrangeLite = Color.fromRGBO(253, 212, 67, 1);
// const colorOrangeHieg = Color.fromRGBO(239, 157, 26, 1);

// void main() {
//   runApp(MyApp());  
// }

// class App extends StatefulWidget {
//   const App({super.key});

//   @override
//   State<App> createState() => _AppState();
// }

// class _AppState extends State<App> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData.light(),
//       home: Scaffold(
//         backgroundColor: colorDark,
//         body: Center(
//           child: Container(
//               child: Row(
//             mainAxisSize: MainAxisSize.max,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               ContainerBorderRadius(borderRad: 26),
//               SizedBox(
//                 width: 20,
//               ),
//               ContainerBorderRadius(borderRad: 26),
//             ],
//           )),
//         ),
//       ),
//     );
//   }
// }

// class GradientDecorate extends BoxDecoration {
//   final Color color1;
//   final Color color2;
//   final double radius;
//   GradientDecorate(this.color1, this.color2, this.radius) {
//     BoxDecoration(
//         gradient: LinearGradient(colors: [
//           color1,
//           color2,
//         ], begin: Alignment.topLeft, end: Alignment.bottomRight),
//         borderRadius: BorderRadius.all(Radius.circular(radius)));
//   }
// }

// class ContainerBorderRadius extends StatelessWidget {
//   final double borderRad;
//   const ContainerBorderRadius({super.key, required this.borderRad});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 351,
//       height: 488,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.all(Radius.circular(borderRad)),
//         color: Colors.white,
//       ),
//       child: const Padding(
//         padding: EdgeInsets.all(10),
//         child: Column(children: [
//           Icon(Icons.book),
//           Text('Готовить по рецепту'),
//           Text('Выберите рецепт')
//         ]),
//       ),
//     );
//   }
// }


import 'dart:convert';
import 'dart:math';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

void main() => runApp(new ExampleApplication());

class ExampleApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: ChartBlu());
  }
}

class ChartBlu extends StatefulWidget {
  const ChartBlu({super.key});

  @override
  State<ChartBlu> createState() => _ChartBluState();
}

class _ChartBluState extends State<ChartBlu> {

  _ChartBluState(){
    timer = Timer.periodic(const Duration(milliseconds: 5000), _updateDataSource);
  }


// Получите экземпляр bluetooth
  FlutterBluetoothSerial bluetooth = FlutterBluetoothSerial.instance;

  // Определите некоторые переменные, которые потребуются позже
  List<BluetoothDevice> _devicesList = [];
  BluetoothDevice? _device;
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;
  String _nameDev = '';
  String _addresDev = '';
  StreamSubscription<BluetoothDiscoveryResult>? _discoveryStreamSubscription;
  bool _isDiscovering = true;

  Timer? _discoverableTimeoutTimer;
  int _discoverableTimeoutSecondsLeft = 0;

  BluetoothConnection? connection;
  bool isConnecting = true;
  bool get isConnected => (connection?.isConnected ?? false);
  bool isDisconnecting = false;

TextEditingController _nameController = TextEditingController();
 final ScrollController listScrollController = new ScrollController();
List<_Message> messages = List<_Message>.empty(growable: true);
String _messageBuffer = '';
  static final clientID = 0;


int st= 0;
int tm=0, tw=0, hs=0, ks=0, hd=0, pv=0;


// Переменные
  ChartSeriesController? _chartSeriesController;
  static List<GrData> dataTM = [];
  static List<GrData> dataTW = [];
  static List<GrData> dataT = [];
  static List<GrData> dataPV = [];
  static List<GrData> dataST = [];

  List<ChartElement> chartElement = [
    ChartElement(dataTM, 't молока TM', 'TM', Colors.orangeAccent),
    ChartElement(dataTW, 't рубашки TW', 'TW', Colors.blueAccent),
    ChartElement(dataT, 't установл.', 'HS_TS_KS_HD', Colors.greenAccent),
    ChartElement(dataPV, 'Нагрев PV', 'PV', Colors.redAccent),
    ChartElement(dataST, 'Этап ST','ST', Colors.grey,),
  ];

  List<LineSeries<GrData, int>>? series;
  Timer? timer;




// Инициализация начального состояния
  @override
  void initState() {
    super.initState();
    series = <LineSeries<GrData, int>>[
      LineSeries<GrData, int>(
        dataSource: chartElement[0].data,
        width: 2,
        xValueMapper: (GrData sales, i) => i,
        yValueMapper: (GrData sales, _) => sales.gradys,
        color: chartElement[0].color,
        name: chartElement[0].name,
        legendItemText: chartElement[0].itamTxt,
      ),
      LineSeries<GrData, int>(
        dataSource: chartElement[1].data,
        width: 2,
        xValueMapper: (GrData sales, i) => i,
        yValueMapper: (GrData sales, _) => sales.gradys,
        color: chartElement[1].color,
        name: chartElement[1].name,
        legendItemText: chartElement[1].itamTxt,
      ),
      LineSeries<GrData, int>(
        dataSource: chartElement[2].data,
        width: 2,
        xValueMapper: (GrData sales, i) => i,
        yValueMapper: (GrData sales, _) => sales.gradys,
        color: chartElement[2].color,
        name: chartElement[2].name,
        legendItemText: chartElement[2].itamTxt,
      ),
      LineSeries<GrData, int>(
        dataSource: chartElement[3].data,
        width: 2,
        xValueMapper: (GrData sales, i) => i,
        yValueMapper: (GrData sales, _) => sales.gradys,
        color: chartElement[3].color,
        name: chartElement[3].name,
        legendItemText: chartElement[3].itamTxt,
      ),
      LineSeries<GrData, int>(
        dataSource: chartElement[4].data,
        width: 1,
        xValueMapper: (GrData sales, i) => i,
        yValueMapper: (GrData sales, _) => sales.gradys,
        color: chartElement[4].color,
        name: chartElement[4].name,
        legendItemText: chartElement[4].itamTxt,
        dashArray: const <double>[6, 6],
      ),
    ];

// Подключение блютуса при запуске приложения
    bluetooth.requestEnable();
// Получить текущее состояние
    bluetooth.state.then((state) => _bluetoothState = state);
// Получить адрес
    Future.doWhile(() async {
      // Подождите, если адаптер не включен
      if ((await bluetooth.isEnabled) ?? false) {
        return false;
      }
      await Future.delayed(Duration(milliseconds: 0xDD));
      return true;
    }).then((_) {
      bluetooth.address.then((address) {
        setState(() {
          _addresDev = address!;
        });
      });
    });
// Получить имя
    bluetooth.name.then((name) => _nameDev = name!);

    getListDevices();
  }

///////////////////////////////////////////////////
/////////////////////////////////////////////////// Блок функций
///////////////////////////////////////////////////

// Открытие настроек если нужно
  void openSetting() {
    bluetooth.openSettings();
  }

//Запуск Strim для просмотра состояния Bluetooth
  void strimStateBluetooth() {
    bluetooth.onStateChanged().listen((BluetoothState state) {
      setState(() {
        _bluetoothState = state;
        _discoverableTimeoutTimer = null;
        _discoverableTimeoutSecondsLeft = 0;
      });
      print(
          '.....................................................Запустился Strim');
    });
  }

// Возвращает список связанных устройств. // Нужно ли настраивать список и получать не все данные????
  void getListDevices() {
    bluetooth.getBondedDevices().then((List<BluetoothDevice> bondedDevices) {
      _devicesList = bondedDevices.map((device) => device).toList();

      _device = _devicesList.first;
      connectChat();
    });
  }

// Запускает обнаружение и предоставляет поток `BluetoothDiscoveryResult`s.
  void _startDiscovery() {
    _discoveryStreamSubscription = bluetooth.startDiscovery().listen((r) {
      setState(() {
//Интерфейс для получения элементов по одному из объекта
        Iterator i = _devicesList.iterator;
        while (i.moveNext()) {
          var _device = i.current;
          if (_device.device == r.device) {
            _device.rssi = r.rssi;
          }
        }
      });
      print(
          '...................................................Завершилось обнаружение');
    });
  }

// Прекращение стрима устройств
  void desconnectStrim() {
    _discoveryStreamSubscription?.onDone(() {
      _isDiscovering = false;
    });
  }

  void connectChat () {
    BluetoothConnection.toAddress(_device?.address).then((_connection) { //'F0:08:D1:D3:F6:FE'
      print('Подключено');
      connection = _connection;
      connection!.input!.listen(_onDataReceived);
    }).catchError((error) {
      print('Cannot connect, exception occured');
      print(error);
    });
  }

  void _onDataReceived(Uint8List data) {
    String dataStr = ascii.decode(data);
    List<String> listTst = dataStr.split('_');
    
    for (int i=0; i< listTst.length; i++) {
      switch (listTst[i].substring(0,2)) {
        case 'TM': tm = int.parse(listTst[i].substring(2,listTst[i].length-1));
          break;
        case 'TW': tw = int.parse(listTst[i].substring(2,listTst[i].length-1));
          break;
        case 'HS': hs = int.parse(listTst[i].substring(2,listTst[i].length-1));
          break;
        case 'KS': ks = int.parse(listTst[i].substring(2,listTst[i].length-1));
          break;
        case 'HD': hd = int.parse(listTst[i].substring(2,listTst[i].length-1));
          break;
        case 'PV': pv = int.parse(listTst[i].substring(2,listTst[i].length));
          break;
        case 'ST': st = int.parse(listTst[i].substring(2, listTst[i].length));
          break;
        default: print("None");
      }
    }

    setState(() {
      if (messages.length >= 100) {
        messages.removeAt(0);
        messages.add(_Message(1, dataStr));
      } else
        messages.add(_Message(1, dataStr));
    });
    print('Massege: ${listTst}');
  }

  void _sendMessage(String text) async {
    if (text.length > 0) {
      try {
        connection!.output.add(Uint8List.fromList(utf8.encode(text.toUpperCase() + "\r\n")));
        await connection!.output.allSent;

        setState(() {
          if (messages.length >= 100) {
            messages.removeAt(0);
            messages.add(_Message(clientID, text));
          } else
            messages.add(_Message(clientID, text));
        });

        Future.delayed(Duration(milliseconds: 333)).then((_) {
          listScrollController.animateTo(
              listScrollController.position.maxScrollExtent,
              duration: Duration(milliseconds: 333),
              curve: Curves.easeOut);
        });
      }catch (e) {
        // Игнорировать ошибку, но уведомлять о состоянии
        setState(() {});
      }
  }
  }
///////////////////////////////////////////////////
/////////////////////////////////////////////////// окончание блока функций
///////////////////////////////////////////////////

  @override
  void dispose() {
    bluetooth.setPairingRequestHandler(null);
    // Избегайте утечки памяти (`setState` после dispose) и отмените обнаружение
    _discoveryStreamSubscription?.cancel();
    _discoverableTimeoutTimer?.cancel();

    // Избегайте утечки памяти (`setState` после dispose) и отключите
    if (isConnected) {
      isDisconnecting = true;
      connection?.dispose();
      connection = null;
    }


    timer?.cancel();
    series!.clear();
    _chartSeriesController = null;

    super.dispose();
  }

///////////////////////////////////////////////////
/////////////////////////////////////////////////// Начало блока интерфейса
///////////////////////////////////////////////////

  ListView listTitleDev(List<BluetoothDevice> listDev) {
    return ListView(
        children: listDev
            .map((_device) => ListTile(
                  key: UniqueKey(),
                  title: Text(_device.name ?? ''),
                  subtitle: Text(_device.address.toString()),
                ))
            .toList());
  }

  Expanded getContaner(){
    return  Expanded(child: getAddRemoveSeriesChart(),);
  }

    SfCartesianChart getAddRemoveSeriesChart() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      legend: Legend(
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
      series: series,
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
        markerSettings: TrackballMarkerSettings(
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


 void _updateDataSource(Timer timer) {
    setState(() {

 if (st!=0 && isConnecting) {
    dataTM.add(GrData(tm));
    dataTW.add(GrData(tw));
    if (st == 1 || st == 2) dataT.add(GrData(hs));
    if (st == 3) dataT.add(GrData(ks));
    if (st == 4) dataT.add(GrData(hd));
    dataPV.add(GrData(pv));
    dataST.add(GrData(st*10));
 }
    });
  }

List<Widget> tabs = [
      Tab(icon: Icon(Icons.home)),
      Tab(icon: Icon(Icons.graphic_eq)),
    ];

///////////////////////////////////////////////////
/////////////////////////////////////////////////// Начало блока интерфейса
///////////////////////////////////////////////////


Widget window1 (){
 return Container(
          color: Color.fromRGBO(31, 10, 9, 1),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Center(child: Text('${_nameDev} / ${_addresDev} / ${_bluetoothState}',style: TextStyle(color: Colors.white)),),
              Center(child: _devicesList.isNotEmpty ? Text('Connect: ${_device!.name!}', style: TextStyle(color: Colors.white),) : Text('Error', style: TextStyle(color: Colors.white)),),
              getContaner(),
            ],
          ),
        );
}


  @override
  Widget build(BuildContext context) {

final List<Row> list = messages.map((_message) {
      return Row(
        children: <Widget>[
          Container(
            child: Text(
                (text) {
                  return text == '/shrug' ? '¯\\_(ツ)_/¯' : text;
                }(_message.text.trim()),
                style: TextStyle(color: Colors.white)),
            padding: EdgeInsets.all(12.0),
            margin: EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
            
            decoration: BoxDecoration(
                color:
                    _message.whom == clientID ? Colors.blueAccent : Colors.grey,
                borderRadius: BorderRadius.circular(7.0)),
          ),
        ],
        mainAxisAlignment: _message.whom == clientID
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
      );
    }).toList();


Widget window2 (){
  return SafeArea(
        child: Container(
          color: Color.fromRGBO(31, 10, 9, 1),
          child: Column(
          children: <Widget>[
            FloatingActionButton(
              child: Icon(Icons.pin_end),
              onPressed: () {
                if (listScrollController.hasClients) {
                  final position =
                      listScrollController.position.maxScrollExtent;
                  listScrollController.animateTo(
                    position,
                    duration: Duration(seconds: 2),
                    curve: Curves.easeOut,
                  );
                }
            }),
            Flexible(
              child: ListView(
                  padding: const EdgeInsets.all(12.0),
                  controller: listScrollController,
                  children: list,
                  ),
            ),
            Row(
              children: <Widget>[
                Flexible(
                  child: Container(
                    margin: const EdgeInsets.only(left: 16.0),
                    child: TextField(
                      style: const TextStyle(fontSize: 15.0, color: Colors.white),
                      controller: _nameController,
                      decoration: InputDecoration.collapsed(
                        hintText: 'Введите сообщение...',
                        hintStyle: const TextStyle(color: Colors.white),
                      ),
                      enabled: isConnected,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(8.0),
                  child: IconButton(
                      icon: const Icon(Icons.send),
                      color: Colors.white,
                      onPressed: isConnected
                          ? () => _sendMessage(_nameController.text)
                          : null),
                ),
              ],
            )
          ],
        ),
        ),
      );
}

  //////////////////////////////////////////////////////////////


    return MaterialApp(
        home: DefaultTabController(
          initialIndex: 0,
          length: 2,
          child: Scaffold(
            bottomNavigationBar: BottomAppBar(
                child: Container(
                  color: Color.fromRGBO(31, 10, 9, 1),
              height: 50,
              child: TabBar(
                labelColor: Colors.amber,
                indicatorColor: Colors.amber,
                tabs: tabs.map((Widget el) => el).toList(),
              ),
            )),
            body: TabBarView(
              children: [
                window1(),
                window2(),
              ],
            )),
        ),
            );
  }
}

class ComandStr {
  final String command;
  final String number;

  ComandStr(this.command, this.number);
}

class GrData {
  final int gradys;
  GrData(this.gradys);
}

class ChartElement {
  final List<GrData> data;
  final String itamTxt;
  final String name;
  final Color color;
  ChartElement(this.data, this.itamTxt, this.name, this.color);
}

class _Message {
  int whom;
  String text;

  _Message(this.whom, this.text);
}

