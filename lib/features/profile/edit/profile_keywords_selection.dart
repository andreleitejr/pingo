import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:pingo/constants/design_color.dart';
import 'package:pingo/constants/design_icons.dart';
import 'package:pingo/constants/design_size.dart';
import 'package:pingo/constants/design_text_style.dart';
import 'package:pingo/core/keyword.dart';
import 'package:pingo/features/home/base_page.dart';
import 'package:pingo/features/profile/edit/profile_keywords_controller.dart';
import 'package:pingo/widgets/design_appbar.dart';
import 'package:pingo/widgets/design_emoji_bullet.dart';
import 'package:pingo/widgets/design_page_view.dart';
import 'package:pingo/widgets/design_title_with_subtitle.dart';
import 'package:pingo/widgets/design_search_input.dart';
import 'package:pingo/widgets/design_space.dart';

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
        child: SafeArea(
          child: Obx(
            () => DesignAppBar(
              leadingIcon: DesignIcons.longArrowLeft,
              onLeadingPressed: () => controller.pageView.previousPage(),
              actionText: 'Next',
              actionValid:
                  controller.quantityValid(widget.list, widget.minimumQuantity),
              onActionPressed: () {
                final isValid = controller.quantityValid(
                    widget.list, widget.minimumQuantity);

                if (isValid) {
                  if (controller.pageView.pageController.page == 3) {
                    controller
                        .updateUser()
                        .then((_) => Get.to(() => const BasePage()));
                  } else {
                    controller.pageView.nextPage();
                  }
                }
              },
            ),
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
            child: DesignSpace(),
          ),
          if (widget.showSearch) ...[
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: DesignSize.mediumSpace),
                child: DesignSearchInput(
                  hint: widget.searchHint,
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: DesignSpace(),
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
          DesignSize.mediumSpace,
          0,
          DesignSize.mediumSpace,
          DesignSize.mediumSpace,
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
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: isSelected
                              ? DesignColor.primary500
                              : DesignColor.text300,
                          image: DecorationImage(
                            image: AssetImage(
                              widget.list[index].image,
                            ),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(16)),
                      height: cardHeight,
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      alignment: Alignment.bottomLeft,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(isSelected ? 0.6 : 0.2),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      height: cardHeight,
                      child: Row(
                        children: [
                          DesignEmojiBullet(
                            emoji: widget.list[index].emoji,
                            title: widget.list[index].title,
                          ),
                        ],
                      ),
                    ),
                    if (isSelected)
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          height: 20,
                          width: 20,
                          margin: const EdgeInsets.only(
                            top: DesignSize.mediumSpace,
                            right: DesignSize.mediumSpace,
                          ),
                          child: Image.asset(DesignIcons.valid),
                        ),
                      ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget basicGrid() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: DesignSize.mediumSpace,
          crossAxisSpacing: DesignSize.mediumSpace,
          childAspectRatio: childAspectRatio,
          crossAxisCount: 3,
        ),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return Obx(() {
              final isSelected =
                  controller.keywords.contains(widget.list[index]);

              return GestureDetector(
                onTap: () => controller.toggleKeyword(widget.list[index]),
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: isSelected
                              ? DesignColor.primary500
                              : DesignColor.text300,
                          image: DecorationImage(
                            image: AssetImage(
                              widget.list[index].image,
                            ),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(16)),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      alignment: Alignment.bottomLeft,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(isSelected ? 0.6 : 0.2),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          DesignEmojiBullet(
                            emoji: widget.list[index].emoji,
                            title: widget.list[index].title,
                            textStyle:  DesignTextStyle.labelSmall10Bold.apply(
                              color: DesignColor.text500,
                            ),
                            emojiSize: 10,
                          ),
                        ],
                      ),
                    ),
                    if (isSelected)
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          height: 20,
                          width: 20,
                          margin: const EdgeInsets.only(
                            top: DesignSize.mediumSpace,
                            right: DesignSize.mediumSpace,
                          ),
                          child: Image.asset(DesignIcons.valid),
                        ),
                      ),
                  ],
                ),
              );
            });
          },
          childCount: widget.list.length,
        ),
      ),
    );
  }
}
