// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Item _$ItemFromJson(Map<String, dynamic> json) => Item(
      type: $enumDecode(_$ItemTypeEnumMap, json['type']),
      count: (json['count'] as num).toInt(),
    );

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'type': _$ItemTypeEnumMap[instance.type],
      'count': instance.count,
    };

const _$ItemTypeEnumMap = {
  ItemType.pet: 'pet',
  ItemType.glass: 'glass',
};
