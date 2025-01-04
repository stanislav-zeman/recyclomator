import 'package:get_it/get_it.dart';

import 'domain/entities/address.dart';
import 'domain/entities/offer.dart';
import 'domain/entities/user.dart';
import 'infrastructure/controllers/offer_controller.dart';
import 'infrastructure/repositories/firestore.dart';
import 'infrastructure/services/user_service.dart';

final GetIt _get = GetIt.instance;

class Injection {
  static void initialize() {
    _registerRepositories();

    _get.registerSingleton(MockUserService());
    _get.registerSingleton(
      OfferController(
        _get<FirestoreRepository<Offer>>(),
        _get<MockUserService>(),
        _get<FirestoreRepository<Address>>(),
      ),
    );
  }

  static void _registerRepositories() {
    _get.registerSingleton<FirestoreRepository<Address>>(
      FirestoreRepository<Address>(
        'addresses',
        fromJson: Address.fromJson,
        toJson: (Address address) => address.toJson(),
      ),
    );
    _get.registerSingleton<FirestoreRepository<Offer>>(
      FirestoreRepository<Offer>(
        'offers',
        fromJson: Offer.fromJson,
        toJson: (Offer offer) => offer.toJson(),
      ),
    );
    _get.registerSingleton<FirestoreRepository<User>>(
      FirestoreRepository<User>(
        'users',
        fromJson: User.fromJson,
        toJson: (User user) => user.toJson(),
      ),
    );
  }
}
