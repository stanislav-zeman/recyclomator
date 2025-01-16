import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:recyclomator/domain/entities/place.dart';

part 'address.g.dart';

@immutable
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Address {
  const Address({
    this.id,
    required this.userId,
    required this.name,
    required this.place,
  });

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  final String? id;
  final String userId;
  final String name;
  final Place place;

  Map<String, dynamic> toJson() => _$AddressToJson(this);

  @override
  bool operator ==(Object other) =>
      other is Address && other.runtimeType == runtimeType && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
