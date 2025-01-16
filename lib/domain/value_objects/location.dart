import 'package:json_annotation/json_annotation.dart';

part 'location.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Location {
  Location({required this.latitude, required this.longitude});

  factory Location.fromJson(Map<String, dynamic> json) => _$LocationFromJson(json);

  final double latitude;
  final double longitude;

  Map<String, dynamic> toJson() => _$LocationToJson(this);
}
