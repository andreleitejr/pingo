import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pingo/constants/design_color.dart';
import 'package:pingo/features/auth/signup/signup_page.dart';
import 'package:pingo/features/auth/signup/signup_page_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  late Widget? page;

  @override
  Widget build(BuildContext context) {
// TODO: PROVISORIO

    FirebaseAuth.instance.userChanges().listen(
      (User? user) {
        if (user == null) {
          page = const SignUpPage();
        } else {
          page = SignUpPageView();
        }
      },
    );

    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: DesignColor.primary500,
        ),
      ),
      home: page,
    );
  }
}
