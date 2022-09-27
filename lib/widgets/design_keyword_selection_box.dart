import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pingo/core/keyword.dart';
import 'package:pingo/features/keyword/pages/keyword_selection_page.dart';
import 'package:pingo/widgets/design_button.dart';
import 'package:pingo/widgets/design_space.dart';

class DesignKeywordSelectionBox extends StatelessWidget {
  const DesignKeywordSelectionBox(
      {Key? key,
      required this.title,
      required this.list,
      required this.keywords,
      required this.onKeywordSelected,
      required this.isValid})
      : super(key: key);

  final String title;
  final List<KeywordData> list;
  final List<int> keywords;
  final Function(int) onKeywordSelected;
  final bool isValid;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DesignButton(
          onPressed: () async {
            final List<int> keywords = await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => KeywordSelectionPage(list: list)));

            keywords.clear();

            for (final keyword in keywords) {
              onKeywordSelected(keyword);
            }

            print('KEYWORDS: $keywords');
          },
          title: title,
          isActive: isValid,
        ),
        const DesignSpace(),
        Obx(() {
          if (keywords.isEmpty) return Container();
          return Wrap(
            children: [
              for (final keyword in keywords) ...[
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(places
                        .firstWhere((place) => place.id == keyword)
                        .title),
                    const DesignSpace(
                      orientation: DesignSpaceOrientation.horizontal,
                    ),
                  ],
                ),
              ],
            ],
          );
        }),
      ],
    );
  }
}
