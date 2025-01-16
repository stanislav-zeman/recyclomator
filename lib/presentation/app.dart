import 'package:flutter/material.dart';
import 'package:lock_orientation_screen/lock_orientation_screen.dart';
import 'package:recyclomator/presentation/auth/auth_gate.dart';
import 'package:recyclomator/presentation/theme/theme_provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return LockOrientation(
      child: MaterialApp(
        title: 'Recyclomator',
        home: AuthGate(),
        theme: ThemeProvider.lightTheme,
        darkTheme: ThemeProvider.darkTheme,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
