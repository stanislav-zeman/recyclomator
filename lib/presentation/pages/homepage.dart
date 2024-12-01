import 'package:flutter/material.dart';
import 'package:recyclomator/presentation/templates/page.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: Text("Homepage"),
      child: Placeholder(),
    );
  }
}
