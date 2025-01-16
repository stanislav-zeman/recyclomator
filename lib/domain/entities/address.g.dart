// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
      id: json['id'] as String?,
      userId: json['userId'] as String,
      name: json['name'] as String,
      place: Place.fromJson(json['place'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      'userId': instance.userId,
      'name': instance.name,
      'place': instance.place.toJson(),
    };
