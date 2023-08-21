// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';
// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:flutter_blue_plus/flutter_blue_plus.dart';

// // Этот плагин предоставляет кроссплатформенный (iOS, Android) API для запроса разрешений и проверки их статуса. Вы также можете открыть настройки приложения устройства, чтобы пользователи могли предоставить разрешение.
// // На Android вы можете показать обоснование запроса разрешения.
// import 'package:permission_handler/permission_handler.dart';

// import 'widgets.dart';

// void main() {

//   if (Platform.isAndroid) {
//     WidgetsFlutterBinding.ensureInitialized();
//     [
//       Permission.location,
//       Permission.storage,
//       Permission.bluetooth,
//       Permission.bluetoothConnect,
//       Permission.bluetoothScan
//     ].request().then((status) {
//       runApp(const FlutterBlueApp());
//     });
//   } else {
//       runApp(const FlutterBlueApp());
//   }
// }

// class FlutterBlueApp extends StatelessWidget {
//   const FlutterBlueApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       color: Colors.lightBlue,
//       home: StreamBuilder<BluetoothState>(
//           stream: FlutterBluePlus.instance.state,
//           initialData: BluetoothState.unknown,
//           builder: (c, snapshot) {
//             final state = snapshot.data;
//             if (state == BluetoothState.on) {
//               return const FindDevicesScreen();
//             }
//             return BluetoothOffScreen(state: state);
//           }),
//     );
//   }
// }

// class BluetoothOffScreen extends StatelessWidget {
//   const BluetoothOffScreen({Key? key, this.state}) : super(key: key);

//   final BluetoothState? state;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.lightBlue,
//       body: Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             const Icon(
//               Icons.bluetooth_disabled,
//               size: 200.0,
//               color: Colors.white54,
//             ),
//             Text(
//               'Bluetooth Adapter is ${state != null ? state.toString().substring(15) : 'not available'}.',
//               style: Theme.of(context)
//                   .primaryTextTheme
//                   .subtitle2
//                   ?.copyWith(color: Colors.white),
//             ),
//             ElevatedButton(
//               child: const Text('TURN ON'),
//               onPressed: Platform.isAndroid
//                   ? () => FlutterBluePlus.instance.turnOn()
//                   : null,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class FindDevicesScreen extends StatelessWidget {
//   const FindDevicesScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Find Devices'),
//         actions: [
//           ElevatedButton(
//             child: const Text('TURN OFF'),
//             style: ElevatedButton.styleFrom(
//               primary: Colors.black,
//               onPrimary: Colors.white,
//             ),
//             onPressed: Platform.isAndroid
//                 ? () => FlutterBluePlus.instance.turnOff()
//                 : null,
//           ),
//         ],
//       ),
//       body: RefreshIndicator(

//         //Начало сканирования
//         onRefresh: () => FlutterBluePlus.instance.startScan(timeout: const Duration(seconds: 6)),
//         child: SingleChildScrollView(
//           child: Column(
//             children: <Widget>[
//               StreamBuilder<List<BluetoothDevice>>(
//                 stream: Stream.periodic(const Duration(seconds: 3)).asyncMap((_) => FlutterBluePlus.instance.connectedDevices),
//                 initialData: const [],
//                 builder: (c, snapshot) => Column(
//                   children: snapshot.data!
//                       .map((d) => ListTile(
//                             title: Text(d.name),
//                             subtitle: Text(d.id.toString()),
//                             trailing: StreamBuilder<BluetoothDeviceState>(
//                               stream: d.state,
//                               initialData: BluetoothDeviceState.disconnected,
//                               builder: (c, snapshot) {
//                                 if (snapshot.data ==
//                                     BluetoothDeviceState.connected) {
//                                   return ElevatedButton(
//                                     child: const Text('OPEN'),
//                                     onPressed: () => Navigator.of(context).push(
//                                         MaterialPageRoute(
//                                             builder: (context) =>
//                                                 DeviceScreen(device: d))),
//                                   );
//                                 }
//                                 return Text(snapshot.data.toString());
//                               },
//                             ),
//                           ))
//                       .toList(),
//                 ),
//               ),
//               StreamBuilder<List<ScanResult>>(
//                 stream: FlutterBluePlus.instance.scanResults,
//                 initialData: const [],
//                 builder: (c, snapshot) => Column(
//                   children: snapshot.data!
//                       .map(
//                         (r) => ScanResultTile(
//                           result: r,
//                           onTap: () => Navigator.of(context)
//                               .push(MaterialPageRoute(builder: (context) {
//                             r.device.connect();
//                             return DeviceScreen(device: r.device);
//                           })),
//                         ),
//                       )
//                       .toList(),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       floatingActionButton: StreamBuilder<bool>(
//         stream: FlutterBluePlus.instance.isScanning,
//         initialData: false,
//         builder: (c, snapshot) {
//           if (snapshot.data!) {
//             return FloatingActionButton(
//               child: const Icon(Icons.stop),

