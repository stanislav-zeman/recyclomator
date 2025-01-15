import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../infrastructure/controllers/offer_controller.dart';
import '../templates/page_template.dart';

class StatisticsPage extends StatelessWidget {
  StatisticsPage({super.key});
  static const int bottlesPerTurtle = 50; // 1 turtle saved per 50 bottles
  static const double co2SavedPerGlassBottle = 0.2; // kg co2 saved
  static const double co2SavedPerPlasticBottle = 0.1; // kg co2 saved
  static const double rewardPerBottle = 4.0; // 4 K? per bottle

  final OfferController _offerController = GetIt.I<OfferController>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<int>>(
      future: Future.wait([
        _offerController.getNumberOfGlassBottles(),
        _offerController.getNumberOfPlasticBottles(),
      ]),
      builder: (context, AsyncSnapshot<List<int>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final glassBottles = snapshot.data![0];
          final plasticBottles = snapshot.data![1];

          return PageTemplate(
            title: Text('Statistics'),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _buildText(
                    'Turtles saved: ${_calculateTurtlesSaved(glassBottles, plasticBottles)}',
                  ),
                  _buildText(
                    'CO2: ${_calculateCO2Saved(glassBottles, plasticBottles).toStringAsFixed(2)}kg',
                  ),
                  _buildText(
                    'Money saved: ${_calculateMoneyGivenAway(glassBottles, plasticBottles).toStringAsFixed(2)} K\u010D',
                  ),
                  _buildImage(),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  int _calculateTurtlesSaved(int glass, int plastic) {
    return (glass + plastic) ~/ bottlesPerTurtle;
  }

  double _calculateCO2Saved(int glass, int plastic) {
    return (glass * co2SavedPerGlassBottle) +
        (plastic * co2SavedPerPlasticBottle);
  }

  double _calculateMoneyGivenAway(int glass, int plastic) {
    return (glass + plastic) * rewardPerBottle;
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
  
  Widget _buildImage() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Image.asset(
        'assets/images/turtle.png',
        fit: BoxFit.cover,
      ),
    );
  }
}
