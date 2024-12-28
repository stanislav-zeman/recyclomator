import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:recyclomator/domain/entities/offer.dart';
import 'package:recyclomator/infrastructure/repositories/firestore.dart';

import '../common/sliding_panel_offers_widget.dart';

class DisplayOffersWidget extends StatefulWidget {
  const DisplayOffersWidget({super.key});

  @override
  State<DisplayOffersWidget> createState() => _DisplayOffersWidgetState();
}

class _DisplayOffersWidgetState extends State<DisplayOffersWidget> {
  late GoogleMapController mapController;
  final LatLng _center = const LatLng(49.1951, 16.6068);
  final FirestoreRepository<Offer> _offerRepository =
      GetIt.I<FirestoreRepository<Offer>>();

  void _onMapCreated(GoogleMapController controller) => mapController = controller;
  
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 11.0,
          ),
        ),
        SlidingPanelOffersWidget(
          stream: _offerRepository.observeDocuments(),
        ),
      ],
    );
  }
}
