import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/offer.dart';
import '../../domain/value_objects/item.dart';
import '../../domain/value_objects/item_type.dart';
import '../../infrastructure/services/user_service.dart';
import '../templates/page_template.dart';

class OfferDetailPage extends StatelessWidget {
  OfferDetailPage({super.key, required this.offer});

  final Offer offer;

  final MockUserService _userService = GetIt.I<MockUserService>();

  Widget _buildCreatorButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _buildButton('Picked up', () => {}),
        _buildButton('Cancel reservation', () => {}),
      ],
    );
  }

  Widget _buildNotRecyclatorButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _buildButton('Picked up', () => {}),
        _buildButton('Reserve', () => {}),
      ],
    );
  }

  Widget _buildRecyclatorButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _buildButton('Confirm pickup', () => {}),
        _buildButton('Still valid', () => {}),
        _buildButton('Cancel', () => {}),
      ],
    );
  }

  Widget _buildButton(String text, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
    );
  }

  int _getNumberOfBottles(ItemType type) {
    return offer.items
            .where((Item item) => item.type == type)
            .firstOrNull
            ?.count ??
        0;
  }

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: Text('Offer'),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Text(
                'Status: ${offer.state.name}',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2, // Number of columns
                crossAxisSpacing: 8.0, // Spacing between columns
                mainAxisSpacing: 8.0, // Spacing between rows
                childAspectRatio: 1, // Aspect ratio for each card
                children: [
                  _buildCard(Icons.home, '${offer.addressId}'),
                  _buildCard(
                    Icons.calendar_month,
                    'Offer date: ${DateFormat('dd/MM/yyyy').format(offer.offerDate)}\nRecycle date: ${offer.recycleDate != null ? DateFormat('dd/MM/yyyy').format(offer.recycleDate!) : "N/A"}',
                  ),
                  _buildCard(
                    FontAwesomeIcons.beerMugEmpty,
                    'Ammount: ${_getNumberOfBottles(ItemType.glass)}',
                  ),
                  _buildCard(
                    FontAwesomeIcons.bottleWater,
                    'Ammount: ${_getNumberOfBottles(ItemType.pet)}',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(IconData icon, String label) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 60.0,
          ),
          SizedBox(height: 10.0),
          Text(
            label,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
