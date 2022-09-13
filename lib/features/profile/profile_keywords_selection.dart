import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:pingo/constants/design_color.dart';
import 'package:pingo/constants/design_size.dart';
import 'package:pingo/core/keyword.dart';
import 'package:pingo/features/home/home_page.dart';
import 'package:pingo/features/profile/profile_keywords_controller.dart';
import 'package:pingo/widgets/design_appbar.dart';
import 'package:pingo/widgets/design_page_view.dart';
import 'package:pingo/widgets/design_title_with_subtitle.dart';
import 'package:pingo/widgets/design_search_input.dart';
import 'package:pingo/widgets/design_vertical_space.dart';

class ProfileKeywordsSelection extends StatelessWidget {
  const ProfileKeywordsSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DesignPageView(
      pages: [
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
      ],
    );
  }
}

class DesignKeywordSelection extends StatefulWidget {
  const DesignKeywordSelection({
    Key? key,
    this.title,
    this.subtitle,
    this.showSearch = false,
    this.searchHint,
    this.masonryStyle = false,
    required this.list,
    this.selectedList,
    this.onItemTapped,
    this.minimumQuantity = 0,
  }) : super(key: key);

  final String? title;
  final String? subtitle;
  final bool showSearch;
  final String? searchHint;
  final bool masonryStyle;
  final List<Keyword> list;
  final List<int>? selectedList;
  final Function(int)? onItemTapped;
  final int minimumQuantity;

  @override
  State<DesignKeywordSelection> createState() => _DesignKeywordSelectionState();
}

class _DesignKeywordSelectionState extends State<DesignKeywordSelection> {
  final controller = Get.put(ProfileKeywordsController());
  final _gridItemHeight = (Get.height - kToolbarHeight - 24) / 1;

  final _gridItemWidth = Get.width / 2;

  double get childAspectRatio => (_gridItemWidth / _gridItemHeight) * 3.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(DesignSize.appBarHeight),
        child: Obx(
          () => DesignAppBar(
            onLeadingPressed: () => controller.pageView.previousPage(),
            actionText: 'Next',
            onActionPressed: () {
              final isValid =
                  controller.quantityValid(widget.list, widget.minimumQuantity);

              if (isValid) {
                if (controller.pageView.pageController.page == 3) {
                  Get.to(HomePage(keywords: controller.keywords));
                } else {
                  controller.pageView.nextPage();
                }
              }
            },
            actionValid:
                controller.quantityValid(widget.list, widget.minimumQuantity),
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: DesignTitleWithSubtitle(
              title: widget.title,
              subtitle: widget.subtitle,
            ),
          ),
          const SliverToBoxAdapter(
            child: DesignVerticalSpace(),
          ),
          if (widget.showSearch) ...[
            SliverToBoxAdapter(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: DesignSize.padding),
                child: DesignSearchInput(
                  hint: widget.searchHint,
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: DesignVerticalSpace(),
            ),
          ],
          widget.masonryStyle ? masonryGrid() : basicGrid(),
        ],
      ),
    );
  }

  Widget masonryGrid() {
    return SliverFillRemaining(
      // hasScrollBody: false,
      child: MasonryGridView.count(
        padding: const EdgeInsets.fromLTRB(
          DesignSize.padding,
          0,
          DesignSize.padding,
          DesignSize.padding,
        ),
        crossAxisCount: 2,
        mainAxisSpacing: DesignSize.mediumSpace,
        crossAxisSpacing: DesignSize.mediumSpace,
        itemCount: widget.list.length,
        itemBuilder: (context, index) {
          final mediumCardWidth = Get.width * 0.75;
          final smallCardWidth = Get.width * 0.5;
          final cardHeight = index % 2 == 0 ? mediumCardWidth : smallCardWidth;

          return Obx(
            () {
              final isSelected =
                  controller.keywords.contains(widget.list[index]);

              return GestureDetector(
                onTap: () => controller.toggleKeyword(widget.list[index]),
                child: Container(
                  color:
                      isSelected ? DesignColor.primary500 : DesignColor.text300,
                  height: cardHeight,
                  child: Text(widget.list[index].title),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget basicGrid() {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: DesignSize.mediumSpace,
        crossAxisSpacing: DesignSize.mediumSpace,
        childAspectRatio: childAspectRatio,
        crossAxisCount: 3,
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Obx(() {
            final isSelected = controller.keywords.contains(widget.list[index]);

            return GestureDetector(
              onTap: () => controller.toggleKeyword(widget.list[index]),
              child: Container(
                alignment: Alignment.center,
                color:
                    isSelected ? DesignColor.primary500 : DesignColor.text300,
                child: Text(widget.list[index].title),
              ),
            );
          });
        },
        childCount: widget.list.length,
      ),
    );
  }
}
