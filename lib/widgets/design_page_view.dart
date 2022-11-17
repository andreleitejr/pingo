import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PageViewController extends GetxController {
  final PageController pageController = PageController();

  final _scrollTimeDuration = const Duration(milliseconds: 250);

  Future<void> nextPage() => pageController.nextPage(
        duration: _scrollTimeDuration,
        curve: Curves.easeIn,
      );

  Future<void> previousPage() => pageController.previousPage(
        duration: _scrollTimeDuration,
        curve: Curves.easeIn,
      );
}

class DesignPageView extends StatelessWidget {
  final List<Widget> pages;
  final PageViewController controller = Get.find();

  DesignPageView({super.key, required this.pages});

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: controller.pageController,
      children: pages,
    );
  }
}
