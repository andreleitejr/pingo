import 'package:flutter/material.dart';
import 'package:pingo/constants/design_animations.dart';
import 'package:pingo/constants/design_color.dart';
import 'package:rive/rive.dart';

class DesignLoadingPage extends StatefulWidget {
  const DesignLoadingPage({Key? key}) : super(key: key);

  @override
  State<DesignLoadingPage> createState() => _DesignLoadingPageState();
}

class _DesignLoadingPageState extends State<DesignLoadingPage> {
  late RiveAnimationController animationController;

  @override
  void initState() {
    animationController = OneShotAnimation(
      'blink',
      autoplay: true,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DesignColor.primary500,
      body: Center(
        child: SizedBox(
          width: 85,
          child: RiveAnimation.asset(
            DesignAnimations.blink,
            animations: const ['blink'],
            controllers: [animationController],
          ),
        ),
      ),
    );
  }
}
