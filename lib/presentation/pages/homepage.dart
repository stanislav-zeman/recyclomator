import 'package:flutter/material.dart';
import 'package:recyclomator/presentation/widgets/offers/display_offers_widget.dart';
import 'package:recyclomator/presentation/widgets/offers/new_offer_widget.dart';
import 'package:recyclomator/presentation/templates/tab_page_template.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return TabPageTemplate(
      title: Text("Recyclomator"),
      children: const [
        NewOfferWidget(),
        DisplayOffersWidget(),
      ],
    );
  }
}
