import 'package:flutter/material.dart';
import 'package:recyclomator/presentation/templates/page.dart';

class UserOffersPage extends StatelessWidget {
  const UserOffersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: Text('User Offers'),
      child: Text('No offers available.'),
    );
  }
}
