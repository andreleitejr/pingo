import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pingo/core/keyword.dart';

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
  final controller = Get.put(PageViewController());

  DesignPageView({super.key, required this.pages});

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: controller.pageController,
      children: pages,
    );
  }
}

// List<Widget> get pages => [
//   DesignKeywordSelection(
//     title: 'Hello, John... Welcome to Pingo.',
//     subtitle: 'What kind of place do you like?',
//     list: places,
//     masonryStyle: true,
//     minimumQuantity: 1,
//   ),
//   DesignKeywordSelection(
//     subtitle: 'What are your favorite foods?',
//     list: foods,
//     showSearch: true,
//     searchHint: 'Search all foods...',
//     minimumQuantity: 1,
//   ),
//   DesignKeywordSelection(
//     subtitle: 'What kind of music do you listen to?',
//     list: musics,
//     showSearch: true,
//     searchHint: 'Search for music genders...',
//     minimumQuantity: 1,
//   ),
//   DesignKeywordSelection(
//     title: 'Thanks, John... You\'re awesome!',
//     subtitle: 'Can you select a few more things that define you?',
//     list: miscellaneous,
//     showSearch: true,
//     searchHint: 'Search any other keyword...',
//     minimumQuantity: 5,
//   ),
// ];
