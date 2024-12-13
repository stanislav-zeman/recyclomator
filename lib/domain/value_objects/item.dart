import 'package:json_annotation/json_annotation.dart';
import 'item_type.dart';

part 'item.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Item {
  Item({required this.type, required this.count});

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  final ItemType type;
  final int count;

  Map<String, dynamic> toJson() => _$ItemToJson(this);
}
