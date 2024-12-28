import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';

import '../../../domain/entities/address.dart';
import '../../../domain/entities/offer.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/value_objects/item.dart';
import '../../../domain/value_objects/item_type.dart';
import '../../../domain/value_objects/offer_state.dart';
import '../../../infrastructure/repositories/firestore.dart';
import '../../../infrastructure/services/user_service.dart';
import '../../pages/addresses_page.dart';
import '../common/sliding_panel_offers_widget.dart';
import 'item_button.dart';

class NewOfferWidget extends StatefulWidget {
  const NewOfferWidget({super.key});

  @override
  State<NewOfferWidget> createState() => _NewOfferWidgetState();
}

class _NewOfferWidgetState extends State<NewOfferWidget> {
  final FirestoreRepository<Offer> _offerRepository =
      GetIt.I<FirestoreRepository<Offer>>();
  final MockUserService _userService = GetIt.I<MockUserService>();
  final ValueNotifier<int> _glassCount = ValueNotifier<int>(0);
  final ValueNotifier<int> _plasticCount = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    final User user = _userService.getUser();
    final User recycler = _userService.getRecycler();

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    'Address:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('address data'),
                  _buildButton('Change address', () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => AddressesPage(
                          addressRepository:
                              GetIt.I<FirestoreRepository<Address>>(),
                        ),
                      ),
                    );
                  }),
                ],
              ),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2, // Number of columns
                  crossAxisSpacing: 8.0, // Spacing between columns
                  mainAxisSpacing: 8.0, // Spacing between rows
                  childAspectRatio: 0.8, // Aspect ratio for each card
                  children: [
                    ItemButton(
                      icon: FontAwesomeIcons.beerMugEmpty,
                      countNotifier: _glassCount,
                    ),
                    ItemButton(
                      icon: FontAwesomeIcons.bottleWater,
                      countNotifier: _plasticCount,
                    ),
                  ],
                ),
              ),
              _buildButton(
                'Submit offer',
                () {
                  _offerRepository.add(
                    Offer(
                      authorId: user.id,
                      recyclatorId: recycler.id,
                      addressId: '1',
                      items: <Item>[
                        Item(type: ItemType.glass, count: _glassCount.value),
                        Item(type: ItemType.pet, count: _glassCount.value),
                      ],
                      state: OfferState.free,
                    ),
                  );
                  Navigator.of(context).pop();
                },
              ),
              SizedBox(
                height: 150,
              ),
            ],
          ),
        ),
        SlidingPanelOffersWidget(
          stream: _offerRepository.observeDocuments(),
        ),
      ],
    );
  }

  Widget _buildButton(String text, VoidCallback call) {
    return Row(
      children: <Widget>[
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
