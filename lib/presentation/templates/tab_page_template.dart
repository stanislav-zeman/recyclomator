import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../domain/value_objects/offer_type.dart';
import '../../infrastructure/controllers/offer_controller.dart';
import '../widgets/common/future_widget.dart';
import '../widgets/navigation/navigation_drawer.dart' as navigation;

class TabPageTemplate extends StatelessWidget {
  TabPageTemplate({super.key, required this.title, required this.children});

  final Widget title;
  final List<Widget> children;

  final OfferController _offerController = GetIt.I<OfferController>();

  @override
  Widget build(BuildContext context) {
    return FutureWidget<OfferType>(
      future: _offerController.loadState(),
      onData: (OfferType snapshot) => DefaultTabController(
        initialIndex: snapshot.index,
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              onTap: (int value) => _offerController.saveState(OfferType.values[value]),
              tabs: const <Widget>[
                Tab(icon: Icon(Icons.local_offer, color: Colors.white)),
                Tab(icon: Icon(Icons.map, color: Colors.white)),
              ],
            ),
            title: title,
          ),
          endDrawer: navigation.NavigationDrawer(),
          body: TabBarView(
            children: children,
          ),
        ),
      ),
    );
  }
}
