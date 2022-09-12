import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:pingo/constants/design_color.dart';
import 'package:pingo/constants/design_size.dart';
import 'package:pingo/core/keyword.dart';
import 'package:pingo/features/auth/signup/signup_controller.dart';
import 'package:pingo/widgets/design_appbar.dart';
import 'package:pingo/widgets/design_title_with_subtitle.dart';
import 'package:pingo/widgets/design_search_input.dart';

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
  final controller = Get.put(SignUpController());
  final _gridItemHeight = (Get.height - kToolbarHeight - 24) / 1;

  final _gridItemWidth = Get.width / 2;

  double get childAspectRatio => (_gridItemWidth / _gridItemHeight) * 3.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(DesignSize.appBarHeight),
        child: DesignAppBar(
          onLeadingPressed: () => controller.previousPage(),
          actionText: 'Next',
          onActionPressed: () {
            final isValid =
                controller.quantityValid(widget.list, widget.minimumQuantity);
            if (isValid) controller.nextPage();
          },
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
          if (widget.showSearch)
            SliverToBoxAdapter(
              child: DesignSearchInput(
                hint: widget.searchHint,
              ),
            ),
          widget.masonryStyle
              ? SliverFillRemaining(
                  // hasScrollBody: false,
                  child: MasonryGridView.count(
                    padding: const EdgeInsets.fromLTRB(
                      DesignSize.padding,
                      0,
                      DesignSize.padding,
                      DesignSize.padding,
                    ),
                    // shrinkWrap: true,
                    crossAxisCount: 2,
                    mainAxisSpacing: DesignSize.mediumSpace,
                    crossAxisSpacing: DesignSize.mediumSpace,
                    itemCount: widget.list.length,
                    itemBuilder: (context, index) {
                      final mediumCardWidth = Get.width * 0.75;
                      final smallCardWidth = Get.width * 0.5;
                      final cardHeight =
                          index % 2 == 0 ? mediumCardWidth : smallCardWidth;

                      return Obx(() {
                        print(
                            '################## PLCE VALID: ${controller.quantityValid(
                          widget.list,
                          widget.minimumQuantity,
                        )}');

                        final isSelected =
                            controller.keywords.contains(widget.list[index].id);

                        return GestureDetector(
                          onTap: () =>
                              controller.toggleKeyword(widget.list[index].id),
                          child: Container(
                            color: isSelected
                                ? DesignColor.primary500
                                : DesignColor.text300,
                            height: cardHeight,
                            child: Text(widget.list[index].title),
                          ),
                        );
                      });
                    },
                  ),
                )
              : SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: DesignSize.mediumSpace,
                    crossAxisSpacing: DesignSize.mediumSpace,
                    childAspectRatio: childAspectRatio,
                    crossAxisCount: 3,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return Obx(() {
                        print(
                            '################## PLCE VALID: ${controller.quantityValid(
                          widget.list,
                          widget.minimumQuantity,
                        )}');
                        final isSelected =
                            controller.keywords.contains(widget.list[index].id);

                        return GestureDetector(
                          onTap: () =>
                              controller.toggleKeyword(widget.list[index].id),
                          child: Container(
                            alignment: Alignment.center,
                            color: isSelected
                                ? DesignColor.primary500
                                : DesignColor.text300,
                            child: Text(widget.list[index].title),
                          ),
                        );
                      });
                    },
                    childCount: widget.list.length,
                  ),
                ),
        ],
      ),
    );
  }
}
