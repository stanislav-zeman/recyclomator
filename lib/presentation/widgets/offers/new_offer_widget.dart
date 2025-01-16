import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:recyclomator/domain/entities/address.dart';
import 'package:recyclomator/infrastructure/controllers/address_controller.dart';
import 'package:recyclomator/infrastructure/controllers/offer_controller.dart';
import 'package:recyclomator/presentation/pages/addresses_page.dart';
import 'package:recyclomator/presentation/pages/offer_detail_page.dart';
import 'package:recyclomator/presentation/widgets/common/sliding_panel_offers_widget.dart';
import 'package:recyclomator/presentation/widgets/common/stream_widget.dart';
import 'package:recyclomator/presentation/widgets/offers/item_button.dart';

class NewOfferWidget extends StatefulWidget {
  NewOfferWidget({super.key});

  final AddressController _addressController = GetIt.I<AddressController>();

  @override
  State<NewOfferWidget> createState() => _NewOfferWidgetState();
}

class _NewOfferWidgetState extends State<NewOfferWidget> {
  final OfferController _offerController = GetIt.I<OfferController>();
  final ValueNotifier<int> _glassCount = ValueNotifier<int>(0);
  final ValueNotifier<int> _plasticCount = ValueNotifier<int>(0);
  Address? _selectedAddress;

  @override
  Widget build(BuildContext context) {
    return StreamWidget(
      stream: widget._addressController.userAddresses,
      onData: (addresses) => _buildStack(context, addresses),
    );
  }

  @override
  void dispose() {
    _glassCount.dispose();
    _plasticCount.dispose();
    super.dispose();
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

  Widget _buildStack(BuildContext context, List<Address> addresses) {
    if (addresses.isEmpty) {
      return Center(
        child: Column(
          children: [
            Spacer(),
            Text(
              "Add an address to create offers",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                textStyle: TextStyle(fontSize: 18),
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => AddressesPage(),
                  ),
                );
              },
              child: Text("Create address"),
            ),
            Spacer(),
          ],
        ),
      );
    }

    _selectedAddress = addresses[0];
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
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  DropdownButton(
                    items: addresses
                        .map<DropdownMenuItem<Address>>((Address address) {
                      return DropdownMenuItem<Address>(
                        value: address,
                        child: Text(address.name),
                      );
                    }).toList(),
                    onChanged: (address) {
                      setState(() {
                        _selectedAddress = address;
                      });
                    },
                    hint: Center(
                      child: Text("Set address"),
                    ),
                    value: _selectedAddress,
                  ),
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
                  if ((_glassCount.value == 0 && _plasticCount.value == 0) ||
                      _selectedAddress == null) {
                    return;
                  }

                  final offer = _offerController.addOffer(
                    _glassCount.value,
                    _plasticCount.value,
                    _selectedAddress!.id!,
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
}
