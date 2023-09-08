// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rooms.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Rooms _$RoomsFromJson(Map<String, dynamic> json) => Rooms(
      rooms: (json['rooms'] as List<dynamic>)
          .map((e) => Room.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RoomsToJson(Rooms instance) => <String, dynamic>{
      'rooms': instance.rooms,
    };
