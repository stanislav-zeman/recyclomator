import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:recyclomator/presentation/pages/offer_detail_page.dart';

import '../../../domain/entities/address.dart';
import '../../../infrastructure/controllers/offer_controller.dart';
import '../../../infrastructure/repositories/firestore.dart';
import '../../pages/addresses_page.dart';
import '../common/sliding_panel_offers_widget.dart';
import 'item_button.dart';

class NewOfferWidget extends StatefulWidget {
  const NewOfferWidget({super.key});

  @override
  State<NewOfferWidget> createState() => _NewOfferWidgetState();
}

class _NewOfferWidgetState extends State<NewOfferWidget> {
  final OfferController _offerController = GetIt.I<OfferController>();
  final ValueNotifier<int> _glassCount = ValueNotifier<int>(0);
  final ValueNotifier<int> _plasticCount = ValueNotifier<int>(0);

  @override
  void dispose() {
    _glassCount.dispose();
    _plasticCount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  Text('address data'), // TODO: Add current address data
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
                  if (_glassCount.value == 0 && _plasticCount.value == 0) {
                    return;
                  }
                  final offer = _offerController.addOffer(
                    _glassCount.value,
                    _plasticCount.value,
                  );
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => OfferDetailPage(offer: offer),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 150,
              ),
            ],
          ),
        ),
        SlidingPanelOffersWidget(
          stream: _offerController.providedOffersStream,
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
