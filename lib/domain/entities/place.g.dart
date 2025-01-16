// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Place _$PlaceFromJson(Map<String, dynamic> json) => Place(
      id: json['id'] as String,
      name: json['name'] as String,
      formattedAddress: json['formattedAddress'] as String,
      addressComponents: (json['addressComponents'] as List<dynamic>)
          .map((e) => AddressComponent.fromJson(e as Map<String, dynamic>))
          .toList(),
      location: Location.fromJson(json['location'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PlaceToJson(Place instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'formattedAddress': instance.formattedAddress,
      'addressComponents': instance.addressComponents.map((e) => e.toJson()).toList(),
      'location': instance.location.toJson(),
    };
