// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

import 'room.dart';

part 'rooms.g.dart';

@JsonSerializable()
class Rooms {
  List<Room>? rooms;
  Rooms({
    this.rooms,
  });

  factory Rooms.fromJson(Map<String, dynamic> json) => _$RoomsFromJson(json);
  Map<String, dynamic> toJson() => _$RoomsToJson(this);
}