//               // Окончание сканирования
//               onPressed: () => FlutterBluePlus.instance.stopScan(),
//               backgroundColor: Colors.red,
//             );
//           } else {
//             return FloatingActionButton(
//                 child: const Icon(Icons.search),
//                 onPressed: () => FlutterBluePlus.instance
//                     .startScan(timeout: const Duration(seconds: 4)));
//           }
//         },
//       ),
//     );
//   }
// }

// class DeviceScreen extends StatelessWidget {
//   const DeviceScreen({Key? key, required this.device}) : super(key: key);

//   final BluetoothDevice device;

//   List<int> _getRandomBytes() {
//     final math = Random();
//     return [
//       math.nextInt(255),
//       math.nextInt(255),
//       math.nextInt(255),
//       math.nextInt(255)
//     ];
//   }

//   List<int> _getSimb() {
//     final String  a = 'Drus pidor';
//     print(utf8.encode(a));
//     return utf8.encode(a);
//   }


// // Generic Access service. У этой службы UUID 0x1800, и три обязательных характеристики:
// // 1. Характеристика UUID 0x2A00: Device name (имя устройства).
// // 2. Характеристика UUID 0x2A01: Appearance (внешний вид).
// // 3. Характеристика UUID 0x2A04: Peripheral Preferred Connection Parameters (предпочтительные параметры подключения к устройству).


// // Generic Attribute service. У этой службы UUID 0x1801, и одна опциональная (не обязательная) характеристика:
// // 1. Характеристика UUID 0x2A05: Service Changed (служба изменена).
// // Служба Generic Access Service содержит общую информацию об устройстве BLE. Вы можете распознать характеристику с именем устройства “OurService”. Вторая характеристика хранит значение внешнего вида (appearance), и в нашем случае мы в это значение ничего не установили, поэтому значение показывается просто как 0x0000. Третья характеристика хранит различные параметры, используемые для установки соединения. Вы можете найти эти значения в определениях #defines проекта, они называются MIN_CONN_INTERVAL, MAX_CONN_INTERVAL, SLAVE_LATENCY и CONN_SUP_TIMEOUT. Во врезке ниже дано короткое объяснение этих параметров.

