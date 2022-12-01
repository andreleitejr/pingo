import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pingo/features/auth/pages/landing/landing_controller.dart';
import 'package:pingo/features/auth/pages/signup/signup_info_page.dart';
import 'package:pingo/features/auth/pages/signup/signup_page.dart';
import 'package:pingo/features/home/base_page.dart';
import 'package:pingo/widgets/design_loading_page.dart';
import 'package:rive/rive.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> implements LandingNavigator {
  late LandingController controller;
  late RiveAnimationController animationController;

  @override
  void initState() {
    controller = LandingController(this);

    animationController = OneShotAnimation(
      'blink',
      autoplay: true,
    );

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => const GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: DesignLoadingPage(),
      );

  @override
  void logged() => Get.to(() => const BasePage());

  @override
  void loggedOut() => Get.to(() => const SignUpPage());

  @override
  void loggedWithoutUser() => Get.to(() => const SignUpInfoPage());

  @override
  void loggedWithoutKeyword() => Get.to(() => SignUpInfoPage());
}

abstract class LandingNavigator {
  void logged();

  void loggedOut();

  void loggedWithoutUser();

  void loggedWithoutKeyword();
}
