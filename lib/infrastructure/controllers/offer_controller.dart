import 'package:recyclomator/domain/entities/address.dart';
import 'package:recyclomator/domain/entities/offer.dart';
import 'package:recyclomator/domain/value_objects/item.dart';
import 'package:recyclomator/domain/value_objects/item_type.dart';
import 'package:recyclomator/domain/value_objects/offer_state.dart';
import 'package:recyclomator/infrastructure/repositories/firestore.dart';
import 'package:recyclomator/infrastructure/services/user_service.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tuple/tuple.dart';

class OfferController {
  OfferController(
    this._userService,
    this._offerRepository,
    this._addressRepository,
  );

  final UserService _userService;
  final FirestoreRepository<Offer> _offerRepository;
  final FirestoreRepository<Address> _addressRepository;
  final _filterMarkers = BehaviorSubject<bool>.seeded(false);

  late final Stream<bool> filterMarkers = _filterMarkers.stream;

  Stream<List<Offer>> get historyOffersStream =>
      _offerRepository.observeDocuments().map(
            (List<Offer> offers) => offers
                .where(
                  (Offer offer) =>
                      offer.userId == _userService.currentUserId &&
                      offer.state.isFinished,
                )
                .toList(),
          );

  Stream<List<Offer>> get historyRecycleStream =>
      _offerRepository.observeDocuments().map(
            (List<Offer> offers) => offers
                .where(
                  (Offer offer) =>
                      offer.recyclatorId == _userService.currentUserId &&
                      offer.state.isFinished,
                )
                .toList(),
          );

  Stream<List<Tuple2<Offer, Address>>> get offersMarkersStream {
    return Rx.combineLatest2(_offerRepository.observeDocuments(), filterMarkers,
        (offers, filter) {
      return offers.where((offer) {
        if (filter) {
          return offer.recyclatorId == _userService.currentUserId;
        }
        return true;
      }).toList();
    }).asyncMap((offers) async {
      final List<Tuple2<Offer, Address>> tuples = [];
      for (final offer in offers) {
        if (offer.state.isFinished) {
          continue;
        }
        final address = await _addressRepository.getDocument(offer.addressId);
        if (address == null) {
          continue;
        }
        tuples.add(Tuple2(offer, address));
      }
      return tuples;
    });
  }

  Stream<List<Offer>> get providedOffersStream =>
      _offerRepository.observeDocuments().map(
            (List<Offer> offers) => offers
                .where(
                  (Offer offer) =>
                      offer.userId == _userService.currentUserId &&
                      !offer.state.isFinished,
                )
                .toList()
              ..sort((a, b) => b.offerDate.compareTo(a.offerDate)),
          );

  Stream<List<Offer>> get takenOffersStream =>
      _offerRepository.observeDocuments().map(
            (List<Offer> offers) => offers
                .where(
                  (Offer offer) =>
                      offer.recyclatorId == _userService.currentUserId &&
                      !offer.state.isFinished,
                )
                .toList()
              ..sort((a, b) => b.offerDate.compareTo(a.offerDate)),
          );

  Offer addOffer(int glassCount, int plasticCount, String addressId) {
    final offer = Offer(
      userId: _userService.currentUserId,
      recyclatorId: null,
      addressId: addressId,
      items: <Item>[
        Item(type: ItemType.glass, count: glassCount),
        Item(type: ItemType.pet, count: plasticCount),
      ],
      state: OfferState.free,
    );
    _offerRepository.add(
      offer,
    );
    return offer;
  }

  void dispose() {
    _filterMarkers.close();
  }

  Future<int> getNumberOfGlassBottles() async {
    final List<Offer> offers = await _offerRepository.observeDocuments().first;
    return offers
        .where((offer) => offer.userId == _userService.currentUserId)
        .expand((offer) => offer.items)
        .where((item) => item.type == ItemType.glass)
        .fold<int>(0, (sum, item) => sum + item.count);
  }

  Future<int> getNumberOfPlasticBottles() async {
    final List<Offer> offers = await _offerRepository.observeDocuments().first;
    return offers
        .where((offer) => offer.userId == _userService.currentUserId)
        .expand((offer) => offer.items)
        .where((item) => item.type == ItemType.pet)
        .fold<int>(0, (int sum, item) => sum + item.count);
  }

  void setFilterMarkers(bool value) {
    _filterMarkers.add(value);
  }
}
