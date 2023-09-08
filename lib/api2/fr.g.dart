// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fr.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Forecast _$ForecastFromJson(Map<String, dynamic> json) => Forecast(
      name: json['name'] as String,
      country: json['country'] as String,
      list: (json['list'] as List<dynamic>)
          .map((e) => Weather.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ForecastToJson(Forecast instance) => <String, dynamic>{
      'name': instance.name,
      'country': instance.country,
      'list': instance.list,
    };

Weather _$WeatherFromJson(Map<String, dynamic> json) => Weather(
      temp: (json['temp'] as num).toDouble(),
      description: json['description'] as String,
      max: (json['max'] as num).toDouble(),
      min: (json['min'] as num).toDouble(),
      speed: (json['speed'] as num).toDouble(),
      deg: (json['deg'] as num).toDouble(),
      humidity: (json['humidity'] as num).toDouble(),
    );

Map<String, dynamic> _$WeatherToJson(Weather instance) => <String, dynamic>{
      'temp': instance.temp,
      'description': instance.description,
      'max': instance.max,
      'min': instance.min,
      'speed': instance.speed,
      'deg': instance.deg,
      'humidity': instance.humidity,
    };
