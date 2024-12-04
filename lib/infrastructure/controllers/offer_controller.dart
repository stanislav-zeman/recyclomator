import 'package:recyclomator/domain/entities/offer.dart';
import 'package:recyclomator/domain/value_objects/offer_type.dart';
import 'package:recyclomator/infrastructure/repositories/firestore.dart';
import 'package:recyclomator/infrastructure/services/user_service.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tuple/tuple.dart';

class OfferController {
  final FirestoreRepository<Offer> _offerRepository;
  final MockUserService _userService;

  OfferController(this._offerRepository, this._userService);

  final _historyState = BehaviorSubject<OfferType>.seeded(OfferType.offered);

  Stream<OfferType> get historyStateStream => _historyState.stream;

  Stream<Tuple2<OfferType, List<Offer>>> get historyOffersStream =>
      Rx.combineLatest2(
        historyStateStream,
        _offerRepository.observeDocuments(),
        (OfferType state, List<Offer> offers) {
          switch (state) {
            case OfferType.offered:
              return Tuple2(
                state,
                offers
                    .where(
                        (offer) => offer.authorId == _userService.getUser().id)
                    .toList(),
              );
            case OfferType.recycled:
              return Tuple2(
                state,
                offers
                    .where((offer) =>
                        offer.recyclatorId == _userService.getUser().id)
                    .toList(),
              );
          }
        },
      );

  changeState(OfferType offered) {
    _historyState.add(offered);
  }
}
