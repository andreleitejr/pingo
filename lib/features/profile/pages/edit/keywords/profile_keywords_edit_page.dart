import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pingo/core/keyword.dart';
import 'package:pingo/features/profile/pages/edit/keywords/profile_keywords_edit_controller.dart';
import 'package:pingo/features/profile/pages/edit/keywords/widgets/design_keyword_selection.dart';
import 'package:pingo/widgets/design_page_view.dart';

class ProfileKeywordsSelection extends StatelessWidget {
  ProfileKeywordsSelection({Key? key}) : super(key: key);

  final controller = Get.put(ProfileKeywordsController());

  @override
  Widget build(BuildContext context) {
    return DesignPageView(
      pages: [
        DesignKeywordSelection(
          title: 'Hello, ${controller.user.name}... Welcome to Pingo.',
          subtitle: 'What kind of place do you like?',
          list: placesKeywords,
          masonryStyle: true,
          minimumQuantity: 1,
        ),
        DesignKeywordSelection(
          title: 'Great, ${controller.user.name}...',
          subtitle: 'What are your favorite foods?',
          list: foods,
          showSearch: true,
          searchHint: 'Search all foods...',
          minimumQuantity: 1,
        ),
        DesignKeywordSelection(
          title: 'We are almost there, ${controller.user.name}.',
          subtitle: 'Can you tell me what kind of music do you listen to?',
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
      ],
    );
  }
}
