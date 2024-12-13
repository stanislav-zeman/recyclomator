import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../../domain/entities/address.dart';
import '../../../domain/entities/user.dart';
import '../../../infrastructure/repositories/firestore.dart';
import '../../pages/addresses_page.dart';
import '../../pages/history_page.dart';
import '../../pages/profile_page.dart';
import '../../pages/statistics_page.dart';
import 'navigation_drawer_header.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          NavigationDrawerHeader(
            userRepository: GetIt.I<FirestoreRepository<User>>(),
          ),
          _buildDrawerTile(
            context,
            'Profile',
            ProfilePage(
              userRepository: GetIt.I<FirestoreRepository<User>>(),
            ),
          ),
          _buildDrawerTile(
            context,
            'Addresses',
            AddressesPage(
              addressRepository: GetIt.I<FirestoreRepository<Address>>(),
            ),
          ),
          _buildDrawerTile(
            context,
            'Statistics',
            StatisticsPage(),
          ),
          _buildDrawerTile(
            context,
            'History',
            HistoryPage(),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerTile(BuildContext context, String text, Widget page) {
    return ListTile(
      title: Text(text),
      onTap: () => Navigator.of(context)
          .push(MaterialPageRoute<void>(builder: (_) => page)),
    );
  }
}
