import 'package:json_annotation/json_annotation.dart';

part 'fr.g.dart';

@JsonSerializable()
class Forecast {
final String name;
final String country;
final List<Weather> list;
  Forecast({
    required this.name,
    required this.country,
    required this.list,
  });

  factory Forecast.fromJson(Map<String, dynamic> json) =>
      _$ForecastFromJson(json);
  Map<String, dynamic> toJson() => _$ForecastToJson(this);
}

@JsonSerializable()
class Weather {
final double temp;
final String description;
final double max;
final double min;
final double speed;
final double deg;
final double humidity;

  Weather({
    required this.temp,
    required this.description,
    required this.max,
    required this.min,
    required this.speed,
    required this.deg,
    required this.humidity,
  });

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherToJson(this);
}





// name , sys.country
// [main][temp]
// [weather] [description]

// main.temp_max, main.temp_min

// wind.speed
// wind.deg
// main.humidity