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
                      offer.state == OfferState.done,
                )
                .toList(),
          );

  Stream<List<Offer>> get historyRecycleStream =>
      _offerRepository.observeDocuments().map(
            (List<Offer> offers) => offers
                .where(
                  (Offer offer) =>
                      offer.recyclatorId == _userService.currentUserId &&
                      offer.state == OfferState.done,
                )
                .toList(),
          );

  Stream<List<Offer>> get takenOffersStream =>
      _offerRepository.observeDocuments().map(
            (List<Offer> offers) => offers
                .where(
                  (Offer offer) =>
                      offer.recyclatorId == _userService.currentUserId &&
                      offer.state != OfferState.done,
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
                      offer.state != OfferState.done,
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
      addressId: '1',
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

  Future<List<Tuple2<Offer, Address>>> get offersMarkers async {
    final List<Offer> offers = await _offerRepository.observeDocuments().first;
    final List<Tuple2<Offer, Address>> tuples = [];

    for (final offer in offers) {
      final address = await _addressRepository.getDocument(offer.addressId);
      if (address == null) {
        continue;
      }
      tuples.add(Tuple2(offer, address));
    }

    return tuples;
  }

  Stream<List<Tuple2<Offer, Address>>> get offersMarkersStream {
    return _offerRepository.observeDocuments().asyncMap((offers) async {
      final List<Tuple2<Offer, Address>> tuples = [];
      for (final offer in offers) {
        final address = await _addressRepository.getDocument(offer.addressId);
        if (address == null) {
          continue;
        }
        tuples.add(Tuple2(offer, address));
      }
      return tuples;
    });
  }

  Future<List<Tuple2<Offer, Address>>> get mockoffersMarkers async {
    final List<Tuple2<Offer, Address>> tuples = [];
    final mockOffers = [
      Offer(
        id: '1',
        authorId: 'author1',
        recyclatorId: 'recyclator1',
        addressId: 'address1',
        items: [
          Item(type: ItemType.pet, count: 10),
          Item(type: ItemType.glass, count: 5),
        ],
        state: OfferState.done,
        offerDate: DateTime.now(),
        recycleDate: DateTime.now().add(Duration(days: 7)),
      ),
      Offer(
        id: '2',
        authorId: 'author2',
        recyclatorId: 'recyclator2',
        addressId: 'address2',
        items: [
          Item(type: ItemType.pet, count: 20),
          Item(type: ItemType.glass, count: 15),
        ],
        state: OfferState.done,
        offerDate: DateTime.now().subtract(Duration(days: 1)),
        recycleDate: DateTime.now().add(Duration(days: 6)),
      ),
    ];
    final mockAddresses = [
      Address(
        id: 'address1',
        name: 'Home',
        street: '123 Main St',
        houseNo: '1A',
        city: 'Brno',
        zipCode: '60200',
        country: 'Czech Republic',
        lat: 49.1951,
        lng: 16.6068,
        userId: 'user1',
      ),
      Address(
        id: 'address2',
        name: 'Office',
        street: '456 Office Rd',
        houseNo: '2B',
        city: 'Brno',
        zipCode: '60200',
        country: 'Czech Republic',
        lat: 49.2000,
        lng: 16.6090,
        userId: 'user2',
      ),
    ];
    for (int i = 0; i < mockOffers.length; i++) {
      tuples.add(Tuple2(mockOffers[i], mockAddresses[i]));
    }
    return tuples;
  }

  Stream<List<Tuple2<Offer, Address>>> get mockOffersMarkersStream {
    return Stream.value([
      Tuple2(
        Offer(
          id: '1',
          authorId: 'author1',
          recyclatorId: 'recyclator1',
          addressId: 'address1',
          items: [
            Item(type: ItemType.pet, count: 10),
            Item(type: ItemType.glass, count: 5),
          ],
          state: OfferState.done,
          offerDate: DateTime.now(),
          recycleDate: DateTime.now().add(Duration(days: 7)),
        ),
        Address(
          id: 'address1',
          name: 'Home',
          street: '123 Main St',
          houseNo: '1A',
          city: 'Brno',
          zipCode: '60200',
          country: 'Czech Republic',
          lat: 49.1951,
          lng: 16.6068,
          userId: 'user1',
        ),
      ),
      Tuple2(
        Offer(
          id: '2',
          authorId: 'author2',
          recyclatorId: 'recyclator2',
          addressId: 'address2',
          items: [
            Item(type: ItemType.pet, count: 20),
            Item(type: ItemType.glass, count: 15),
          ],
          state: OfferState.done,
          offerDate: DateTime.now().subtract(Duration(days: 1)),
          recycleDate: DateTime.now().add(Duration(days: 6)),
        ),
        Address(
          id: 'address2',
          name: 'Office',
          street: '456 Office Rd',
          houseNo: '2B',
          city: 'Brno',
          zipCode: '60200',
          country: 'Czech Republic',
          lat: 49.2000,
          lng: 16.6090,
          userId: 'user2',
        ),
      ),
    ]);
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
