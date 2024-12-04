import 'package:get_it/get_it.dart';
import 'package:recyclomator/domain/entities/address.dart';
import 'package:recyclomator/domain/entities/offer.dart';
import 'package:recyclomator/domain/entities/user.dart';
import 'package:recyclomator/infrastructure/repositories/firestore.dart';

final get = GetIt.instance;

class Injection {
  static void initialize() {
        _registerRepositories();
    }

  static void _registerRepositories() {
    get.registerSingleton<FirestoreRepository<Address>>(FirestoreRepository<Address>(
      "addresses",
      fromJson: Address.fromJson,
      toJson: (address) => address.toJson(),
    ));
    get.registerSingleton<FirestoreRepository<Offer>>(FirestoreRepository<Offer>(
      "addresses",
      fromJson: Offer.fromJson,
      toJson: (offer) => offer.toJson(),
    ));
    get.registerSingleton<FirestoreRepository<User>>(FirestoreRepository<User>(
      "users",
      fromJson: User.fromJson,
      toJson: (user) => user.toJson(),
    ));
  }
}
