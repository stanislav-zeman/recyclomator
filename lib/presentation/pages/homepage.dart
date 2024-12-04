import 'package:flutter/material.dart';
import 'package:recyclomator/presentation/pages/all_offers_page.dart';
import 'package:recyclomator/presentation/pages/new_offer_page.dart';
import 'package:recyclomator/presentation/pages/user_offers_page.dart';
import 'package:recyclomator/presentation/templates/page.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: Text("Recyclomator"),
      child: Center(
        child: Column(
          children: [
            SizedBox(height: 100),
            buildButton(context, "Create new offer", NewOfferPage()),
            buildButton(context, "My offers", UserOffersPage()),
            buildButton(context, "Show available offers", AllOffersPage()),
          ],
        ),
      ),
    );
  }

  Widget buildButton(BuildContext context, String text, Widget page) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                textStyle: TextStyle(fontSize: 18),
              ),
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => page)),
              child: Text(text),
            ),
          ),
        ),
      ],
    );
  }
}
