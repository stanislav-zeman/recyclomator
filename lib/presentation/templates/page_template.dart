import 'package:flutter/material.dart';
import '../widgets/navigation/navigation_drawer.dart' as navigation;

class PageTemplate extends StatelessWidget {
  const PageTemplate({super.key, required this.title, required this.child});

  final Widget title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: title),
      endDrawer: navigation.NavigationDrawer(),
      body: child,
    );
  }
}
