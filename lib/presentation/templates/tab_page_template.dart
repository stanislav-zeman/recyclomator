import 'package:flutter/material.dart';
import 'package:recyclomator/domain/value_objects/offer_type.dart';
import 'package:recyclomator/infrastructure/controllers/offer_controller.dart';
import 'package:recyclomator/injection.dart';
import 'package:recyclomator/presentation/widgets/common/common_drawer.dart';
import 'package:recyclomator/presentation/widgets/common/future_widger.dart';

class TabPageTemplate extends StatelessWidget {
  final Widget title;
  final List<Widget> children;

  TabPageTemplate({super.key, required this.title, required this.children});

  final _offerController = get<OfferController>();

  @override
  Widget build(BuildContext context) {
    return FutureWidget<OfferType>(
        future: _offerController.loadState(),
        onData: (snapshot) => DefaultTabController(
              initialIndex: snapshot.index,
              length: 2,
              child: Scaffold(
                appBar: AppBar(
                  bottom: TabBar(
                    onTap: (value) =>
                        _offerController.saveState(OfferType.values[value]),
                    tabs: const [
                      Tab(icon: Icon(Icons.directions_car)),
                      Tab(icon: Icon(Icons.directions_transit)),
                    ],
                  ),
                  title: title,
                ),
                endDrawer: CommonDrawer(),
                body: TabBarView(
                  children: children,
                ),
              ),
            ));
  }
}
