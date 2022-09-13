import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pingo/features/profile/profile_keywords_selection.dart';
import 'package:pingo/landing_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // FirebaseAuth.instance.signOut();

  runApp(GetMaterialApp(home: ProfileKeywordsSelection(),));
}
