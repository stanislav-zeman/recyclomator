import 'package:flutter/material.dart';
import 'package:recyclomator/presentation/templates/page.dart';

class AllOffersPage extends StatelessWidget {
  const AllOffersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: Text('All Offers'),
      child: Text('All offers will be displayed here'),
    );
  }
}
