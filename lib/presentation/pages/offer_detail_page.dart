import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:recyclomator/presentation/widgets/offers/offer_on_map.dart';

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

  final UserService _userService = GetIt.I<UserService>();

  final FirestoreRepository<Offer> _offerRepository = GetIt.I<FirestoreRepository<Offer>>();

  static const double buttonWidth = 120.0;
  static const double buttonHeight = 50.0;

  Widget _buildCreatorButtons(void Function(String) onPressedPop) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _buildButton(
          'Picked up',
          () {
            _offerRepository.setOrAdd(
              offer.id!,
              offer.copyWith(state: OfferState.done),
            );
            onPressedPop('Offer picked up');
          },
          Colors.green,
        ),
        _buildButton(
          'Still valid',
          () {
            _offerRepository.setOrAdd(
              offer.id!,
              offer.copyWith(
                state: OfferState.free,
              ),
            );
            onPressedPop('Offer still valid');
          },
          Colors.orange,
        ),
        _buildButton(
          'Cancel reservation',
          () {
            _offerRepository.setOrAdd(
              offer.id!,
              offer.copyWith(
                state: OfferState.canceled,
              ),
            );
            onPressedPop('Reservation canceled');
          },
          Colors.red,
        ),
      ],
    );
  }

  Widget _buildNotRecyclatorButtons(void Function(String) onPressedPop) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _buildButton(
          'Picked up',
          () {
            _offerRepository.setOrAdd(
              offer.id!,
              offer.copyWith(state: OfferState.done),
            );
            onPressedPop('Offer picked up');
          },
          Colors.orange,
        ),
        _buildButton(
          'Reserve',
          () {
            _offerRepository.setOrAdd(
              offer.id!,
              offer.copyWith(state: OfferState.reserved),
            );
            onPressedPop('Offer reserved');
          },
          Colors.green,
        ),
      ],
    );
  }

  Widget _buildRecyclatorButtons(void Function(String) onPressedPop) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _buildButton(
          'Confirm pickup',
          () {
            _offerRepository.setOrAdd(
              offer.id!,
              offer.copyWith(
                state: OfferState.unconfirmed,
                recycleDate: DateTime.now(),
              ),
            );
            onPressedPop('Pickup confirmed');
          },
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
            onPressedPop('Reservation canceled');
          },
          Colors.red,
        ),
      ],
    );
  }

  Widget _buildCorrectButton(void Function(String) onPressedPop) {
    if (offer.state.isFinished) {
      return SizedBox();
    }

    final userId = _userService.currentUserId;
    if (offer.userId == userId) {
      return _buildCreatorButtons(onPressedPop);
    }

    if (offer.recyclatorId == userId) {
      return _buildRecyclatorButtons(onPressedPop);
    }

    if (offer.recyclatorId == null) {
      return _buildNotRecyclatorButtons(onPressedPop);
    }

    return SizedBox();
  }

  Widget _buildButton(String text, VoidCallback onPressed, Color color) {
    return SizedBox(
      width: buttonWidth,
      height: buttonHeight,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  int _getNumberOfBottles(ItemType type) {
    return offer.items.where((Item item) => item.type == type).firstOrNull?.count ?? 0;
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
                color: offer.state == OfferState.done
                    ? Colors.green
                    : offer.state == OfferState.canceled
                        ? Colors.red
                        : Colors.orange,
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
                  _buildCard(context, Icons.home, '${offer.addressId}'), // TODO: Show address
                  _buildCard(
                    context, 
                    Icons.calendar_month,
                    'Offer date: ${DateFormat('dd/MM/yyyy').format(offer.offerDate)}\nRecycle date: ${offer.recycleDate != null ? DateFormat('dd/MM/yyyy').format(offer.recycleDate!) : "N/A"}',
                  ),
                  _buildCard(
                    context, 
                    FontAwesomeIcons.beerMugEmpty,
                    'Amount: ${_getNumberOfBottles(ItemType.glass)}',
                  ),
                  _buildCard(
                    context, 
                    FontAwesomeIcons.bottleWater,
                    'Amount: ${_getNumberOfBottles(ItemType.pet)}',
                  ),
                ],
              ),
            ),
            _buildButton(
              'Open Map',
              () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (context) => OfferOnMap(
                      addressId: offer.addressId,
                    ),
                  ),
                );
              },
              Colors.blue,
            ),
            SizedBox(
              height: 10,
            ),
            _buildCorrectButton((message) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(message)),
              );
              Navigator.of(context).pop();
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, IconData icon, String label) {
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
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
      ),
    );
  }
}
