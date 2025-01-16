import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:recyclomator/domain/value_objects/offer_type.dart';
import 'package:recyclomator/infrastructure/services/state_service.dart';
import 'package:recyclomator/presentation/widgets/common/future_widget.dart';
import 'package:recyclomator/presentation/widgets/navigation/navigation_drawer.dart' as navigation;

class TabPageTemplate extends StatelessWidget {
  TabPageTemplate({
    super.key,
    required this.title,
    required this.children,
    this.showSideMenu = false,
    required this.leftIcon,
    required this.rightIcon,
  });

  final Widget title;
  final List<Widget> children;
  final bool showSideMenu;
  final IconData leftIcon;
  final IconData rightIcon;
  final StateService _stateService = GetIt.I<StateService>();

  @override
  Widget build(BuildContext context) {
    return FutureWidget<OfferType>(
      future: _stateService.loadState(),
      onData: (OfferType snapshot) => DefaultTabController(
        initialIndex: snapshot.index,
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              onTap: (int value) =>
                  _stateService.saveState(OfferType.values[value]),
              tabs: <Widget>[
                Tab(icon: Icon(leftIcon, color: Colors.white)),
                Tab(icon: Icon(rightIcon, color: Colors.white)),
              ],
            ),
            title: title,
          ),
          endDrawer: showSideMenu ? navigation.NavigationDrawer() : null,
          body: TabBarView(
            children: children,
          ),
        ),
      ),
    );
  }
}
