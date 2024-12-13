import 'package:flutter/material.dart';
import '../../domain/entities/user.dart';
import '../../infrastructure/repositories/firestore.dart';
import '../templates/page_template.dart';
import '../widgets/common/stream_widget.dart';
import '../widgets/profile/profile_editor.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key, required this.userRepository});

  final FirestoreRepository<User> userRepository;

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: Text('Profile'),
      child: StreamWidget(
        stream: userRepository.observeDocument('FN6UP0zZc3OrWDjPFJ52'),
        onData: _buildProfilePage,
      ),
    );
  }

  Widget _buildProfilePage(User? profile) {
    if (profile == null) {
      return Center(child: Text('Error: could not retrieve profile'));
    }

    return Wrap(
      spacing: 20,
      runSpacing: 20,
      children: <Widget>[
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
          children: <Widget>[
            Text('Username: ${profile.username}'),
            Text('Email: ${profile.email}'),
          ],
        ),
      ),
    );
  }
}
