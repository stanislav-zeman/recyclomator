import 'package:flutter/material.dart';

import '../templates/tab_page_template.dart';
import '../widgets/offers/display_offers_widget.dart';
import '../widgets/offers/new_offer_widget.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return TabPageTemplate(
      title: Text('Recyclomator'),
      showSideMenu: true,
      children: const <Widget>[
        NewOfferWidget(),
        DisplayOffersWidget(),
      ],
    );
  }
}
