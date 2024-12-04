import 'package:recyclomator/domain/entities/offer.dart';
import 'package:recyclomator/infrastructure/repositories/firestore.dart';

class OfferService {
  final FirestoreRepository<Offer> _offerCollection;

  OfferService(this._offerCollection);

  Stream<List<Offer>> get offersStream => _offerCollection.observeDocuments();

  Future<void> createOffer(Offer offer) {
    return _offerCollection.add(offer);
  }

  Future<void> deleteOffer(String offerId) {
    return _offerCollection.delete(offerId);
  }

  Future<void> updateOffer(Offer offer) {
    if (offer.id == null) {
      return Future.value();
    }
    return _offerCollection.setOrAdd(offer.id!, offer);
  }
}
