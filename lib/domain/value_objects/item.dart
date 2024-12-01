import 'package:json_annotation/json_annotation.dart';
import 'package:recyclomator/domain/value_objects/item_type.dart';

part 'item.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Item {
  final ItemType type;
  final int count;

  Item({required this.type, required this.count});

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
  Map<String, dynamic> toJson() => _$ItemToJson(this);
}
