import 'package:json_annotation/json_annotation.dart';
part 'hotel.g.dart';

@JsonSerializable()
class Hotel {
  final String description;
  final List<String> peculiarities;
  Hotel({
    required this.description,
    required this.peculiarities,
  });

  factory Hotel.fromJson(Map<String, dynamic> json) => _$HotelFromJson(json);
  Map<String, dynamic> toJson() => _$HotelToJson(this);
}
