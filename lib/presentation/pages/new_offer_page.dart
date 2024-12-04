import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recyclomator/domain/entities/offer.dart';
import 'package:recyclomator/domain/value_objects/item.dart';
import 'package:recyclomator/domain/value_objects/item_type.dart';
import 'package:recyclomator/domain/value_objects/offer_state.dart';
import 'package:recyclomator/infrastructure/services/offer_service.dart';
import 'package:recyclomator/infrastructure/services/user_service.dart';
import 'package:recyclomator/injection.dart';
import 'package:recyclomator/presentation/templates/page.dart';
import 'package:recyclomator/presentation/widgets/item_button.dart';

class NewOfferPage extends StatefulWidget {
  const NewOfferPage({super.key});

  @override
  State<NewOfferPage> createState() => _NewOfferPageState();
}

class _NewOfferPageState extends State<NewOfferPage> {
  final _offerService = get<OfferService>();
  final _userService = get<MockUserService>();
  final ValueNotifier<int> _glassCount = ValueNotifier<int>(0);
  final ValueNotifier<int> _plasticCount = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    final user = _userService.getUser();
    final recycler = _userService.getRecycler();

    return PageTemplate(
      title: Text("New offer"),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  'Address:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text("address data"),
                _buildButton("Change address", () {}),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ItemButton(
                    icon: FontAwesomeIcons.beerMugEmpty,
                    countNotifier: _glassCount),
                ItemButton(
                    icon: FontAwesomeIcons.bottleWater,
                    countNotifier: _plasticCount),
              ],
            ),
            _buildButton(
              "Submit offer",
              () {
                _offerService.createOffer(
                  Offer(
                    authorId: user.id,
                    recyclatorId: recycler.id,
                    addressId: "1",
                    items: [
                      Item(type: ItemType.glass, count: _glassCount.value),
                      Item(type: ItemType.pet, count: _glassCount.value),
                    ],
                    state: OfferState.free,
                  ),
                );
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _buildButton(String text, VoidCallback call) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                textStyle: TextStyle(fontSize: 18),
              ),
              onPressed: call,
              child: Text(text),
            ),
          ),
        ),
      ],
    );
  }
}
