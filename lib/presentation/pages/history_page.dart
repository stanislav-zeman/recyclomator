import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../domain/entities/offer.dart';
import '../../infrastructure/controllers/offer_controller.dart';
import '../templates/tab_page_template.dart';
import '../widgets/common/stream_widget.dart';
import '../widgets/offers/offer_list.dart';

class HistoryPage extends StatelessWidget {
  HistoryPage({super.key});

  final OfferController _historyController = GetIt.I<OfferController>();

  @override
  Widget build(BuildContext context) {
    return TabPageTemplate(
      title: Text('History'),
      children: <Widget>[
        StreamWidget<List<Offer>>(
          stream: _historyController.historyOffersStream,
          onData: (List<Offer> snapshot) => OfferList(
            offers: snapshot,
          ),
        ),
        StreamWidget<List<Offer>>(
          stream: _historyController.historyRecycleStream,
          onData: (List<Offer> snapshot) => OfferList(
            offers: snapshot,
          ),
        ),
      ],
    );
  }
}
