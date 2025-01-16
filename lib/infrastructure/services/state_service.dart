import 'package:flutter/material.dart';
import 'package:recyclomator/domain/value_objects/offer_type.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StateService with ChangeNotifier {
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
