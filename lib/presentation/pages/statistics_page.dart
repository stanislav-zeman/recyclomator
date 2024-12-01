import 'package:flutter/material.dart';
import 'package:recyclomator/presentation/templates/page.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: Text('Statistics'),
      child: Text('Statistics Page Content'),
    );
  }
}
