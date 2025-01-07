import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/offer.dart';
import '../../domain/value_objects/item.dart';
import '../../domain/value_objects/item_type.dart';
import '../../domain/value_objects/offer_state.dart';
import '../../infrastructure/repositories/firestore.dart';
import '../../infrastructure/services/user_service.dart';
import '../templates/page_template.dart';

class OfferDetailPage extends StatelessWidget {
  OfferDetailPage({super.key, required this.offer});

  final Offer offer;

  final MockUserService _userService = GetIt.I<MockUserService>();

  final FirestoreRepository<Offer> _offerRepository =
      GetIt.I<FirestoreRepository<Offer>>();

  Widget _buildCreatorButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _buildButton(
          'Picked up',
          () => _offerRepository.setOrAdd(
            offer.id!,
            offer.copyWith(state: OfferState.done),
          ),
          Colors.green,
        ),
        _buildButton(
          'Still valid',
          () => _offerRepository.setOrAdd(
            offer.id!,
            offer.copyWith(
              state: OfferState.free,
            ),
          ),
          Colors.orange,
        ),
        _buildButton(
          'Cancel reservation',
          () => _offerRepository.setOrAdd(
            offer.id!,
            offer.copyWith(
              state: OfferState.canceled,
            ),
          ),
          Colors.red,
        ),
      ],
    );
  }

  Widget _buildNotRecyclatorButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _buildButton(
          'Picked up',
          () => _offerRepository.setOrAdd(
            offer.id!,
            offer.copyWith(state: OfferState.done),
          ),
          Colors.orange,
        ),
        _buildButton(
          'Reserve',
          () => _offerRepository.setOrAdd(
            offer.id!,
            offer.copyWith(state: OfferState.reserved),
          ),
          Colors.green,
        ),
      ],
    );
  }

  Widget _buildRecyclatorButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _buildButton(
          'Confirm pickup',
          () => _offerRepository.setOrAdd(
            offer.id!,
            offer.copyWith(
              state: OfferState.unconfirmed,
              recycleDate: DateTime.now(),
            ),
          ),
          Colors.green,
        ),
        _buildButton(
          'Cancel',
          () {
            _offerRepository.setOrAdd(
              offer.id!,
              offer.copyWith(
                state: OfferState.free,
                recyclatorId: '',
              ),
            );
          },
          Colors.red,
        ),
      ],
    );
  }

  Widget _buildCorrectButton() {
    final userId = _userService.getUser().id;
    if (offer.authorId == userId) {
      return _buildCreatorButtons();
    }
    if (offer.recyclatorId == userId) {
      return _buildRecyclatorButtons();
    }
    if (offer.recyclatorId == null) {
      return _buildNotRecyclatorButtons();
    }
    return SizedBox();
  }

  Widget _buildButton(String text, VoidCallback onPressed, Color color) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
      ),
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
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
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
            _buildCorrectButton(),
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
      child: Padding(
        padding: const EdgeInsets.all(8.0),
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
      ),
    );
  }
}
