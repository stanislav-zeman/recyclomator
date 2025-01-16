import 'package:firebase_ui_auth/firebase_ui_auth.dart' as fauthui;
import 'package:flutter/material.dart';

class NavigationDrawerFooter extends StatelessWidget {
  const NavigationDrawerFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: ElevatedButton(
        onPressed: () => fauthui.FirebaseUIAuth.signOut(),
        child: Text('Sign out'),
      ),
    );
  }
}
