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

  Offer copyWith({
    String? id,
    String? authorId,
    String? recyclatorId,
    String? addressId,
    List<Item>? items,
    OfferState? state,
    DateTime? offerDate,
    DateTime? recycleDate,
  }) {
    return Offer(
      id: id ?? this.id,
      authorId: authorId ?? this.authorId,
      recyclatorId: recyclatorId?.isEmpty ?? true ? null : recyclatorId,
      addressId: addressId ?? this.addressId,
      items: items ?? this.items,
      state: state ?? this.state,
      offerDate: offerDate ?? this.offerDate,
      recycleDate: recycleDate ?? this.recycleDate,
    );
  }
}
