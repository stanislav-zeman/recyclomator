import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:recyclomator/domain/entities/address.dart';
import 'package:recyclomator/infrastructure/repositories/firestore.dart';
import 'package:recyclomator/presentation/templates/page_template.dart';
import 'package:recyclomator/presentation/widgets/common/future_widget.dart';

class OfferOnMap extends StatelessWidget {
  OfferOnMap({super.key, required this.addressId});

  final String addressId;

  final FirestoreRepository<Address> _addressRepository =
      GetIt.I<FirestoreRepository<Address>>();

  @override
  Widget build(BuildContext context) {
    final address = _addressRepository.getDocument(addressId);
    return PageTemplate(
      title: Text('Address'),
      child: FutureWidget(
        future: address,
        onData: (address) {
          if (address == null) {
            return Center(child: Text('Address not found'));
          }

          return GoogleMap(
            onMapCreated: (controller) {},
            initialCameraPosition: CameraPosition(
              target: LatLng(
                address.place.location.latitude,
                address.place.location.longitude,
              ),
              zoom: 16.0,
            ),
            markers: {
              Marker(
                markerId: MarkerId(address.id!),
                position: LatLng(
                  address.place.location.latitude,
                  address.place.location.longitude,
                ),
              ),
            },
          );
        },
      ),
    );
  }
}
