import 'dart:convert';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'dart:async';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
// import 'package:path_provider/path_provider.dart' as pathProvider;
// import 'dart:io';


void main() => runApp(new ExampleApplication());

class ExampleApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChartBlu(),
      );
  }
}

class ChartBlu extends StatefulWidget {
  const ChartBlu({super.key}); 

  @override
  State<ChartBlu> createState() => _ChartBluState();
}

class _ChartBluState extends State<ChartBlu> {

  _ChartBluState(){
    timer = Timer.periodic(const Duration(milliseconds: 1000), _updateDataSource);
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
  bool isDiscovering = true;

  Timer? _discoverableTimeoutTimer;
  int discoverableTimeoutSecondsLeft = 0;

  BluetoothConnection? connection;
  bool isConnecting = true;
  bool get isConnected => (connection?.isConnected ?? false);
  bool isDisconnecting = false;

TextEditingController _nameController = TextEditingController();
 final ScrollController listScrollController = new ScrollController();
List<_Message> messages = List<_Message>.empty(growable: true);
// String _messageBuffer = '';
  static final clientID = 0;


double st= 0;
double tm=0, tw=0, hs=0, ks=0, hd=0, pv=0;


// Переменные
  ChartSeriesController? chartSeriesController;
  static List<double> dataTM = [0];
  static List<double> dataTW = [0];
  static List<double> dataT = [0];
  static List<double> dataPV = [0];
  static List<double> dataST = [0];

  List<ChartElement> chartElement = [
    ChartElement(dataTM, 't молока TM', 'TM', Colors.orangeAccent),
    ChartElement(dataTW, 't рубашки TW', 'TW', Colors.blueAccent),
    ChartElement(dataT, 't установл.', 'HS_TS_KS_HD', Colors.greenAccent),
    ChartElement(dataPV, 'Нагрев PV', 'PV', Colors.redAccent),
    ChartElement(dataST, 'Этап ST','ST', Colors.grey,),
  ];

  List<LineSeries<double, int>>? series;
  Timer? timer;

var directiry, file, isExist;


// Инициализация начального состояния
  @override
  void initState() {
    super.initState();


// startFile();





    series = <LineSeries<double, int>>[
      LineSeries<double, int>(
        dataSource: chartElement[0].data,
        width: 2,
        xValueMapper: (double sales, i) => i,
        yValueMapper: (double sales, _) => sales,
        color: chartElement[0].color,
        name: chartElement[0].name,
        legendItemText: chartElement[0].itamTxt,
      ),
      LineSeries<double, int>(
        dataSource: chartElement[1].data,
        width: 2,
        xValueMapper: (double sales, i) => i,
        yValueMapper: (double sales, _) => sales,
        color: chartElement[1].color,
        name: chartElement[1].name,
        legendItemText: chartElement[1].itamTxt,
      ),
      LineSeries<double, int>(
        dataSource: chartElement[2].data,
        width: 2,
        xValueMapper: (double sales, i) => i,
        yValueMapper: (double sales, _) => sales,
        color: chartElement[2].color,
        name: chartElement[2].name,
        legendItemText: chartElement[2].itamTxt,
      ),
      LineSeries<double, int>(
        dataSource: chartElement[3].data,
        width: 2,
        xValueMapper: (double sales, i) => i,
        yValueMapper: (double sales, _) => sales,
        color: chartElement[3].color,
        name: chartElement[3].name,
        legendItemText: chartElement[3].itamTxt,
      ),
      LineSeries<double, int>(
        dataSource: chartElement[4].data,
        width: 1,
        xValueMapper: (double sales, i) => i,
        yValueMapper: (double sales, _) => sales,
        color: chartElement[4].color,
        name: chartElement[4].name,
        legendItemText: chartElement[4].itamTxt,
        dashArray: const [6, 6],
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
        discoverableTimeoutSecondsLeft = 0;
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
      isDiscovering = false;
    });
  }

  void connectChat () {
    BluetoothConnection.toAddress(_device?.address).then((_connection) {
      print('Подключено');
      connection = _connection;
      connection!.input!.listen(_onDataReceived);
    }).catchError((error) {
      print('Cannot connect, exception occured');
      print(error);
    });
  }

double funcCom(String command){
  return int.parse(command.substring(2))/10;
}

  void _onDataReceived(Uint8List data) {
    String dataStr = utf8.decode(data).trim();
    List<String> listTst = dataStr.split('_');
    listTst.removeLast();
    for (var command in listTst) {
      switch (command.substring(0,2)) {
        case 'TM': tm = funcCom(command);//writeFile(tm);
          break;
        case 'TW': tw = funcCom(command);//writeFile(tw);
          break;
        case 'HS': hs = funcCom(command);//writeFile(hs);
          break;
        case 'KS': ks = funcCom(command);//writeFile(ks);
          break;
        case 'HD': hd = funcCom(command);//writeFile(hd);
          break;
        case 'PV': pv = funcCom(command);//writeFile(pv);
          break;
        case 'ST': st = funcCom(command);//writeFile(st);
          break;
        default: print('None');
      }
    }

print('Massege: ${listTst}');
    setState(() {
      if (messages.length >= 100) {
        messages.removeAt(0);
        messages.add(_Message(1, dataStr));
      } else
        messages.add(_Message(1, dataStr));
    });
    
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

  //////////////////////////////////////////////////////////////////////////////////////////////// Файлы
  
// void startFile() async {
//     final directiry = await pathProvider.getApplicationDocumentsDirectory();
//     final file = File(directiry.path + '/stat.txt');
//     final isExist = await file.exists();

//     if (isExist) {
//       String fileStr = await file.readAsString();
//       List<String> fileList = fileStr.split('_');
//       print('Str: $fileStr');
//       if (fileList.isNotEmpty) {
//         for (int i = 0; i < fileList.length-5; i + 5) {
//           dataTM.add(double.parse(fileList[i]));
//           dataTW.add(double.parse(fileList[i + 1]));
//           dataT.add(double.parse(fileList[i + 2]));
//           dataPV.add(double.parse(fileList[i + 3]));
//           dataST.add(double.parse(fileList[i + 4]));
          
//         }
//       }
//     }
//   }

// void writeFile(double num) async {
//     await file?.writeAsString('$num ', mode: FileMode.writeOnlyAppend);
//     print(num);
// }


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
    chartSeriesController = null;

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

 if (st!=0 && isConnected) {
    dataTM.add(tm);
    dataTW.add(tw);
    if (st == 1 || st == 2) dataT.add(hs);
    if (st == 3) dataT.add(ks);
    if (st == 4) dataT.add(hd);
    dataPV.add(pv);
    dataST.add(st*10);
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
Container contanerData(String name, String data, Color col) {
    return Container(
        child: Row(
      children: [
        Text('$name: ', style: TextStyle(color: Colors.white, fontSize: 20)),
        Text(data, style: TextStyle(color: col, fontSize: 20)),
      ],
    ));
  }

Widget window1 (){
 return Container(
          color: Color.fromRGBO(31, 10, 9, 1),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Text('${_nameDev} / ${_addresDev} / ${_bluetoothState}',style: TextStyle(color: Colors.white)),
                   _devicesList.isNotEmpty ? Text('Connect: ${_device!.name!}', style: TextStyle(color: Colors.white),) : Text('Error', style: TextStyle(color: Colors.white)),
                //  Text(_content, style: TextStyle(color: Colors.white),),
                ],), flex: 1,
                ),
              Flexible(child: getAddRemoveSeriesChart(), flex: 10,),
              Flexible(child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: chartElement.map((el) => contanerData(el.name ,el.data.last.toString(), el.color)).toList(),),flex: 1,),
                      
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
               _message.text.trim(),
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


class ChartElement {
  final List<double> data;
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
