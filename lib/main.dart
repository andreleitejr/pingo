import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pingo/core/current_location.dart';
import 'package:pingo/features/auth/landing/landing_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // FirebaseAuth.instance.signOut();

  // final sharedPreferences = await SharedPreferences.getInstance();
  // Get.put(sharedPreferences);

  final location = CurrentLocation();
  await location.init();

  Get.put(location);

  runApp(LandingPage());
}
