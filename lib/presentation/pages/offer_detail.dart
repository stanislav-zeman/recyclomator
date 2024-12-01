import 'package:flutter/material.dart';
import 'package:recyclomator/presentation/templates/page.dart';

class OfferDetail extends StatelessWidget {
  const OfferDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: Text('Offer'),
      child: Text('Offer Detail Page Content'),
    );
  }
}
