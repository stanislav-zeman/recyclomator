import 'package:flutter/material.dart';
import 'package:recyclomator/domain/entities/offer.dart';
import 'package:recyclomator/domain/value_objects/item_type.dart';
import 'package:recyclomator/presentation/pages/offer_detail_page.dart';

class OfferList extends StatelessWidget {
  final List<Offer> offers;

  const OfferList({super.key, required this.offers});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: offers.length,
      separatorBuilder: (_, __) => Divider(),
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('Offer: ${offers[index].offerDate}'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Pet bottles: ${_getNumberOfBottles(ItemType.pet, index)}'),
              Text(
                  'Glass bottles: ${_getNumberOfBottles(ItemType.glass, index)}'),
            ],
          ),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => OfferDetailPage(offer: offers[index]))),
        );
      },
    );
  }

  int _getNumberOfBottles(ItemType type, int index) {
    return offers[index]
            .items
            .where((x) => x.type == ItemType.pet)
            .firstOrNull
            ?.count ??
        0;
  }
}
