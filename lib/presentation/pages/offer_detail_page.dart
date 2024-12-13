import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../domain/entities/offer.dart';
import '../../domain/value_objects/item.dart';
import '../../domain/value_objects/item_type.dart';
import '../../domain/value_objects/offer_state.dart';
import '../../infrastructure/services/user_service.dart';
import '../templates/page_template.dart';

class OfferDetailPage extends StatelessWidget {
  OfferDetailPage({super.key, required this.offer});

  final Offer offer;

  final MockUserService _userService = GetIt.I<MockUserService>();

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: Text('Offer'),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'State:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('State: ${offer.state}'),
                    Text('Offered at: ${offer.offerDate}'),
                    Text('Recycled at: ${offer.recycleDate ?? "N/A"}'),
                    SizedBox(height: 16),
                    Text(
                      'Address:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('Address ID: ${offer.addressId}'),
                    SizedBox(height: 16),
                    Text(
                      'Details:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('ID: ${offer.id}'),
                    Text('Author ID: ${offer.authorId}'),
                    Text('Recyclator ID: ${offer.recyclatorId ?? 'N/A'}'),
                    SizedBox(height: 16),
                    Text(
                      'Content:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Text(
                        '- Pet bottles: ${_getNumberOfBottles(ItemType.pet)}',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Text(
                        '- Glass bottles: ${_getNumberOfBottles(ItemType.glass)}',
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            _buildButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildButtons() {
    if (offer.state == OfferState.done) {
      return Container();
    }
    final String userId = _userService.getUser().id;
    if (userId == offer.authorId) {
      return _buildCreatorButtons();
    } else if (null == offer.recyclatorId) {
      return _buildNotRecyclatorButtons();
    } else if (userId == offer.recyclatorId) {
      return _buildRecyclatorButtons();
    } else {
      return Container();
    }
  }

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
            .where((Item item) => item.type == ItemType.pet)
            .firstOrNull
            ?.count ??
        0;
  }
}
