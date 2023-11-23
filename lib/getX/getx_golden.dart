import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:get/get.dart';
import 'package:goldensmoker/getX/command_file.dart';



class AllStateWidget extends GetxController{
  RxDouble range = 1.0.obs;
  RxBool isSwitchedAir = false.obs;
  RxBool isSwitchedSmoke = false.obs;
  RxBool isSwitchedWater = false.obs;
  String msgRange ='';
  String msgSwitched ='';
  String message = '';
  String end = '';
  BluetoothUser bluetoothUser = Get.put(BluetoothUser());
  
  @override
  void onInit(){
    super.onInit();
    bluetoothUser.update();
    range.value = bluetoothUser.mb.value;
    isSwitchedAir.value = bluetoothUser.a.value;
    isSwitchedSmoke.value = bluetoothUser.s.value;
    isSwitchedWater.value = bluetoothUser.w.value;
  }

  void setRange(double value){
    range.value = value;
    upD();
  }
  void isToggleAir() {
    isSwitchedAir.toggle();
    update();
    upD();
  }
   void isToggleSmoke() {
    isSwitchedSmoke.toggle();
    update();
    upD();
  }
  void isToggleWater() {
    isSwitchedWater.toggle();
    update();
    upD();
  }
  void upD(){
    message = '';
    msgSwitched = '';
    msgRange = '';
    end = '';
    if (isSwitchedAir.value || isSwitchedSmoke.value || isSwitchedWater.value) msgSwitched += 'M!';
    if (isSwitchedAir.value) msgSwitched += 'A';
    if (isSwitchedSmoke.value) msgSwitched += 'S';
    if (isSwitchedWater.value) msgSwitched += 'W';
    if (range.value != 0) msgRange = 'MB${range.value.round() * 10}';
    if (msgRange !='' && msgSwitched != '') end = '~';
    message = RECIPE_MANUAL + ACTION_INPUT + msgRange + end + msgSwitched;
  }
}

class BluetoothUser extends GetxController {
  final FlutterBluetoothSerial bluetooth = FlutterBluetoothSerial.instance;
  String nameDev = '';
  String addresDev = '';
  Rx<BluetoothState> bluetoothState = Rx(BluetoothState.UNKNOWN);
  bool isConnect = false;
  List<BluetoothDevice> devicesList = <BluetoothDevice>[];
  BluetoothDevice? device;

  RxString dataString = ''.obs;
  List<String> listMsg = <String>[].obs;
  BluetoothConnection? connection;
  bool get isConnected => (connection?.isConnected ?? false);
  
  RxDouble tp = 0.0.obs;
  RxDouble tb = 0.0.obs;
  RxInt step = 0.obs;
  RxBool lamp = false.obs;
  RxDouble mb = 0.0.obs;
  RxInt mt = 0.obs;
  RxBool w = false.obs;
  RxBool s = false.obs;
  RxBool a = false.obs;
  RxInt timePeriod = 0.obs;
  RxInt timeNow = 0.obs;

  BluetoothUser();

  @override
  void onInit() async {
    super.onInit();
    await _connectBluetooth();
    await _setName();
    await _setAddres();
    await _setStateBluetooth();
    _strimStateBluetooth();
    await _getListDevices();
    await _getDev();
  }

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
    await bluetooth.state.then((stateS) => bluetoothState.value = stateS);
    if (bluetoothState.value.stringValue == 'STATE_ON') isConnect = true;
  }

  Future<void> _getListDevices() async {
    await bluetooth.getBondedDevices().then((list) {
      devicesList = list;
    });
  }

  Future<void> _getDev() async {
    if (devicesList.isNotEmpty) {
      for (var item in devicesList) {
        if (item.isBonded) {
          device = item;
          _connectChat(device!);
          return;
        }
      }
    }
  }

  void _strimStateBluetooth() {
    bluetooth.onStateChanged().listen((BluetoothState state) {}).onData((data) {
      switch (data.stringValue) {
        case 'STATE_ON':
          isConnect = true;
          bluetoothState.value = data;
          break;
        case 'STATE_OFF':
          isConnect = false;
          bluetoothState.value = data;
          break;
        default:
      }
    });
  }

  Future<void> _connectChat(BluetoothDevice device) async {
    await BluetoothConnection.toAddress(device.address).then((connect) {
      connection = connect;
      connection!.input!.listen(_parseData).onDone(() {});
    }).catchError((error) {});
  }

  double fCommand(String command) {
    return int.parse(command.substring(2)) / 10;
  }

  void listM(String str) {
    List<String> listM = str.substring(2).split('');
    for (var i in listM) {
      switch (i) {
        case 'A':
          a.value = true; 
          break;
        case 'S':
          s.value = true; 
          break;
        case 'W':
          w.value = true; 
          break;
          default:
      }
    }
  }

  void listRM(String comm) {
    List<String> listRM = comm.substring(3).split('~');
    for (var rm in listRM){
      switch (rm.substring(0, 2)) {
        case 'MB':
          mb.value = fCommand(rm);
        break;
        case 'MP':
          List<String> listMP = rm.substring(2).split('/');
          if (listMP.isNotEmpty) {
            tp.value = int.parse(listMP[0]) / 10;
            if (listMP.length > 1) tb.value = int.parse(listMP[1]) / 10;
          }
        break;
        case 'MT':
          List<String> listMT = rm.substring(2).split('/');
          if (listMT.isNotEmpty) {
            timePeriod.value = int.parse(listMT[0]);
            if (listMT.length > 1) timeNow.value = int.parse(listMT[1]);
          }
        break;
        case 'M!':
          listM(rm);
        break;
        default: 
      }
    }
  }

  void _parseData(Uint8List data) {
    dataString.value = utf8.decode(data).trim();
    if (dataString.value.isEmpty) return;
    listMsg.add(dataString.value);
    if (listMsg.length > 30) listMsg.removeAt(0);
    List<String> listCommand = dataString.split('_');
    // if (listCommand.isEmpty) return;
    a.value = false;
    s.value = false;
    w.value = false;
    for (var command in listCommand) {
      switch (command.substring(0, 2)) {
        case 'TP':
          tp.value = fCommand(command);
          break;
        case 'TB':
          tb.value = fCommand(command);
          break;
        case 'R*':
          step.value = int.parse(command.substring(2));
          break;
        case 'L-':
          lamp.value = false;
          break;
        case 'L+':
          lamp.value = true;
          break;
        case 'RM':
          listRM(command);
          break;
        default:
      }
    }
  }

  Future<void> sendMessage(String text) async {
    if (text.isNotEmpty) {
      try {
        connection!.output
            .add(Uint8List.fromList(utf8.encode('${text.toUpperCase()}\r\n')));
        await connection!.output.allSent;
      } catch (e) {print(e);}
    }
  }
}