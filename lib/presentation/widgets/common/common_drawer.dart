import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:recyclomator/domain/entities/address.dart';
import 'package:recyclomator/infrastructure/repositories/firestore.dart';
import 'package:recyclomator/presentation/pages/addresses_page.dart';
import 'package:recyclomator/presentation/pages/history_page.dart';
import 'package:recyclomator/presentation/pages/profile_page.dart';
import 'package:recyclomator/presentation/pages/statistics_page.dart';

class CommonDrawer extends StatelessWidget {
  const CommonDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: Text("emai/username"),
          ),
          buildDrawerTile(context, 'Profile', ProfilePage()),
          buildDrawerTile(
              context,
              'Adresy',
              AddressesPage(
                addressRepository: GetIt.I<FirestoreRepository<Address>>(),
              )),
          buildDrawerTile(context, 'Statistics', StatisticsPage()),
          buildDrawerTile(context, 'History', HistoryPage()),
        ],
      ),
    );
  }

  Widget buildDrawerTile(BuildContext context, String text, Widget page) {
    return ListTile(
      title: Text(text),
      onTap: () =>
          Navigator.of(context).push(MaterialPageRoute(builder: (_) => page)),
    );
  }
}
