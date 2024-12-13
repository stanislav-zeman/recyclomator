import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/offer.dart';
import '../../domain/value_objects/offer_type.dart';
import '../repositories/firestore.dart';
import '../services/user_service.dart';

class OfferController {
  OfferController(this._offerRepository, this._userService);
  final FirestoreRepository<Offer> _offerRepository;
  final MockUserService _userService;

  Stream<List<Offer>> get historyOffersStream => _offerRepository
      .observeDocuments()
      .map(
        (List<Offer> offers) => offers
            .where((Offer offer) => offer.authorId == _userService.getUser().id)
            .toList(),
      );

  Stream<List<Offer>> get historyRecycleStream =>
      _offerRepository.observeDocuments().map(
            (List<Offer> offers) => offers
                .where(
                  (Offer offer) =>
                      offer.recyclatorId == _userService.getUser().id,
                )
                .toList(),
          );

  Future<OfferType> loadState() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? offerState = prefs.getString('offer_state');
    if (offerState == null) {
      return OfferType.offered;
    }
    return OfferType.values.firstWhere(
      (OfferType type) => type.name == offerState,
      orElse: () => OfferType.offered,
    );
  }

  Future<void> saveState(OfferType offered) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('offer_state', offered.name);
  }
}
