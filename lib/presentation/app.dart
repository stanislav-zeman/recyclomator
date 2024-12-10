import 'package:flutter/material.dart';
import 'package:recyclomator/presentation/pages/homepage.dart';
import 'package:recyclomator/presentation/theme/theme_provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recyclomator',
      home: Homepage(),
      theme: ThemeProvider.lightTheme,
      darkTheme: ThemeProvider.darkTheme,
      debugShowCheckedModeBanner: false,
    );
  }
}
