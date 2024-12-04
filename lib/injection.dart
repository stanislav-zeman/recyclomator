import 'package:get_it/get_it.dart';
import 'package:recyclomator/infrastructure/controllers/offer_controller.dart';
import 'package:recyclomator/infrastructure/services/offer_service.dart';
import 'package:recyclomator/infrastructure/services/user_service.dart';

final get = GetIt.instance;

class Injection {
  static void initialize() {
    get.registerSingleton(MockUserService());
    get.registerSingleton(MockOfferService());
    get.registerSingleton(
        OfferController(get<MockOfferService>(), get<MockUserService>()));
    get.registerSingleton(OfferService());
  }
}
