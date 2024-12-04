import 'package:flutter/material.dart';
import 'package:recyclomator/domain/entities/user.dart';
import 'package:recyclomator/infrastructure/repositories/firestore.dart';
import 'package:recyclomator/presentation/templates/page.dart';
import 'package:recyclomator/presentation/widgets/common/stream_widget.dart';
import 'package:recyclomator/presentation/widgets/profile/editor.dart';

class ProfilePage extends StatelessWidget {
  final FirestoreRepository<User> userRepository;

  const ProfilePage({super.key, required this.userRepository});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: Text('Profile'),
      child: StreamWidget(
        stream: userRepository.observeDocument("FN6UP0zZc3OrWDjPFJ52"),
        onData: _buildProfilePage,
      ),
    );
  }

  Widget _buildProfilePage(User? profile) {
    if (profile == null) {
      return Center(child: Text("Error: could not retrieve profile"));
    }

    return Wrap(
      spacing: 20,
      runSpacing: 20,
      children: [
        SizedBox(height: 20),
        _buildProfileMetadata(profile),
        Divider(),
        ProfileEditor(profile: profile, userRepository: userRepository),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildProfileMetadata(User profile) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            Text("Username: ${profile.username}"),
            Text("Email: ${profile.email}"),
          ],
        ),
      ),
    );
  }
}
