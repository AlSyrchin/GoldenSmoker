import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'background_collecting_task.dart';
import 'chat_page.dart';
import 'select_bonded_device_page.dart';

// import './helpers/LineChart.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPage createState() => new _MainPage();
}

class _MainPage extends State<MainPage> {
  BluetoothState bluetoothState = BluetoothState.UNKNOWN;
  String address = "";
  String name = "";
  Timer? _discoverableTimeoutTimer;
  int discoverableTimeoutSecondsLeft = 0;
  BackgroundCollectingTask? _collectingTask;
  bool autoAcceptPairingRequests = false;

  @override
  void initState() {
    super.initState();



// Подключение блютуса при запуске приложения
FlutterBluetoothSerial.instance.requestEnable();
// await FlutterBluetoothSerial.instance.requestDisable();



    // Получить текущее состояние
    FlutterBluetoothSerial.instance.state.then((state) {
      setState(() {
        bluetoothState = state;
      });
    });

    Future.doWhile(() async {
      // Подождите, если адаптер не включен
      if ((await FlutterBluetoothSerial.instance.isEnabled) ?? false) {
        return false;
      }
      await Future.delayed(Duration(milliseconds: 0xDD));
      return true;
    }).then((_) {
      // Обновите поле адреса
      FlutterBluetoothSerial.instance.address.then((address) {
        setState(() {
          address = address!;
        });
      });
    });

    FlutterBluetoothSerial.instance.name.then((name) {
      setState(() {
        name = name!;
      });
    });

    // Следите за дальнейшими изменениями состояния
    FlutterBluetoothSerial.instance
        .onStateChanged()
        .listen((BluetoothState state) {
      setState(() {
        bluetoothState = state;

        // Режим обнаружения отключается при отключении Bluetooth
        _discoverableTimeoutTimer = null;
        discoverableTimeoutSecondsLeft = 0;
      });
    });
  }

  @override
  void dispose() {
    FlutterBluetoothSerial.instance.setPairingRequestHandler(null);
    _collectingTask?.dispose();
    _discoverableTimeoutTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bluetooth test'),
      ),
      body:ListView(
          children: <Widget>[
            const Divider(), // Линия

            // ListTile(title: const Text('Устройства:')),
            // SwitchListTile(
            //   title: const Text('Автоматическая попытка ввода определенного pin-кода при сопряжении'),
            //   subtitle: const Text('Pin 1234'),
            //   value: _autoAcceptPairingRequests,
            //   onChanged: (bool value) {
            //     setState(() {
            //       _autoAcceptPairingRequests = value;
            //     });
            //     if (value) {
            //       FlutterBluetoothSerial.instance.setPairingRequestHandler(
            //           (BluetoothPairingRequest request) {
            //         print("Авто подключение к Pin 1234");
            //         if (request.pairingVariant == PairingVariant.Pin) {
            //           return Future.value("1234");
            //         }
            //         return Future.value(null);
            //       });
            //     } else {
            //       FlutterBluetoothSerial.instance
            //           .setPairingRequestHandler(null);
            //     }
            //   },
            // ),


            // ListTile(
            //   title: ElevatedButton(
            //       child: const Text('Исследуйте обнаруженные устройства'),
            //       onPressed: () async {
            //         final BluetoothDevice? selectedDevice =
            //             await Navigator.of(context).push(
            //           MaterialPageRoute(
            //             builder: (context) {
            //               return DiscoveryPage();
            //             },
            //           ),
            //         );

            //         // if (selectedDevice != null) {
            //         //   print('Открытие -> выбранный ' + selectedDevice.address);
            //         // } else {
            //         //   print('Открытие -> не выбранный');
            //         // }
            //       }),
            // ),

            const Text('Устройства:'),
            ListTile(
              // title: SelectBondedDevicePage(checkAvailability: false),
              trailing: ElevatedButton(
                child: const Text('Подключитесь'),
                onPressed: () async {
                  final BluetoothDevice? selectedDevice = await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return const SelectBondedDevicePage(checkAvailability: false);
                      },
                    ),
                  );

                  if (selectedDevice != null) {
                    print('Подключить -> выбранны ' + selectedDevice.address);
                    _startChat(context, selectedDevice);
                  } else {
                    print('Подключить -> не выбранны');
                  }
                },
              ),
            ),
            const Divider(),
          //   ListTile(title: const Text('Пример нескольких подключений')),
          //   ListTile(
          //     title: ElevatedButton(
          //       child: ((_collectingTask?.inProgress ?? false)
          //           ? const Text('Отключите и прекратите сбор фоновых данных')
          //           : const Text('Подключитесь, чтобы начать сбор данных')),
          //       onPressed: () async {
          //         if (_collectingTask?.inProgress ?? false) {
          //           await _collectingTask!.cancel();
          //           setState(() {
          //             /* Обновление для `_collectingTask.InProgress` */
          //           });
          //         } else {
          //           final BluetoothDevice? selectedDevice =
          //               await Navigator.of(context).push(
          //             MaterialPageRoute(
          //               builder: (context) {
          //                 return SelectBondedDevicePage(
          //                     checkAvailability: false);
          //               },
          //             ),
          //           );

          //           if (selectedDevice != null) {
          //             await _startBackgroundTask(context, selectedDevice);
          //             setState(() {
          //               /* Обновление для `_collectingTask.InProgress` */
          //             });
          //           }
          //         }
          //       },
          //     ),
          //   ),
          //   ListTile(
          //     title: ElevatedButton(
          //       child: const Text('Просмотр исходных собранных данных'),
          //       onPressed: (_collectingTask != null)
          //           ? () {
          //               Navigator.of(context).push(
          //                 MaterialPageRoute(
          //                   builder: (context) {
          //                     return ScopedModel<BackgroundCollectingTask>(
          //                       model: _collectingTask!,
          //                       child: BackgroundCollectedPage(),
          //                     );
          //                   },
          //                 ),
          //               );
          //             }
          //           : null,
          //     ),
          //   ),
          ],
        ),
    );
  }

  void _startChat(BuildContext context, BluetoothDevice server) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return ChatPage(server: server);
        },
      ),
    );
  }

  Future<void> _startBackgroundTask(
    BuildContext context,
    BluetoothDevice server,
  ) async {
    try {
      _collectingTask = await BackgroundCollectingTask.connect(server);
      await _collectingTask!.start();
    } catch (ex) {
      _collectingTask?.cancel();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Произошла ошибка при подключении'),
            content: Text(ex.toString()),
            actions: <Widget>[
              TextButton(
                child: const Text("Закрыть"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
}
