import 'package:flutter/material.dart';
import 'auth/auth_gate.dart';
import 'theme/theme_provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recyclomator',
      home: AuthGate(),
      theme: ThemeProvider.lightTheme,
      darkTheme: ThemeProvider.darkTheme,
      debugShowCheckedModeBanner: false,
    );
  }
}
