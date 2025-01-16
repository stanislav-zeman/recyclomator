import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'location.g.dart';

@immutable
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Location {
  const Location({
    required this.latitude,
    required this.longitude,
  });

  factory Location.fromJson(Map<String, dynamic> json) => _$LocationFromJson(json);

  final double latitude;
  final double longitude;

  Map<String, dynamic> toJson() => _$LocationToJson(this);
}
