import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'address_component.g.dart';

@immutable
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AddressComponent {
  const AddressComponent({
    required this.shortText,
    required this.longText,
    required this.types,
  });

  factory AddressComponent.fromJson(Map<String, dynamic> json) => _$AddressComponentFromJson(json);

  final String shortText;
  final String longText;
  final List<String> types;

  Map<String, dynamic> toJson() => _$AddressComponentToJson(this);
}
