import 'package:json_annotation/json_annotation.dart';
import 'package:recyclomator/domain/value_objects/item.dart';
import 'package:recyclomator/domain/value_objects/offer_state.dart';

part 'offer.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Offer {
  final String id;
  final String authorId;
  final String? recyclatorId;
  final String addressId;
  final List<Item> items;
  final OfferState state;

  const Offer({
    required this.id,
    required this.authorId,
    required this.recyclatorId,
    required this.addressId,
    required this.items,
    required this.state,
  });

  factory Offer.fromJson(Map<String, dynamic> json) => _$OfferFromJson(json);
  Map<String, dynamic> toJson() => _$OfferToJson(this);
}
