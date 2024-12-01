// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Offer _$OfferFromJson(Map<String, dynamic> json) => Offer(
      id: json['id'] as String,
      authorId: json['authorId'] as String,
      recyclatorId: json['recyclatorId'] as String?,
      addressId: json['addressId'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => Item.fromJson(e as Map<String, dynamic>))
          .toList(),
      state: $enumDecode(_$OfferStateEnumMap, json['state']),
    );

Map<String, dynamic> _$OfferToJson(Offer instance) => <String, dynamic>{
      'id': instance.id,
      'authorId': instance.authorId,
      if (instance.recyclatorId case final value?) 'recyclatorId': value,
      'addressId': instance.addressId,
      'items': instance.items.map((e) => e.toJson()).toList(),
      'state': _$OfferStateEnumMap[instance.state]!,
    };

const _$OfferStateEnumMap = {
  OfferState.free: 'free',
  OfferState.reserved: 'reserved',
  OfferState.unconfirmed: 'unconfirmed',
};
