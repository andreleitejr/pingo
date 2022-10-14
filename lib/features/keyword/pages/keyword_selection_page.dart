// import 'package:flutter/material.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// import 'package:get/get.dart';
// import 'package:pingo/constants/design_color.dart';
// import 'package:pingo/constants/design_size.dart';
// import 'package:pingo/core/keyword.dart';
// import 'package:pingo/features/keyword/pages/keyword_selection_controller.dart';
// import 'package:pingo/features/profile/edit/profile_keywords_controller.dart';
// import 'package:pingo/widgets/design_appbar.dart';
// import 'package:pingo/widgets/design_page_view.dart';
// import 'package:pingo/widgets/design_search_input.dart';
// import 'package:pingo/widgets/design_space.dart';
// import 'package:pingo/widgets/design_title_with_subtitle.dart';
//
// class KeywordSelectionPage extends StatefulWidget {
//   const KeywordSelectionPage({
//     Key? key,
//     this.title,
//     this.subtitle,
//     this.showSearch = false,
//     this.searchHint,
//     this.masonryStyle = false,
//     required this.list,
//     this.selectedList,
//     this.onItemTapped,
//     this.minimumQuantity = 0,
//   }) : super(key: key);
//
//   final String? title;
//   final String? subtitle;
//   final bool showSearch;
//   final String? searchHint;
//   final bool masonryStyle;
//   final List<KeywordData> list;
//   final List<int>? selectedList;
//   final Function(int)? onItemTapped;
//   final int minimumQuantity;
//
//   @override
//   State<KeywordSelectionPage> createState() => _KeywordSelectionPageState();
// }
//
// class _KeywordSelectionPageState extends State<KeywordSelectionPage> {
//   late KeywordSelectionController controller;
//   final _gridItemHeight = (Get.height - kToolbarHeight - 24) / 1;
//
//   final _gridItemWidth = Get.width / 2;
//
//   double get childAspectRatio => (_gridItemWidth / _gridItemHeight) * 3.5;
//
//   final PageViewController pageView = PageViewController();
//
//   @override
//   void initState() {
//     controller = Get.put(KeywordSelectionController(widget.list));
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(DesignSize.appBarHeight),
//         child: DesignAppBar(
//           onLeadingPressed: () => Navigator.pop(context, controller.keywordIds),
//           title: 'Select Keywords',
//           // actionText: 'Next',
//           // actionValid: controller.quantityValid(controller.list, widget.minimumQuantity),
//           // onActionPressed: () {
//           // final isValid =
//           //     controller.quantityValid(controller.list, widget.minimumQuantity);
//           //
//           // if (isValid) {
//           //   if (pageView.pageController.page == 3) {
//           //     controller.save().then((_) => Get.to(const HomePage()));
//           //   } else {
//           //     controller.pageView.nextPage();
//           //   }
//           // }
//
//           // },
//         ),
//       ),
//       body: CustomScrollView(
//         slivers: <Widget>[
//           SliverToBoxAdapter(
//             child: DesignTitleWithSubtitle(
//               title: widget.title,
//               subtitle: widget.subtitle,
//             ),
//           ),
//           const SliverToBoxAdapter(
//             child: DesignSpace(),
//           ),
//           if (widget.showSearch) ...[
//             SliverToBoxAdapter(
//               child: Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: DesignSize.mediumSpace),
//                 child: DesignSearchInput(
//                   onChanged: controller.setSearch,
//                   hint: widget.searchHint,
//                 ),
//               ),
//             ),
//             const SliverToBoxAdapter(
//               child: DesignSpace(),
//             ),
//           ],
//           widget.masonryStyle ? masonryGrid() : basicGrid(),
//         ],
//       ),
//     );
//   }
//
//   Widget masonryGrid() {
//     return SliverFillRemaining(
//       // hasScrollBody: false,
//       child: MasonryGridView.count(
//         padding: const EdgeInsets.fromLTRB(
//           DesignSize.mediumSpace,
//           0,
//           DesignSize.mediumSpace,
//           DesignSize.mediumSpace,
//         ),
//         crossAxisCount: 2,
//         mainAxisSpacing: DesignSize.mediumSpace,
//         crossAxisSpacing: DesignSize.mediumSpace,
//         itemCount: controller.list.length,
//         itemBuilder: (context, index) {
//           final mediumCardWidth = Get.width * 0.75;
//           final smallCardWidth = Get.width * 0.5;
//           final cardHeight = index % 2 == 0 ? mediumCardWidth : smallCardWidth;
//
//           return Obx(
//             () {
//               final isSelected =
//                   controller.keywords.contains(controller.list[index]);
//
//               final item = controller.list[index];
//               return GestureDetector(
//                 onTap: () => controller.toggleKeyword(controller.list[index]),
//                 child: Container(
//                   color:
//                       isSelected ? DesignColor.primary500 : DesignColor.text300,
//                   height: cardHeight,
//                   child: Text(item.title),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
//
//   Widget basicGrid() {
//     return SliverGrid(
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         mainAxisSpacing: DesignSize.mediumSpace,
//         crossAxisSpacing: DesignSize.mediumSpace,
//         childAspectRatio: childAspectRatio,
//         crossAxisCount: 3,
//       ),
//       delegate: SliverChildBuilderDelegate(
//         (BuildContext context, int index) {
//           return Obx(() {
//             final isSelected = controller.keywords.contains(controller.list[index]);
//
//             final item = controller.list[index];
//
//             return GestureDetector(
//               onTap: () => controller.toggleKeyword(controller.list[index]),
//               child: Container(
//                 alignment: Alignment.center,
//                 color:
//                     isSelected ? DesignColor.primary500 : DesignColor.text300,
//                 child: Text(item.title),
//               ),
//             );
//           });
//         },
//         childCount: controller.list.length,
//       ),
//     );
//   }
// }
