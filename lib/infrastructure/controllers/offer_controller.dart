import 'package:recyclomator/domain/entities/offer.dart';
import 'package:recyclomator/domain/value_objects/offer_type.dart';
import 'package:recyclomator/infrastructure/repositories/firestore.dart';
import 'package:recyclomator/infrastructure/services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OfferController {
  final FirestoreRepository<Offer> _offerRepository;
  final MockUserService _userService;

  OfferController(this._offerRepository, this._userService);

  Stream<List<Offer>> get historyOffersStream =>
      _offerRepository.observeDocuments().map(
            (offers) => offers
                .where((offer) => offer.authorId == _userService.getUser().id)
                .toList(),
          );

  Stream<List<Offer>> get historyRecycleStream => _offerRepository
      .observeDocuments()
      .map(
        (offers) => offers
            .where((offer) => offer.recyclatorId == _userService.getUser().id)
            .toList(),
      );

  Future<OfferType> loadState() async {
    final prefs = await SharedPreferences.getInstance();
    final offerState = prefs.getString('offer_state');
    if (offerState == null) {
      return OfferType.offered;
    }
    return OfferType.values.firstWhere(
      (type) => type.name == offerState,
      orElse: () => OfferType.offered,
    );
  }

  Future<void> saveState(OfferType offered) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('offer_state', offered.name);
  }
}
