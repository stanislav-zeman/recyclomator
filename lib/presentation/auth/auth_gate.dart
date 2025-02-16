import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

import 'package:recyclomator/presentation/pages/homepage.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.userChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SignInScreen(
            headerBuilder: (context, constraints, _) => Center(
              child: Text(
                "Recyclomator",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            providers: [
              EmailAuthProvider(),
            ],
          );
        }

        return const Homepage();
      },
    );
  }
}
