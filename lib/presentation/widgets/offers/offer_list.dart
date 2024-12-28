import 'package:flutter/material.dart';

import '../../../domain/entities/offer.dart';
import '../../../domain/value_objects/item.dart';
import '../../../domain/value_objects/item_type.dart';
import '../../pages/offer_detail_page.dart';

class OfferList extends StatelessWidget {
  const OfferList({super.key, required this.offers, this.scrollController});

  final List<Offer> offers;
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: scrollController,
      itemCount: offers.length,
      separatorBuilder: (_, __) => Divider(),
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text('Offer: ${offers[index].offerDate}'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Pet bottles: ${_getNumberOfBottles(ItemType.pet, index)}'),
              Text(
                'Glass bottles: ${_getNumberOfBottles(ItemType.glass, index)}',
              ),
            ],
          ),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (_) => OfferDetailPage(offer: offers[index]),
            ),
          ),
        );
      },
    );
  }

  int _getNumberOfBottles(ItemType type, int index) {
    return offers[index]
            .items
            .where((Item x) => x.type == ItemType.pet)
            .firstOrNull
            ?.count ??
        0;
  }
}
