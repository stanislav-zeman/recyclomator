import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tuple/tuple.dart';

import '../../../domain/entities/address.dart';
import '../../../domain/entities/offer.dart';
import '../../../domain/value_objects/item.dart';
import '../../../domain/value_objects/item_type.dart';
import '../../../infrastructure/controllers/offer_controller.dart';
import '../../pages/offer_detail_page.dart';
import '../common/sliding_panel_offers_widget.dart';
import '../common/stream_widget.dart';

class DisplayOffersWidget extends StatefulWidget {
  const DisplayOffersWidget({super.key});

  @override
  State<DisplayOffersWidget> createState() => _DisplayOffersWidgetState();
}

class _DisplayOffersWidgetState extends State<DisplayOffersWidget> {
  final Map<String, Marker> _markers = {};
  final LatLng _center = const LatLng(49.1951, 16.6068);
  final OfferController _offerController = GetIt.I<OfferController>();

  Future<void> _onMapCreated(
    GoogleMapController controller,
    List<Tuple2<Offer, Address>> offersMarkers,
  ) async {
    setState(() {
      _markers.clear();
      for (final offerMarker in offersMarkers) {
        final address = offerMarker.item2;
        final offer = offerMarker.item1;

        final marker = Marker(
          markerId: MarkerId(address.name),
          position: LatLng(address.lat, address.lng),
          infoWindow: InfoWindow(
            title: '${address.street} ${address.houseNo}',
            snippet:
                'Glass: ${_getNumberOfBottles(ItemType.glass, offer)} Plastic: ${_getNumberOfBottles(ItemType.pet, offer)}',
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => OfferDetailPage(offer: offer),
              ),
            ),
          ),
        );
        _markers[address.name] = marker;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        StreamWidget(
          stream: _offerController.mockOffersMarkersStream,
          onData: (snapshot) => GoogleMap(
            onMapCreated: (controller) => _onMapCreated(controller, snapshot),
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 11.0,
            ),
            markers: _markers.values.toSet(),
          ),
        ),
        SlidingPanelOffersWidget(
          stream: _offerController.takenOffersStream,
        ),
      ],
    );
  }

  int _getNumberOfBottles(ItemType type, Offer offer) {
    return offer.items
            .where((Item item) => item.type == type)
            .firstOrNull
            ?.count ??
        0;
  }
}
