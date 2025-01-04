import 'package:json_annotation/json_annotation.dart';

part 'address.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Address {
  const Address({
    required this.id,
    required this.userId,
    required this.name,
    required this.street,
    required this.houseNo,
    required this.city,
    required this.country,
    required this.zipCode,
    required this.lat,
    required this.lng,
  });

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  final String id;
  final String userId;
  final String name;
  final String street;
  final String houseNo;
  final String city;
  final String country;
  final String zipCode;
  final double lat;
  final double lng;

  Map<String, dynamic> toJson() => _$AddressToJson(this);
}
