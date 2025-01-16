import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NavigationDrawerHeader extends StatelessWidget {
  const NavigationDrawerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.userChanges(),
      builder: (context, snapshot) {
        final user = snapshot.data;
        return _buildDrawerHeader(context, user);
      },
    );
  }

  Widget _buildDrawerHeader(BuildContext context, User? user) {
    return DrawerHeader(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
      ),
      child: Center(
        child: _buildDrawerHeaderText(context, user),
      ),
    );
  }

  Widget _buildDrawerHeaderText(BuildContext context, User? user) {
    if (user == null) {
      return Text('Anonymous');
    }

    return Column(
      children: <Widget>[
        if (user.displayName != null) _buildText(context, user.displayName!),
        if (user.email != null) _buildText(context, user.email!),
      ],
    );
  }

  Widget _buildText(BuildContext context, String text) {
    return Text(text, style: Theme.of(context).textTheme.titleMedium);
  }
}
