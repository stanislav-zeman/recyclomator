import 'package:flutter/material.dart';
import 'package:recyclomator/presentation/templates/page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: Text('Profile'),
      child: Text('This is the profile page'),
    );
  }
}
