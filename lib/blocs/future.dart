// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';

void main(){

two();
one();
two();
}


Future <void> one () async{
  final c = await sum(1, 1);
  final a = 4;
  print(c);
  print(a);
}

Future <void> two ()async{
print(await 'hel');
}


Future <int> sum (int a,int b){
  return Future.sync(() => a+b);
}


// class BluetoothUser {
//   String nameDev;
//   String addresDev;
//   bool isConnect;
//   FlutterBluetoothSerial bluetooth = FlutterBluetoothSerial.instance;
//   List<BluetoothDevice>? devicesList = [];
//   BluetoothDevice? device;

//   BluetoothState bluetoothState;
//   BluetoothConnection? connection;
//   String dataStr;
//    List<double> dataTM = [];
//    List<double> dataTW = [];
//       List<double> dataT= [];
//    List<double> dataPV= [];
//    List<double> dataST= [];
//   BluetoothUser({
//     required this.nameDev,
//     required this.addresDev,
//     required this.isConnect,
//     required this.bluetooth,
//     this.devicesList,
//     this.device,
//     required this.bluetoothState,
//     this.connection,
//     required this.dataStr,
//     required this.dataTM,
//     required this.dataTW,
//     required this.dataT,
//     required this.dataPV,
//     required this.dataST,
//   });


//   BluetoothUser copyWith({
//     String? nameDev,
//     String? addresDev,
//     bool? isConnect,
//     FlutterBluetoothSerial? bluetooth,
//     List<BluetoothDevice>? devicesList,
//     BluetoothDevice? device,
//     BluetoothState? bluetoothState,
//     BluetoothConnection? connection,
//     String? dataStr,
//     List<double>? dataTM,
//     List<double>? dataTW,
//     List<double>? dataT,
//     List<double>? dataPV,
//     List<double>? dataST,
//   }) {
//     return BluetoothUser(
//       nameDev: nameDev ?? this.nameDev,
//       addresDev: addresDev ?? this.addresDev,
//       isConnect: isConnect ?? this.isConnect,
//       bluetooth: bluetooth ?? this.bluetooth,
//       devicesList: devicesList ?? this.devicesList,
//       device: device ?? this.device,
//       bluetoothState: bluetoothState ?? this.bluetoothState,
//       connection: connection ?? this.connection,
//       dataStr: dataStr ?? this.dataStr,
//       dataTM: dataTM ?? this.dataTM,
//       dataTW: dataTW ?? this.dataTW,
//       dataT: dataT ?? this.dataT,
//       dataPV: dataPV ?? this.dataPV,
//       dataST: dataST ?? this.dataST,
//     );
//   }

//   @override
//   String toString() {
//     return '------->(nameDev: $nameDev, addresDev: $addresDev, isConnect: $isConnect, bluetooth: $bluetooth, devicesList: $devicesList, device: $device, bluetoothState: $bluetoothState, connection: $connection, dataStr: $dataStr, dataTM: $dataTM, dataTW: $dataTW)';
//   }

//   @override
//   bool operator ==(covariant BluetoothUser other) {
//     if (identical(this, other)) return true;
  
//     return 
//       other.nameDev == nameDev &&
//       other.addresDev == addresDev &&
//       other.isConnect == isConnect &&
//       other.bluetooth == bluetooth &&
//       listEquals(other.devicesList, devicesList) &&
//       other.device == device &&
//       other.bluetoothState == bluetoothState &&
//       other.connection == connection &&
//       other.dataStr == dataStr &&
//       listEquals(other.dataTM, dataTM) &&
//       listEquals(other.dataTW, dataTW) &&
//       listEquals(other.dataT, dataT) &&
//       listEquals(other.dataPV, dataPV) &&
//       listEquals(other.dataST, dataST);
//   }

//   @override
//   int get hashCode {
//     return nameDev.hashCode ^
//       addresDev.hashCode ^
//       isConnect.hashCode ^
//       bluetooth.hashCode ^
//       devicesList.hashCode ^
//       device.hashCode ^
//       bluetoothState.hashCode ^
//       connection.hashCode ^
//       dataStr.hashCode ^
//       dataTM.hashCode ^
//       dataTW.hashCode ^
//       dataT.hashCode ^
//       dataPV.hashCode ^
//       dataST.hashCode;
//   }
// }
