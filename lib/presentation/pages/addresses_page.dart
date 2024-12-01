import 'package:flutter/material.dart';
import 'package:recyclomator/presentation/templates/page.dart';

class AddressesPage extends StatelessWidget {
  const AddressesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: Text("Addresses"),
      child: Center(child: Text("This is the addresses page")),
    );
  }
}
