import 'package:get_it/get_it.dart';
import 'package:recyclomator/domain/entities/address.dart';
import 'package:recyclomator/domain/entities/message.dart';
import 'package:recyclomator/domain/entities/offer.dart';
import 'package:recyclomator/domain/entities/user.dart';
import 'package:recyclomator/infrastructure/controllers/address_controller.dart';
import 'package:recyclomator/infrastructure/controllers/offer_controller.dart';
import 'package:recyclomator/infrastructure/repositories/firestore.dart';
import 'package:recyclomator/infrastructure/services/chat_service.dart';
import 'package:recyclomator/infrastructure/services/places_service.dart';
import 'package:recyclomator/infrastructure/services/state_service.dart';
import 'package:recyclomator/infrastructure/services/user_service.dart';

final GetIt _get = GetIt.instance;

class Injection {
  static void initialize() {
    _registerRepositories();
    _registerServices();
    _registerControllers();
  }

  static void _registerControllers() {
    _get.registerSingleton(
      OfferController(
        _get<UserService>(),
        _get<FirestoreRepository<Offer>>(),
        _get<FirestoreRepository<Address>>(),
      ),
    );
    _get.registerSingleton(
      AddressController(
        _get<UserService>(),
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
    _get.registerSingleton<FirestoreRepository<Message>>(
      FirestoreRepository<Message>(
        'messages',
        fromJson: Message.fromJson,
        toJson: (Message message) => message.toJson(),
      ),
    );
  }

  static void _registerServices() {
    _get.registerSingleton(UserService());
    _get.registerSingleton(PlacesService());
    _get.registerSingleton(StateService());
    _get.registerSingleton(
      ChatService(
        _get<FirestoreRepository<Message>>(),
      ),
    );
  }
}
