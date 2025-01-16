import 'package:json_annotation/json_annotation.dart';
import 'package:recyclomator/domain/value_objects/address_component.dart';
import 'package:recyclomator/domain/value_objects/location.dart';

part 'place.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Place {
  const Place({
    required this.id,
    required this.name,
    required this.formattedAddress,
    required this.addressComponents,
    required this.location,
  });

  factory Place.fromJson(Map<String, dynamic> json) => _$PlaceFromJson(json);

  final String id;
  final String name;
  final String formattedAddress;
  final List<AddressComponent> addressComponents;
  final Location location;

  Map<String, dynamic> toJson() => _$PlaceToJson(this);
}
