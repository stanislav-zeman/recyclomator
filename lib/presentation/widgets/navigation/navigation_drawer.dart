import 'package:flutter/material.dart';
import 'package:recyclomator/presentation/pages/addresses_page.dart';
import 'package:recyclomator/presentation/pages/history_page.dart';
import 'package:recyclomator/presentation/pages/profile_page.dart';
import 'package:recyclomator/presentation/pages/statistics_page.dart';
import 'package:recyclomator/presentation/widgets/navigation/navigation_drawer_footer.dart';
import 'package:recyclomator/presentation/widgets/navigation/navigation_drawer_header.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          NavigationDrawerHeader(),
          _buildDrawerTile(
            context,
            'Profile',
            ProfilePage(),
          ),
          _buildDrawerTile(
            context,
            'Addresses',
            AddressesPage(),
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
          NavigationDrawerFooter(),
        ],
      ),
    );
  }

  Widget _buildDrawerTile(BuildContext context, String text, Widget page) {
    return ListTile(
      title: Text(text),
      onTap: () => Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => page)),
    );
  }
}
