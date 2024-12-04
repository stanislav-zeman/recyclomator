import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recyclomator/domain/entities/offer.dart';
import 'package:recyclomator/domain/value_objects/item.dart';
import 'package:recyclomator/domain/value_objects/item_type.dart';
import 'package:recyclomator/domain/value_objects/offer_state.dart';

class OfferService {
  static const _collectionName = 'offers';
  final _offerCollection = FirebaseFirestore.instance
      .collection(_collectionName)
      .withConverter<Offer>(
    fromFirestore: (snapshot, options) {
      final json = snapshot.data() ?? {};
      json['id'] = snapshot.id;
      return Offer.fromJson(json);
    },
    toFirestore: (offer, options) {
      final json = offer.toJson();
      json.remove('id');
      return json;
    },
  );

  Stream<List<Offer>> get offersStream =>
      _offerCollection.snapshots().map((querySnapshot) =>
          querySnapshot.docs.map((docSnapshot) => docSnapshot.data()).toList());

  Future<void> createOffer(Offer offer) {
    return _offerCollection.add(offer);
  }

  Future<void> deleteOffer(String offerId) {
    return _offerCollection.doc(offerId).delete();
  }
}

class MockOfferService extends OfferService {
  final List<Offer> _mockOffers = [
    Offer(
      id: '1',
      authorId: '1',
      recyclatorId: '2',
      addressId: '2',
      items: [
        Item(type: ItemType.glass, count: 1),
        Item(type: ItemType.pet, count: 2)
      ],
      state: OfferState.free,
    ),
    Offer(
      id: '2',
      authorId: '2',
      recyclatorId: '1',
      addressId: '1',
      items: [
        Item(type: ItemType.pet, count: 3),
        Item(type: ItemType.pet, count: 4)
      ],
      state: OfferState.free,
    ),
  ];
  @override
  Stream<List<Offer>> get offersStream => Stream.value(_mockOffers);

  @override
  Future<void> createOffer(Offer offer) async {
    _mockOffers.add(offer);
  }

  @override
  Future<void> deleteOffer(String offerId) async {
    _mockOffers.removeWhere((offer) => offer.id == offerId);
  }
}
