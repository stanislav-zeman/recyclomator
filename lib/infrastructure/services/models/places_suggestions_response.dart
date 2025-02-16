import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:recyclomator/domain/entities/place.dart';

part 'places_suggestions_response.g.dart';

@immutable
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class PlacesSuggestionsResponse {
  const PlacesSuggestionsResponse({
    required this.places,
  });

  factory PlacesSuggestionsResponse.fromJson(Map<String, dynamic> json) =>
      _$PlacesSuggestionsResponseFromJson(json);

  final List<Place> places;

  Map<String, dynamic> toJson() => _$PlacesSuggestionsResponseToJson(this);
}
