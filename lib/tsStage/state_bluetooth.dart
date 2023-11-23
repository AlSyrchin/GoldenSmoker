import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class StateBluetooth {

  final FlutterBluetoothSerial bluetooth = FlutterBluetoothSerial.instance;
  final String nameDevice;
  final String addresDevice;
  final bool isConnectBlu;
  final BluetoothState bluetoothState;
  final BluetoothDevice device;
  final List<BluetoothDevice> listDevices;
  final BluetoothConnection? connection;
  final bool isDisconnecting;

  StateBluetooth({
    this.nameDevice = '',
    this.addresDevice = '',
    this.isConnectBlu = false,
    this.bluetoothState = BluetoothState.UNKNOWN,
    this.device = const BluetoothDevice(name: 'none', address: ''),
    this.listDevices = const [],
    this.connection,
    this.isDisconnecting = true,
  });

  bool get isConnected => (connection?.isConnected ?? false);

  StateBluetooth copyWith({
    String? nameDevice,
    String? addresDevice,
    bool? isConnectBlu,
    BluetoothState? bluetoothState,
    BluetoothDevice? device,
    List<BluetoothDevice>? listDevices,
    BluetoothConnection? connection,
    bool? isDisconnecting,
  }) {
    return StateBluetooth(
      nameDevice: nameDevice ?? this.nameDevice,
      addresDevice: addresDevice ?? this.addresDevice,
      isConnectBlu: isConnectBlu ?? this.isConnectBlu,
      bluetoothState: bluetoothState ?? this.bluetoothState,
      device: device ?? this.device,
      listDevices: listDevices ?? this.listDevices,
      connection: connection ?? this.connection,
      isDisconnecting: isDisconnecting ?? this.isDisconnecting,
    );
  }
}

