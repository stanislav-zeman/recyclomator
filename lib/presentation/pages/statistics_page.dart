import 'package:flutter/material.dart';
import '../templates/page_template.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: Text('Statistics'),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildText('Turtles saved: 2'),
            _buildText('CO2: 2kg'),
            _buildText(r'Money given away: $20'),
          ],
        ),
      ),
    );
  }

  Widget _buildText(String text) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        text,
        style: TextStyle(fontSize: 32),
      ),
    );
  }
}
