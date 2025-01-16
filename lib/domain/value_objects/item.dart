import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'item_type.dart';

part 'item.g.dart';

@immutable
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Item {
  const Item({
    required this.type,
    required this.count,
  });

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  final ItemType type;
  final int count;

  Map<String, dynamic> toJson() => _$ItemToJson(this);
}
