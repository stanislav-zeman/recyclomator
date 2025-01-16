// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'places_suggestions_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlacesSuggestionsResponse _$PlacesSuggestionsResponseFromJson(
  Map<String, dynamic> json,
) =>
    PlacesSuggestionsResponse(
      places: (json['places'] as List<dynamic>)
          .map((e) => Place.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PlacesSuggestionsResponseToJson(
  PlacesSuggestionsResponse instance,
) =>
    <String, dynamic>{
      'places': instance.places.map((e) => e.toJson()).toList(),
    };
