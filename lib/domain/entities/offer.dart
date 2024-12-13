import 'package:json_annotation/json_annotation.dart';
import '../value_objects/item.dart';
import '../value_objects/offer_state.dart';

part 'offer.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Offer {
  Offer({
    this.id,
    required this.authorId,
    required this.recyclatorId,
    required this.addressId,
    required this.items,
    required this.state,
    DateTime? offerDate,
    this.recycleDate,
  }) : offerDate = offerDate ?? DateTime.now();

  factory Offer.fromJson(Map<String, dynamic> json) => _$OfferFromJson(json);

  final String? id;
  final String authorId;
  final String? recyclatorId;
  final String addressId;
  final List<Item> items;
  final OfferState state;
  final DateTime offerDate;
  final DateTime? recycleDate;

  Map<String, dynamic> toJson() => _$OfferToJson(this);
}
