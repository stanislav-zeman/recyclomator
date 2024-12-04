import 'package:flutter/material.dart';
import 'package:recyclomator/domain/entities/offer.dart';
import 'package:recyclomator/domain/value_objects/offer_type.dart';
import 'package:recyclomator/infrastructure/controllers/offer_controller.dart';
import 'package:recyclomator/injection.dart';
import 'package:recyclomator/presentation/widgets/offers/offer_list.dart';

class OfferListWithButtons extends StatelessWidget {
  final List<Offer> offers;
  final OfferType state;

  OfferListWithButtons({super.key, required this.offers, required this.state});

  final _historyController = get<OfferController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildButtons(state),
        Expanded(child: OfferList(offers: offers)),
      ],
    );
  }

  Widget _buildButtons(OfferType state) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: () => _historyController.changeState(OfferType.offered),
            child: Text('Offers'),
          ),
          ElevatedButton(
            onPressed: () => _historyController.changeState(OfferType.recycled),
            child: Text('Recycles'),
          ),
        ],
      ),
    );
  }
}
