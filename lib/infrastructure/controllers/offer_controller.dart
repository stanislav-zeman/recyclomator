import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tuple/tuple.dart';

import '../../domain/entities/address.dart';
import '../../domain/entities/offer.dart';
import '../../domain/value_objects/item.dart';
import '../../domain/value_objects/item_type.dart';
import '../../domain/value_objects/offer_state.dart';
import '../../domain/value_objects/offer_type.dart';
import '../repositories/firestore.dart';
import '../services/user_service.dart';

class OfferController {
  OfferController(
    this._offerRepository,
    this._userService,
    this._addressRepository,
  );
  final FirestoreRepository<Offer> _offerRepository;
  final FirestoreRepository<Address> _addressRepository;
  final UserService _userService;

  Stream<List<Offer>> get historyOffersStream =>
      _offerRepository.observeDocuments().map(
            (List<Offer> offers) => offers
                .where(
                  (Offer offer) =>
                      offer.authorId == _userService.currentUserId &&
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

  Stream<List<Offer>> get providedOffersStream =>
      _offerRepository.observeDocuments().map(
            (List<Offer> offers) => offers
                .where(
                  (Offer offer) =>
                      offer.authorId == _userService.currentUserId &&
                      !offer.state.isFinished,
                )
                .toList()
              ..sort((a, b) => b.offerDate.compareTo(a.offerDate)),
          );

  Future<int> getNumberOfGlassBottles() async {
    final List<Offer> offers = await _offerRepository.observeDocuments().first;
    return offers
        .where((offer) => offer.authorId == _userService.currentUserId)
        .expand((offer) => offer.items)
        .where((item) => item.type == ItemType.glass)
        .fold<int>(0, (sum, item) => sum + item.count);
  }

  Future<int> getNumberOfPlasticBottles() async {
    final List<Offer> offers = await _offerRepository.observeDocuments().first;
    return offers
        .where((offer) => offer.authorId == _userService.currentUserId)
        .expand((offer) => offer.items)
        .where((item) => item.type == ItemType.pet)
        .fold<int>(0, (int sum, item) => sum + item.count);
  }

  Offer addOffer(int glassCount, int plasticCount) {
    final offer = Offer(
      authorId: _userService.currentUserId,
      recyclatorId: null,
      addressId: 'xHYjhsySulEyFqGsgf4a', // TODO: Add selected address
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

  final _filterMarkers = BehaviorSubject<bool>.seeded(false);
  late final Stream<bool> filterMarkers = _filterMarkers.stream;

  void setFilterMarkers(bool value) {
    _filterMarkers.add(value);
  }

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
        final address = await _addressRepository.getDocument(offer
            .addressId); // TODO: Should use some address controller function
        if (address == null || address.lat == null || address.lng == null) {
          continue;
        }
        tuples.add(Tuple2(offer, address));
      }
      return tuples;
    });
  }

  void dispose() {
    _filterMarkers.close();
  }

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
