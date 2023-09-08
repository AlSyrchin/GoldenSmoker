import 'package:json_annotation/json_annotation.dart';
import '../hotel_json/hotel.dart';
part 'data.g.dart';

@JsonSerializable()
class Data {
  int? id;
  String? name;
  String? adress;
  int? minimalPrice;
  String? priceForIt;
  int? rating;
  String? ratingName;
  List<String>? imageUrls;
  Hotel? aboutHotel;
  Data({
    this.id,
    this.name,
    this.adress,
    this.minimalPrice,
    this.priceForIt,
    this.rating,
    this.ratingName,
    this.imageUrls,
    this.aboutHotel,
});
  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
  Map<String, dynamic> toJson() => _$DataToJson(this);

  Data copyWith(Data d) {
    return Data(
    id:  d.id,
    name: d.name,
    adress: d.adress,
    minimalPrice: d.minimalPrice,
    priceForIt: d.priceForIt,
    rating: d.rating,
    ratingName:  d.ratingName,
    imageUrls:  d.imageUrls,
    aboutHotel:  d.aboutHotel,
    );
  }
}
