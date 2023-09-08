import 'dart:convert';
import 'dart:io';
import 'package:goldensmoker/api2/weather.dart';


class ApiClient {
  final client = HttpClient();

  Future<List<Forecast>> getWeatherList() async { //на 5 дней
    String lat = "58.57";
    String lon = "49.62";
    String apiKey = "66c896dbf01a66c1d84849e6192470f0";
    final url = Uri.parse('https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$lon&lang=ru&appid=$apiKey');
    final request = await client.getUrl(url);
    final response = await request.close();
    final json = await response
        .transform(utf8.decoder)
        .toList()
        .then((value) => value.join())
        .then((v) => jsonDecode(v) as List<dynamic>);
    final result = json
        .map((dynamic e) => Forecast.fromJson(e as Map<String, dynamic>))
        .toList();
    return result;
  }


  Future<Forecast> getWeather() async { //на 1 день
    String lat = "58.57";
    String lon = "49.62";
    String apiKey = "66c896dbf01a66c1d84849e6192470f0";
    final url = Uri.parse('https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&lang=ru&appid=$apiKey');
    final request = await client.getUrl(url);
    final response = await request.close();
    
    final json = await response.transform(utf8.decoder).toList().then((value) => value.join());
    final jsonStr = jsonDecode(json);
    final res = Forecast.fromJson(jsonStr);
    return res;
  }
}


  // extension HttpClientResponseJsonDecode on HttpClientResponse {
  //   Future<dynamic> jsonDecode() async{
  //     return transform(utf8.decoder)
  //       .toList()
  //       .then((value) => value.join())
  //       .then<dynamic>((v) => json.decode(v));
  //   }
  // }