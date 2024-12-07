import 'package:flutter/material.dart';
import 'package:recyclomator/domain/entities/user.dart';
import 'package:recyclomator/infrastructure/repositories/firestore.dart';
import 'package:recyclomator/presentation/widgets/common/stream_widget.dart';

class NavigationDrawerHeader extends StatelessWidget {
  final FirestoreRepository<User> userRepository;

  const NavigationDrawerHeader({super.key, required this.userRepository});

  @override
  Widget build(BuildContext context) {
    return StreamWidget(
      stream: userRepository.observeDocument("FN6UP0zZc3OrWDjPFJ52"),
      onData: (user) => _buildDrawerHeader(context, user),
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
      return Text("Anonymous");
    }

    return Column(
      children: [
        Text(profile.username),
        Text(profile.email),
      ],
    );
  }
}
