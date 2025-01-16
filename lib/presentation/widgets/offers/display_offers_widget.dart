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
  static const double buttonWidth = 150.0;
  final LatLng _center = const LatLng(49.1951, 16.6068);
  final OfferController _offerController = GetIt.I<OfferController>();
  bool _isFilterMenuOpen = false;

  Set<Marker> _generateMarkers(List<Tuple2<Offer, Address>> offersMarkers) {
    final markers = <Marker>{};
    for (final offerMarker in offersMarkers) {
      final address = offerMarker.item2;
      final offer = offerMarker.item1;

      final marker = Marker(
        markerId: MarkerId(address.name),
        position: LatLng(address.lat!, address.lng!),
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
      markers.add(marker);
    }
    return markers;
  }

  int _getNumberOfBottles(ItemType type, Offer offer) {
    return offer.items
            .where((Item item) => item.type == type)
            .firstOrNull
            ?.count ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        StreamWidget(
          stream: _offerController.offersMarkersStream,
          onData: (snapshot) {
            final markers = _generateMarkers(snapshot);
            return GoogleMap(
              onMapCreated: (controller) {},
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 11.0,
              ),
              markers: markers,
            );
          },
        ),
        SlidingPanelOffersWidget(
          stream: _offerController.takenOffersStream,
        ),
        _buildSlidingFilter(context),
      ],
    );
  }

  Widget _buildSlidingFilter(BuildContext context) {
    return StreamWidget(
      stream: _offerController.filterMarkers,
      onData: (filter) => Stack(
        children: [
          AnimatedPositioned(
            duration: Duration(milliseconds: 300),
            right: _isFilterMenuOpen ? 0 : -170,
            top: 70,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: buttonWidth,
                      child: ElevatedButton(
                        onPressed: () {
                          _offerController.setFilterMarkers(false);
                        },
                        child: Text("All Offers"),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: buttonWidth,
                      child: ElevatedButton(
                        onPressed: () {
                          _offerController.setFilterMarkers(true);
                        },
                        child: Text("Reserved Offers"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 5,
            top: 5,
            child: Row(
              children: [
                if (filter)
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Text(
                        "Reserved offers only",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                else
                  SizedBox(),
                SizedBox(width: 5),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isFilterMenuOpen = !_isFilterMenuOpen;
                    });
                  },
                  child: CircleAvatar(
                    radius: 25,
                    child: Icon(
                      _isFilterMenuOpen ? Icons.arrow_right : Icons.arrow_left,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
