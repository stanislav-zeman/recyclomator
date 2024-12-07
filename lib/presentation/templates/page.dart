import 'package:flutter/material.dart';
import 'package:recyclomator/presentation/widgets/navigation/navigation_drawer.dart' as navigation;

class PageTemplate extends StatelessWidget {
  final Widget title;
  final Widget child;

  const PageTemplate({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: title),
      endDrawer: navigation.NavigationDrawer(),
      body: child,
    );
  }
}
