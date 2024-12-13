import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../../domain/entities/offer.dart';
import '../../../domain/value_objects/offer_type.dart';
import '../../../infrastructure/controllers/offer_controller.dart';
import 'offer_list.dart';

class OfferListWithButtons extends StatelessWidget {
  OfferListWithButtons({super.key, required this.offers, required this.state});

  final List<Offer> offers;
  final OfferType state;

  final OfferController _historyController = GetIt.I<OfferController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
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
        children: <Widget>[
          ElevatedButton(
            onPressed: () => _historyController.saveState(OfferType.offered),
            child: Text('Offers'),
          ),
          ElevatedButton(
            onPressed: () => _historyController.saveState(OfferType.recycled),
            child: Text('Recycles'),
          ),
        ],
      ),
    );
  }
}
