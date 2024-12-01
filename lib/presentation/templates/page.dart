import 'package:flutter/material.dart';
import 'package:recyclomator/presentation/widgets/common/common_drawer.dart';

class PageTemplate extends StatelessWidget {
  final Widget title;
  final Widget child;

  const PageTemplate({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: title,
      ),
      endDrawer: CommonDrawer(),
      body: child,
    );
  }
}