//   List<Widget> _buildServiceTiles(List<BluetoothService> services) {
//     return services
//         .map(
//           (s) => ServiceTile(
//             service: s,
//             characteristicTiles: s.characteristics.map(
//                   (c) => CharacteristicTile(
//                     characteristic: c,
//                     onReadPressed: () => c.read(),
//                     onWritePressed: () async {
//                       await c.write(_getSimb(), withoutResponse: true);
//                       // await c.read();
//                     },
//                     onNotificationPressed: () async {
//                       await c.setNotifyValue(!c.isNotifying);
//                       await c.read();
//                     },
//                     // descriptorTiles: c.descriptors
//                     //     .map(
//                     //       (d) => DescriptorTile(
//                     //         descriptor: d,
//                     //         onReadPressed: () => d.read(),
//                     //         onWritePressed: () => d.write(_getRandomBytes()),
//                     //       ),
//                     //     )
//                     //     .toList(),
//                   ),
//                 )
//                 .toList(),
//           ),
//         )
//         .toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(device.name),
//         actions: <Widget>[
//           StreamBuilder<BluetoothDeviceState>(
//             stream: device.state,
//             initialData: BluetoothDeviceState.connecting,
//             builder: (c, snapshot) {
//               VoidCallback? onPressed;
//               String text;
//               switch (snapshot.data) {
//                 case BluetoothDeviceState.connected:
//                   onPressed = () => device.disconnect();
//                   text = 'DISCONNECT';
//                   break;
//                 case BluetoothDeviceState.disconnected:
//                   onPressed = () => device.connect();
//                   text = 'CONNECT';
//                   break;
//                 default:
//                   onPressed = null;
//                   text = snapshot.data.toString().substring(21).toUpperCase();
//                   break;
//               }
//               return TextButton(
//                   onPressed: onPressed,
//                   child: Text(
//                     text,
//                     style: Theme.of(context)
//                         .primaryTextTheme
//                         .button
//                         ?.copyWith(color: Colors.white),
//                   ));
//             },
//           )
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: <Widget>[
//             StreamBuilder<BluetoothDeviceState>(
//               stream: device.state,
//               initialData: BluetoothDeviceState.connecting,
//               builder: (c, snapshot) => ListTile(
//                 // В начале
//                 leading: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     snapshot.data == BluetoothDeviceState.connected
//                         ? const Icon(Icons.bluetooth_connected)
//                         : const Icon(Icons.bluetooth_disabled),
//                     // snapshot.data == BluetoothDeviceState.connected
//                     //     ? StreamBuilder<int>(
//                     //     stream: rssiStream(),
//                     //     builder: (context, snapshot) {
//                     //       return Text(snapshot.hasData ? '${snapshot.data}dBm' : '');
//                     //     })
//                     //     : Text(''),
//                   ],
//                 ),
//                 title: Text('Device is: ${snapshot.data.toString().split('.')[1]}.'),
//                 subtitle: Text('${device.id}'),
//                 // В конце
//                 trailing: StreamBuilder<bool>(
//                   stream: device.isDiscoveringServices,
//                   initialData: false,
//                   builder: (c, snapshot) => IndexedStack(
//                     index: snapshot.data! ? 1 : 0,
//                     children: <Widget>[
//                       IconButton(
//                         icon: const Icon(Icons.refresh),
//                         onPressed: () {
//                           device.discoverServices(); 
//                           //MTU Size (макс. кол-во данных для хранения в буфере ${snapshot.data} bytes
//                         device.requestMtu(223); },
//                       ),
//                       const IconButton(
//                         icon: SizedBox(
//                           child: CircularProgressIndicator(
//                             valueColor: AlwaysStoppedAnimation(Color.fromARGB(255, 189, 41, 41)),
//                           ),
//                           width: 18.0,
//                           height: 18.0,
//                         ),
//                         onPressed: null,
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ),

//             StreamBuilder<List<BluetoothService>>(
//               stream: device.services,
//               initialData: const [],
//               builder: (c, snapshot) {
//                 return Column(
//                   children: _buildServiceTiles(snapshot.data!),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
  
//   Stream<int> rssiStream() async* {
//     var isConnected = true;
//     final subscription = device.state.listen((state) {
//       isConnected = state == BluetoothDeviceState.connected;
//     });
//     while (isConnected) {
//       yield await device.readRssi();
//       await Future.delayed(const Duration(seconds: 1));
//     }
//     subscription.cancel();
//     // Device disconnected, stopping RSSI stream
//   }
// }