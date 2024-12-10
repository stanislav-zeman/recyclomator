import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:recyclomator/domain/entities/offer.dart';
import 'package:recyclomator/domain/value_objects/item_type.dart';
import 'package:recyclomator/domain/value_objects/offer_state.dart';
import 'package:recyclomator/infrastructure/services/user_service.dart';
import 'package:recyclomator/presentation/templates/page.dart';

class OfferDetailPage extends StatelessWidget {
  final Offer offer;
  OfferDetailPage({super.key, required this.offer});

  final _userService = GetIt.I<MockUserService>();

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: Text('Offer'),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('State:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Text('State: ${offer.state}'),
                    Text('Offered at: ${offer.offerDate}'),
                    Text('Recycled at: ${offer.recycleDate ?? "N/A"}'),
                    SizedBox(height: 16),
                    Text('Address:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Text('Address ID: ${offer.addressId}'),
                    SizedBox(height: 16),
                    Text('Details:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Text('ID: ${offer.id}'),
                    Text('Author ID: ${offer.authorId}'),
                    Text('Recyclator ID: ${offer.recyclatorId ?? 'N/A'}'),
                    SizedBox(height: 16),
                    Text('Content:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Text('- Pet bottles: ${_getNumberOfBottles(ItemType.pet)}'),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Text('- Glass bottles: ${_getNumberOfBottles(ItemType.glass)}'),
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
    final userId = _userService.getUser().id;
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
      children: [
        _buildButton('Picked up', () => {}),
        _buildButton('Cancel reservation', () => {}),
      ],
    );
  }

  Widget _buildNotRecyclatorButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildButton('Picked up', () => {}),
        _buildButton('Reserve', () => {}),
      ],
    );
  }

  Widget _buildRecyclatorButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
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
    return offer.items.where((item) => item.type == ItemType.pet).firstOrNull?.count ?? 0;
  }
}
