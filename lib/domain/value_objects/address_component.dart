import 'package:json_annotation/json_annotation.dart';

part 'address_component.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AddressComponent {
  AddressComponent({required this.shortText, required this.longText});

  factory AddressComponent.fromJson(Map<String, dynamic> json) => _$AddressComponentFromJson(json);

  final String shortText;
  final String longText;

  Map<String, dynamic> toJson() => _$AddressComponentToJson(this);
}
