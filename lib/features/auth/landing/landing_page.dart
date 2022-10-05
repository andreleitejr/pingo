import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pingo/features/auth/landing/landing_controller.dart';

import 'package:pingo/features/auth/signup/signup_info_page.dart';
import 'package:pingo/features/auth/signup/signup_page.dart';
import 'package:pingo/features/home/base_page.dart';
import 'package:pingo/features/profile/edit/profile_keywords_selection.dart';
import 'package:pingo/widgets/design_progress_indicator.dart';

class LandingPage extends StatefulWidget {
  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  late LandingController controller;

  @override
  void initState() {
    controller = LandingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder<User?>(
        stream: controller.userChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final user = snapshot.data;
            if (user == null) {
              return const SignUpPage();
            }

            if (controller.userValid) {
              controller.registerUser();
              return const BasePage();
            }

            if (controller.userCreatedInDatabase) {
              controller.registerUser();
              return const ProfileKeywordsSelection();
            }
            return const DesignProgressIndicator();
          } else {
            return const DesignProgressIndicator();
          }
        },
      ),
    );
  }
}
