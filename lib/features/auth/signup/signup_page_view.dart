import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pingo/core/keyword.dart';
import 'package:pingo/features/auth/signup/signup_controller.dart';
import 'package:pingo/features/auth/signup/signup_keyword_selection.dart';

class SignUpPageView extends StatefulWidget {
  const SignUpPageView({Key? key}) : super(key: key);

  @override
  State<SignUpPageView> createState() => _SignUpPageViewState();
}

class _SignUpPageViewState extends State<SignUpPageView> {
  final controller = Get.put(SignUpController());

  List<Widget> get pages => [
        DesignKeywordSelection(
          title: 'Hello, John... Welcome to Pingo.',
          subtitle: 'What kind of place do you like?',
          list: places,
          masonryStyle: true,
          minimumQuantity: 1,
        ),
        DesignKeywordSelection(
          subtitle: 'What are your favorite foods?',
          list: foods,
          showSearch: true,
          searchHint: 'Search all foods...',
          minimumQuantity: 1,
        ),
        DesignKeywordSelection(
          subtitle: 'What kind of music do you listen to?',
          list: musics,
          showSearch: true,
          searchHint: 'Search for music genders...',
          minimumQuantity: 1,
        ),
        DesignKeywordSelection(
          title: 'Thanks, John... You\'re awesome!',
          subtitle: 'Can you select a few more things that define you?',
          list: miscellaneous,
          showSearch: true,
          searchHint: 'Search any other keyword...',
          minimumQuantity: 5,
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: controller.pageController,
      children: pages,
    );
  }
}
