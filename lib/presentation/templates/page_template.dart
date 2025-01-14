import 'package:flutter/material.dart';

class PageTemplate extends StatelessWidget {
  const PageTemplate({super.key, required this.title, required this.child});

  final Widget title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: title),
      body: child,
    );
  }
}
