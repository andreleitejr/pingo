import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pingo/features/auth/pages/landing/landing_page.dart';

bool isAdmin = false;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const LandingPage());
}
