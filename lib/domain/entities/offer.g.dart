// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Offer _$OfferFromJson(Map<String, dynamic> json) => Offer(
      id: json['id'] as String?,
      userId: json['userId'] as String,
      recyclatorId: json['recyclatorId'] as String?,
      addressId: json['addressId'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => Item.fromJson(e as Map<String, dynamic>))
          .toList(),
      state: $enumDecode(_$OfferStateEnumMap, json['state']),
      offerDate: json['offerDate'] == null
          ? null
          : DateTime.parse(json['offerDate'] as String),
      recycleDate: json['recycleDate'] == null
          ? null
          : DateTime.parse(json['recycleDate'] as String),
    );

Map<String, dynamic> _$OfferToJson(Offer instance) => <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      'userId': instance.userId,
      if (instance.recyclatorId case final value?) 'recyclatorId': value,
      'addressId': instance.addressId,
      'items': instance.items.map((e) => e.toJson()).toList(),
      'state': _$OfferStateEnumMap[instance.state],
      'offerDate': instance.offerDate.toIso8601String(),
      if (instance.recycleDate?.toIso8601String() case final value?)
        'recycleDate': value,
    };

const _$OfferStateEnumMap = {
  OfferState.free: 'free',
  OfferState.reserved: 'reserved',
  OfferState.unconfirmed: 'unconfirmed',
  OfferState.done: 'done',
  OfferState.canceled: 'canceled',
};
