import 'package:flutter/material.dart';
import '../../../domain/entities/user.dart';
import '../../../infrastructure/repositories/firestore.dart';
import '../common/stream_widget.dart';

class NavigationDrawerHeader extends StatelessWidget {
  const NavigationDrawerHeader({super.key, required this.userRepository});
  final FirestoreRepository<User> userRepository;

  @override
  Widget build(BuildContext context) {
    return StreamWidget(
      stream: userRepository.observeDocument('FN6UP0zZc3OrWDjPFJ52'),
      onData: (User? user) => _buildDrawerHeader(context, user),
    );
  }

  Widget _buildDrawerHeader(BuildContext context, User? profile) {
    return DrawerHeader(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
      ),
      child: Center(
        child: _buildDrawerHeaderText(profile),
      ),
    );
  }

  Widget _buildDrawerHeaderText(User? profile) {
    if (profile == null) {
      return Text('Anonymous');
    }

    return Column(
      children: <Widget>[
        Text(profile.username),
        Text(profile.email),
      ],
    );
  }
}
