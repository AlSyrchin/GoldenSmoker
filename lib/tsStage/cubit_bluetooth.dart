import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'cubit_chat.dart';
import 'state_bluetooth.dart';

class CubitBluetooth extends Cubit<StateBluetooth> {
  final CubitChat otherCubitChat;
  Timer? timer;

  CubitBluetooth(this.otherCubitChat) : super(StateBluetooth()){
    init();
    _strimState();
    }

  Future<void> init() async {
    await state.bluetooth.requestEnable();
    state.bluetooth.name.then((name) => emit(state.copyWith(nameDevice: name)));
    state.bluetooth.address.then((address) => emit(state.copyWith(addresDevice: address)));
    state.bluetooth.state.then((blState) => emit(state.copyWith(bluetoothState: blState)));
    state.bluetooth.getBondedDevices().then((list) => emit(state.copyWith(listDevices: list)));
    await _getDevice();
    await connectChat();

    // Стрим на лист устройств
    // await state.bluetooth.startDiscovery().listen((event) {
    //   Iterator i = state.listDevices.iterator;
    //   while (i.moveNext()){
    //     var _dev = i.current as BluetoothDevice ;
    //     if (_dev == event.device) {
    //       _dev.isConnected;
    //     }
    //   }
    // });
  }

  Future<void> _getDevice() async {
    if (state.listDevices.isNotEmpty){
      for (var element in state.listDevices) {
        if (element.isBonded){
          emit(state.copyWith(device: element));
        }
      }
    }
  }

  void _strimState(){
    state.bluetooth.onStateChanged().listen((data) {}).onData((data) {
      if (data.stringValue == 'STATE_ON') {
        emit(state.copyWith(bluetoothState: data, isConnectBlu: true));
        init();
      } else if (data.stringValue == 'STATE_OFF'){
        emit(state.copyWith(bluetoothState: data, isConnectBlu: false, device: const BluetoothDevice(name: 'none', address: '')));
      } 
    });
  }

//   void _strimDevice(){
    
//   device.state.listen((state){
//         if(state == BluetoothDeviceState.disconnected){
//                      DialogUtils.showOneDialog (context, "Подсказка", "Устройство было отключено", () {
// //do something
//           });
//         }
//  });
//   }

  Future<void> connectChat() async {
    // if (state.device != null) {
    //   await BluetoothConnection.toAddress(state.device!.address).then((connect) {
    //     emit(state.copyWith(connection: connect, isDisconnecting: false));
    //     state.connection!.input!.listen(otherCubitChat.parseData).onData((data) {
    //       otherCubitChat.parseData(data);
    //       if (state.isDisconnecting){
    //         print('Устройство отключено');
    //       } else {
    //         print('Устройство подключено');
    //       }
    //     });
    //   }).catchError((error) {
    //     print('Нет подключения. Ошибка: $error');
    //     });
    // }

      try{
        await BluetoothConnection.toAddress(state.device.address).then((connect) {
        emit(state.copyWith(connection: connect, isDisconnecting: false));
        state.connection!.input!.listen(otherCubitChat.parseData).onData((data) {
          otherCubitChat.parseData(data);
          // print('${utf8.encode('- \n')}');
         
          // if (state.isDisconnecting){print('Устройство отключено');} 
          // else {print('Устройство подключено');}
        });
      }).catchError((error) {
        print('Нет подключения. Ошибка.');
        });
      } catch (e) {print('Нет подключения');}
  }

  Future<void> sendMessage(String text) async {
    if (text.isNotEmpty) {
      try {
        state.connection!.output.add(Uint8List.fromList(utf8.encode('${text.toUpperCase()}\r\n')));
        await state.connection!.output.allSent;
      } catch (e) {print(e);}
    }
  }
  
}