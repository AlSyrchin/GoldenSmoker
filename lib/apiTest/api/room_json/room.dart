import 'package:json_annotation/json_annotation.dart';

part 'room.g.dart';

@JsonSerializable()
class Room {
  int? id;
  String? name;
  int? price;
  String? pricePer;
  List<String>? peculiarities;
  List<String>? imageUrls;

  Room({
    this.id,
    this.name,
    this.price,
    this.pricePer,
    this.peculiarities,
    this.imageUrls,
  });
  
  factory Room.fromJson(Map<String, dynamic> json) => _$RoomFromJson(json);
  Map<String, dynamic> toJson() => _$RoomToJson(this);
}
