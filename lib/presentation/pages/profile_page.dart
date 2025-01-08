import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../templates/page_template.dart';
import '../widgets/profile/profile_editor.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: Text('Profile'),
      child: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.userChanges(),
        builder: (context, snapshot) {
          final user = snapshot.data;
          if (user == null) {
            return Center(
              child: Text("An error occurred when fetching user data"),
            );
          }

          return _buildProfilePage(user);
        },
      ),
    );
  }

  Widget _buildProfilePage(User user) {
    return Wrap(
      spacing: 20,
      runSpacing: 20,
      children: <Widget>[
        SizedBox(height: 20),
        _buildUserMetadata(user),
        Divider(),
        ProfileEditor(user: user),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildUserMetadata(User user) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: <Widget>[
            Text('Username: ${user.displayName ?? "Not set"}'),
            Text('Email: ${user.email}'),
          ],
        ),
      ),
    );
  }
}
