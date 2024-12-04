import 'package:flutter/material.dart';
import 'package:recyclomator/domain/entities/offer.dart';
import 'package:recyclomator/domain/value_objects/offer_type.dart';
import 'package:recyclomator/infrastructure/controllers/offer_controller.dart';
import 'package:recyclomator/injection.dart';
import 'package:recyclomator/presentation/templates/page.dart';
import 'package:recyclomator/presentation/widgets/common/stream_widget.dart';
import 'package:recyclomator/presentation/widgets/offer_list_buttons.dart';
import 'package:tuple/tuple.dart';

class HistoryPage extends StatelessWidget {
  HistoryPage({super.key});

  final _historyController = get<OfferController>();

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: Text('History'),
      child: StreamWidget<Tuple2<OfferType, List<Offer>>>(
        stream: _historyController.historyOffersStream,
        onData: (snapshot) => OfferListWithButtons(
          offers: snapshot.item2,
          state: snapshot.item1,
        ),
      ),
    );
  }
}
