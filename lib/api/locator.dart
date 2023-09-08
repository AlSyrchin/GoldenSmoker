import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'dart:async';

// Авторизация с Firebase с безопасностью
// Геолокация
// Сервис данных

// Подгрузка данных заранее, для оффлайн
// Логика на GetX
// Адаптивность


// key api: 66c896dbf01a66c1d84849e6192470f0
// name: test

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData.dark(),
      home: const HomePage(),
      getPages: [
        GetPage(name: "/", page: () => const HomePage()),
      ],
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
/*
  используются serviceEnabled и PermissionGranted.
  чтобы проверить, включена ли служба определения местоположения и предоставлено ли разрешение
  */
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;

  LocationData? _userLocation;

// Эта функция получит местоположение пользователя
  Future<void> _getUserLocation() async {
    Location location = Location();

// Проверьте, включена ли служба определения местоположения
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

// Проверьте, предоставлено ли разрешение
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    final locationData = await location.getLocation();
    setState(() {
      _userLocation = locationData;
      print('${_userLocation?.latitude} \n ${_userLocation?.longitude}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: _getUserLocation,
                  child: const Text('Check Location')),
              const SizedBox(height: 25),
              _userLocation != null
                  ? Wrap(
                      children: [
                        Text('Your latitude: ${_userLocation?.latitude}'),
                        const SizedBox(width: 10),
                        Text('Your longtitude: ${_userLocation?.longitude}')
                      ],
                    )
                  : const Text(
                      'Please enable location service and grant permission')
            ],
          ),
        ),
      ),
    );
  }
}

class SApiClient {
//   void getUrl(){
//     fetch('http://api.openweathermap.org/data/2.5/weather?q=Moscow&appid=YOUR_API_KEY')
// .then(response => response.json())
// .then(data => console.log(data))
// .catch(error => console.error(error))
//   }
}