import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pingo/features/auth/landing/landing_controller.dart';
import 'package:pingo/features/auth/signup/signup_page.dart';
import 'package:pingo/features/home/base_page.dart';
import 'package:pingo/features/profile/edit/profile_keywords_selection.dart';
import 'package:pingo/widgets/design_loading_page.dart';
import 'package:rive/rive.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    implements LandingPageNavigator {
  late LandingController controller;
  late RiveAnimationController animationController;

  @override
  void initState() {
    controller = LandingController(this);
    animationController = OneShotAnimation(
      'blink',
      autoplay: true,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: DesignLoadingPage(),
    );
  }

  @override
  void logged() {
    Get.to(() => const BasePage());
  }

  @override
  void loggedOut() {
    Get.to(() => const SignUpPage());
  }

  @override
  void loggedWithoutInfo() {
    Get.to(() => const ProfileKeywordsSelection());
  }
}

abstract class LandingPageNavigator {
  void logged();

  void loggedOut();

  void loggedWithoutInfo();
}
