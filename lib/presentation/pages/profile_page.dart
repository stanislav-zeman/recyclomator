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

          return _buildProfilePage(context, user);
        },
      ),
    );
  }

  Widget _buildProfilePage(BuildContext context, User user) {
    return Wrap(
      spacing: 20,
      runSpacing: 20,
      children: <Widget>[
        SizedBox(height: 20),
        _buildUserMetadata(context, user),
        Divider(),
        ProfileEditor(user: user),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildUserMetadata(BuildContext context, User user) {
    return Center(
      child: Column(
        children: <Widget>[
          _buildTitle(context, 'Your data'),
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              children: [
                _buildText(context, 'Username: ${user.displayName ?? "Not set"}'),
                _buildText(context, 'Email: ${user.email}'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle(BuildContext context, String text) {
    return Text(text, style: Theme.of(context).textTheme.titleLarge);
  }

  Widget _buildText(BuildContext context, String text) {
    return Text(text, style: Theme.of(context).textTheme.bodyMedium);
  }
}
