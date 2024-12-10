import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:recyclomator/domain/entities/offer.dart';
import 'package:recyclomator/infrastructure/controllers/offer_controller.dart';
import 'package:recyclomator/presentation/templates/tab_page_template.dart';
import 'package:recyclomator/presentation/widgets/common/stream_widget.dart';
import 'package:recyclomator/presentation/widgets/offers/offer_list.dart';

class HistoryPage extends StatelessWidget {
  HistoryPage({super.key});

  final _historyController = GetIt.I<OfferController>();

  @override
  Widget build(BuildContext context) {
    return TabPageTemplate(
      title: Text('History'),
      children: [
        StreamWidget<List<Offer>>(
          stream: _historyController.historyOffersStream,
          onData: (snapshot) => OfferList(
            offers: snapshot,
          ),
        ),
        StreamWidget<List<Offer>>(
          stream: _historyController.historyRecycleStream,
          onData: (snapshot) => OfferList(
            offers: snapshot,
          ),
        ),
      ],
    );
  }
}
