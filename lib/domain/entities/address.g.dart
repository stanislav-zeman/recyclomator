// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
      id: json['id'] as String,
      userId: json['userId'] as String,
      name: json['name'] as String,
      street: json['street'] as String,
      houseNo: json['houseNo'] as String,
      city: json['city'] as String,
      country: json['country'] as String,
      zipCode: json['zipCode'] as String,
    );

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'name': instance.name,
      'street': instance.street,
      'houseNo': instance.houseNo,
      'city': instance.city,
      'country': instance.country,
      'zipCode': instance.zipCode,
    };
