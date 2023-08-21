import 'package:flutter/material.dart';

// import './MainPage.dart';

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import './BackgroundCollectingTask.dart';
import './ChatPage.dart';
import './SelectBondedDevicePage.dart';
import './BluetoothDeviceListEntry.dart';
import 'MainPage.dart';

void main() => runApp(new ExampleApplication());

class ExampleApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MainPage());
  }
}

////////////////////////////////////////////////////////////////////
///

// class MainPage extends StatefulWidget {

//   @override
//   _MainPage createState() => new _MainPage();
// }


// enum _DeviceAvailability {
//   no,
//   maybe,
//   yes,
// }
// class _DeviceWithAvailability {
//   BluetoothDevice device;
//   _DeviceAvailability availability;
//   int? rssi;

//   _DeviceWithAvailability(this.device, this.availability, [this.rssi]);
// }

// class _MainPage extends State<MainPage> {

//   // Переменные
//   BluetoothState _bluetoothState = BluetoothState.UNKNOWN;
//   Timer? _discoverableTimeoutTimer;
//   String _address = "...";
//   String _name = "...";
//   int _discoverableTimeoutSecondsLeft = 0;
//   BackgroundCollectingTask? _collectingTask;
//   bool _autoAcceptPairingRequests = false;


//   List<_DeviceWithAvailability> devices = List<_DeviceWithAvailability>.empty(growable: true);
//   // Доступность
//   StreamSubscription<BluetoothDiscoveryResult>? _discoveryStreamSubscription;
//   bool _isDiscovering = true;



//   @override
//   void initState() {
//     super.initState();

// // Подключение блютуса при запуске приложения
//     FlutterBluetoothSerial.instance.requestEnable();
// // await FlutterBluetoothSerial.instance.requestDisable();

//     // Получить текущее состояние
//     FlutterBluetoothSerial.instance.state.then((state) {
//       setState(() {
//         _bluetoothState = state;
//       });
//     });

//     Future.doWhile(() async {
//       // Подождите, если адаптер не включен
//       if ((await FlutterBluetoothSerial.instance.isEnabled) ?? false) { return false; }
//       await Future.delayed(Duration(milliseconds: 0xDD));
//       return true;
//     }).then((_) {
//       // Обновите поле адреса
//       FlutterBluetoothSerial.instance.address.then((address) {
//         setState(() {
//           _address = address!;
//         });
//       });
//     });

//     FlutterBluetoothSerial.instance.name.then((name) {
//       setState(() {
//         _name = name!;
//       });
//     });

//     // Следите за дальнейшими изменениями состояния
//     FlutterBluetoothSerial.instance
//         .onStateChanged()
//         .listen((BluetoothState state) {
//       setState(() {
//         _bluetoothState = state;

//         // Режим обнаружения отключается при отключении Bluetooth
//         _discoverableTimeoutTimer = null;
//         _discoverableTimeoutSecondsLeft = 0;
//       });
//     });


  
//     if (_isDiscovering) {
//       _startDiscovery();

// // Настройка списка подключенных устройств
//     FlutterBluetoothSerial.instance
//         .getBondedDevices()
//         .then((List<BluetoothDevice> bondedDevices) {
//       setState(() {
//         devices = bondedDevices
//             .map(
//               (device) => _DeviceWithAvailability(
//                 device,
//                 _DeviceAvailability.yes,
//               ),
//             )
//             .toList();
//       });
//     });
//     } 
//   }


// void _restartDiscovery() {
//     setState(() {
//       _isDiscovering = true;
//     });

//     _startDiscovery();
//   }

//   void _startDiscovery() {
//     _discoveryStreamSubscription =
//         FlutterBluetoothSerial.instance.startDiscovery().listen((r) {
//       setState(() {
//         Iterator i = devices.iterator;
//         while (i.moveNext()) {
//           var _device = i.current;
//           if (_device.device == r.device) {
//             _device.availability = _DeviceAvailability.yes;
//             _device.rssi = r.rssi;
//           }
//         }
//       });
//     });

//     _discoveryStreamSubscription?.onDone(() {
//       setState(() {
//         _isDiscovering = false;
//       });
//     });
//   }



//   @override
//   void dispose() {
//     FlutterBluetoothSerial.instance.setPairingRequestHandler(null);
//     _collectingTask?.dispose();
//     _discoverableTimeoutTimer?.cancel();
//     // Избегайте утечки памяти (`setState` после dispose) и отмените обнаружение
//     _discoveryStreamSubscription?.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {

// ListTile settings1() {
//       return ListTile(
//         title: const Text('Статус Bluetooth'),
//         subtitle: Text(_bluetoothState.toString()),
//         trailing: ElevatedButton(
//           child: const Text('Настройки'),
//           onPressed: () {
//             FlutterBluetoothSerial.instance.openSettings();
//           },
//         ),
//       );
//     }

// List<BluetoothDeviceListEntry> list = devices
//         .map((_device) => BluetoothDeviceListEntry(
//               device: _device.device,
//               rssi: _device.rssi,
//               enabled: _device.availability == _DeviceAvailability.yes,
//               onTap: () {
//                 Navigator.of(context).pop(_device.device);
//               },
//             ))
//         .toList();

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Bluetooth test'),
//       ),
//       body: Container(
//         child: ListView(
//           children: <Widget>[
//             settings1(),
//             const Text('Устройства:'),
//             // ListView(children: list,),


//             // ListTile(
//             //   trailing: ElevatedButton(
//             //     child: const Text('Подключитесь'),
//             //     onPressed: () async {
//             //       final BluetoothDevice? selectedDevice =
//             //           await Navigator.of(context).push(
//             //         MaterialPageRoute(
//             //           builder: (context) {
//             //             return SelectBondedDevicePage(checkAvailability: false);
//             //           },
//             //         ),
//             //       );

//             //       if (selectedDevice != null) {
//             //         print('Подключить -> выбранны ' + selectedDevice.address);
//             //         _startChat(context, selectedDevice);
//             //       } else {
//             //         print('Подключить -> не выбранны');
//             //       }
//             //     },
//             //   ),
//             // ),
//             Divider(),
//           ],
//         ),
//       ),
//     );
//   }

//   void _startChat(BuildContext context, BluetoothDevice server) {
//     Navigator.of(context).push(
//       MaterialPageRoute(
//         builder: (context) {
//           return ChatPage(server: server);
//         },
//       ),
//     );
//   }

//   Future<void> _startBackgroundTask(
//     BuildContext context,
//     BluetoothDevice server,
//   ) async {
//     try {
//       _collectingTask = await BackgroundCollectingTask.connect(server);
//       await _collectingTask!.start();
//     } catch (ex) {
//       _collectingTask?.cancel();
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: const Text('Произошла ошибка при подключении'),
//             content: Text("${ex.toString()}"),
//             actions: <Widget>[
//               new TextButton(
//                 child: new Text("Закрыть"),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//               ),
//             ],
//           );
//         },
//       );
//     }
//   }
// }
