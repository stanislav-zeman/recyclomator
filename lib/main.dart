import 'package:flutter/material.dart';
import 'package:recyclomator/injection.dart';
import 'package:recyclomator/presentation/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Injection.initialize();

  runApp(const App());
}
