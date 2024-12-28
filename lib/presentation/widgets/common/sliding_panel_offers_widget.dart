import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../domain/entities/offer.dart';
import '../offers/offer_list.dart';
import 'stream_widget.dart';

class SlidingPanelOffersWidget extends StatelessWidget {
  const SlidingPanelOffersWidget({super.key, required this.stream});

  final Stream<List<Offer>> stream;

  @override
  Widget build(BuildContext context) {
    final BorderRadiusGeometry radius = BorderRadius.only(
      topLeft: Radius.circular(24.0),
      topRight: Radius.circular(24.0),
    );
    return StreamWidget(
      stream: stream,
      onData: (snapshot) => SlidingUpPanel(
        borderRadius: radius,
        collapsed: Container(
          decoration: BoxDecoration(
            borderRadius: radius,
            color: Colors.white,
          ),
          child: Center(
            child: Text(
              'Slide to see your offers...',
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ),
        panelBuilder: (sc) => OfferList(offers: snapshot, scrollController: sc,),
      ),
    );
  }
}
