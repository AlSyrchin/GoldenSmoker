// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'bron.g.dart';

@JsonSerializable()
class Bron {
  int? id;
  String? hotelName;
  String? hotelAdress;
  int? horating;
  String? ratingName;
  String? departure;
  String? arrivalCountry;
  String? tourDateStart;
  String? tourDateStop;
  int? numberNights;
  String? room;
  String? nutrition;
  int? tourPrice;
  int? fuelCharge;
  int? serviceCharge;
  Bron({
    this.id,
    this.hotelName,
    this.hotelAdress,
    this.horating,
    this.ratingName,
    this.departure,
    this.arrivalCountry,
    this.tourDateStart,
    this.tourDateStop,
    this.numberNights,
    this.room,
    this.nutrition,
    this.tourPrice,
    this.fuelCharge,
    this.serviceCharge,
  });


  factory Bron.fromJson(Map<String, dynamic> json) => _$BronFromJson(json);
  Map<String, dynamic> toJson() => _$BronToJson(this);
}
