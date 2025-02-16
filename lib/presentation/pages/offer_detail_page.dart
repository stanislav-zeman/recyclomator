import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:recyclomator/domain/entities/address.dart';
import 'package:recyclomator/domain/entities/offer.dart';
import 'package:recyclomator/domain/value_objects/address_component_type.dart';
import 'package:recyclomator/domain/value_objects/item.dart';
import 'package:recyclomator/domain/value_objects/item_type.dart';
import 'package:recyclomator/domain/value_objects/offer_state.dart';
import 'package:recyclomator/infrastructure/repositories/firestore.dart';
import 'package:recyclomator/infrastructure/services/user_service.dart';
import 'package:recyclomator/presentation/templates/page_template.dart';
import 'package:recyclomator/presentation/widgets/common/future_widget.dart';
import 'package:recyclomator/presentation/widgets/messages/chat_widget.dart';
import 'package:recyclomator/presentation/widgets/offers/offer_on_map.dart';

class OfferDetailPage extends StatelessWidget {
  OfferDetailPage({super.key, required this.offer});

  static const double buttonWidth = 120.0;
  static const double buttonHeight = 50.0;

  final Offer offer;
  final UserService _userService = GetIt.I<UserService>();
  final FirestoreRepository<Offer> _offerRepository =
      GetIt.I<FirestoreRepository<Offer>>();
  final FirestoreRepository<Address> _addressRepository =
      GetIt.I<FirestoreRepository<Address>>();

  @override
  Widget build(BuildContext context) {
    return FutureWidget(
      future: _addressRepository.getDocument(offer.addressId),
      onData: (address) => _buildOfferDetail(context, address),
    );
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

  Widget _buildCreatorButtons(void Function(String) onPressedPop) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _buildButton(
          'Still valid',
          () {
            _offerRepository.setOrAdd(
              offer.id!,
              offer.copyWith(
                state: OfferState.free,
                recyclatorId: "",
              ),
            );
            onPressedPop('Offer still valid');
          },
          Colors.orange,
        ),
        _buildButton(
          'Cancel',
          () {
            _offerRepository.setOrAdd(
              offer.id!,
              offer.copyWith(
                state: OfferState.canceled,
                recyclatorId: "",
              ),
            );
            onPressedPop('Offer canceled');
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
          'No longer valid',
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
              offer.copyWith(
                state: OfferState.reserved,
                recyclatorId: _userService.currentUserId,
              ),
            );
            onPressedPop('Offer reserved');
          },
          Colors.green,
        ),
      ],
    );
  }

  Widget _buildOfferDetail(BuildContext context, Address? address) {
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
                  _buildCard(
                    context,
                    Icons.home,
                    address == null
                        ? offer.addressId
                        : address.place.addressComponents
                            .where(
                              (ac) =>
                                  ac.types
                                      .contains(AddressComponentType.route) ||
                                  ac.types.contains(
                                    AddressComponentType
                                        .highLevelAdministrativeArea,
                                  ) ||
                                  ac.types.contains(
                                    AddressComponentType.country,
                                  ) ||
                                  ac.types.contains(
                                    AddressComponentType.streetNumber,
                                  ),
                            )
                            .map(
                              (ac) => ac.shortText,
                            )
                            .join(" "),
                  ),
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
            if (offer.id != null) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
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
                  if (offer.recyclatorId == _userService.currentUserId ||
                      offer.userId == _userService.currentUserId)
                    _buildButton(
                      'Chat',
                      () {
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (context) => ChatWidget(
                              offer: offer,
                            ),
                          ),
                        );
                      },
                      Colors.blue,
                    ),
                ],
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
          ],
        ),
      ),
    );
  }

  Widget _buildRecyclatorButtons(void Function(String) onPressedPop) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _buildButton(
          'Pick up',
          () {
            _offerRepository.setOrAdd(
              offer.id!,
              offer.copyWith(
                state: OfferState.done,
                recyclatorId: _userService.currentUserId,
              ),
            );
            onPressedPop('Offer picked up');
          },
          Colors.green,
        ),
        // _buildButton(
        //   'Confirm pickup',
        //   () {
        //     _offerRepository.setOrAdd(
        //       offer.id!,
        //       offer.copyWith(
        //         state: OfferState.unconfirmed,
        //         recycleDate: DateTime.now(),
        //       ),
        //     );
        //     onPressedPop('Pickup confirmed');
        //   },
        //   Colors.green,
        // ),
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

  int _getNumberOfBottles(ItemType type) {
    return offer.items
            .where((Item item) => item.type == type)
            .firstOrNull
            ?.count ??
        0;
  }
}
