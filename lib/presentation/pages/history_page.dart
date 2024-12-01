import 'package:flutter/material.dart';
import 'package:recyclomator/presentation/templates/page.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: Text('History'),
      child: Text('This is the history page'),
    );
  }
}
