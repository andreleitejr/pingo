import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pingo/constants/design_color.dart';
import 'package:pingo/constants/design_icons.dart';
import 'package:pingo/constants/design_size.dart';
import 'package:pingo/constants/design_text_style.dart';
import 'package:pingo/core/extensions.dart';
import 'package:pingo/features/event/pages/edit/event_edit_page.dart';
import 'package:pingo/features/event/pages/list/event_list_fragment.dart';
import 'package:pingo/features/place/models/place.dart';
import 'package:pingo/features/place/pages/read/place_read_controller.dart';
import 'package:pingo/features/post/pages/edit/post_edit_page.dart';
import 'package:pingo/features/product/pages/edit/product_edit_page.dart';
import 'package:pingo/features/product/pages/list/product_list_fragment.dart';
import 'package:pingo/features/rating/pages/rating_list.dart';
import 'package:pingo/features/rating/pages/rating_page.dart';
import 'package:pingo/main.dart';
import 'package:pingo/widgets/design_appbar.dart';
import 'package:pingo/widgets/design_button.dart';
import 'package:pingo/widgets/design_grid_view.dart';
import 'package:pingo/widgets/design_icon.dart';
import 'package:pingo/widgets/design_map.dart';
import 'package:pingo/widgets/design_outlined_button.dart';
import 'package:pingo/widgets/design_read_image.dart';
import 'package:pingo/widgets/design_space.dart';

class PlaceReadPage extends StatefulWidget {
  const PlaceReadPage({Key? key, required this.place}) : super(key: key);

  final Place place;

  @override
  State<PlaceReadPage> createState() => _PlaceReadPageState();
}

class _PlaceReadPageState extends State<PlaceReadPage>
    with SingleTickerProviderStateMixin {
  late PlaceReadController controller;
  late TabController tabController;

  @override
  void initState() {
    controller = Get.put(PlaceReadController(widget.place));
    tabController = TabController(length: controller.tabLength, vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: controller.tabLength,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  pinned: true,
                  backgroundColor: Colors.white,
                  automaticallyImplyLeading: false,
                  titleSpacing: 0,
                  elevation: 0,
                  toolbarHeight: 48,
                  title: DesignAppBar(
                    actionIcon: DesignIcons.share,
                    onActionPressed: () => controller.share(),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const DesignSpace(
                            orientation: DesignSpaceOrientation.horizontal,
                          ),
                          DesignAvatarImage(
                            image: widget.place.image?.image,
                            blurHash: widget.place.image?.blurHash,
                            width: 36,
                            height: 36,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      widget.place.name,
                                      style:
                                          DesignTextStyle.bodySmall12Bold.apply(
                                        color: DesignColor.text400,
                                      ),
                                    ),
                                    const DesignSpace(
                                        orientation:
                                            DesignSpaceOrientation.horizontal,
                                        size: DesignSize.minimumSpace),
                                    Container(
                                      width: 4,
                                      height: 4,
                                      decoration: BoxDecoration(
                                        color: DesignColor.text300,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    const DesignSpace(
                                      orientation:
                                          DesignSpaceOrientation.horizontal,
                                      size: DesignSize.smallSpace,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(bottom: 2),
                                      child: Opacity(
                                        opacity: 0.7,
                                        child: DesignIcon(
                                          icon: DesignIcons.star,
                                          width: 9,
                                          height: 9,
                                          color: DesignColor.primary300,
                                        ),
                                      ),
                                    ),
                                    const DesignSpace(
                                        orientation:
                                            DesignSpaceOrientation.horizontal,
                                        size: DesignSize.minimumSpace),
                                    Text(
                                      widget.place.rating.toString(),
                                      style: DesignTextStyle.labelSmall10.apply(
                                        color: DesignColor.text400,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(bottom: 2),
                                      child: Opacity(
                                        opacity: 0.7,
                                        child: DesignIcon(
                                          icon: DesignIcons.place,
                                          width: 9,
                                          height: 9,
                                          color: DesignColor.primary700,
                                        ),
                                      ),
                                    ),
                                    const DesignSpace(
                                      orientation:
                                          DesignSpaceOrientation.horizontal,
                                      size: DesignSize.minimumSpace,
                                    ),
                                    Text(
                                      widget.place.distance.metricSystem,
                                      style: DesignTextStyle.labelSmall10.apply(
                                        color: DesignColor.primary700,
                                      ),
                                    ),
                                    const DesignSpace(
                                        orientation:
                                            DesignSpaceOrientation.horizontal,
                                        size: DesignSize.smallSpace),
                                    Container(
                                      width: 4,
                                      height: 4,
                                      decoration: BoxDecoration(
                                        color: DesignColor.primary100,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    const DesignSpace(
                                      orientation:
                                          DesignSpaceOrientation.horizontal,
                                      size: DesignSize.smallSpace,
                                    ),
                                    Text(
                                      '${widget.place.address.line ?? 'Address not found'}, ${widget.place.address.number}',
                                      style: DesignTextStyle.labelSmall10.apply(
                                        color: DesignColor.primary700,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const DesignSpace(
                            orientation: DesignSpaceOrientation.horizontal,
                          ),
                        ],
                      ),
                      const DesignSpace(),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: DesignSize.mediumSpace),
                        child: Text(
                          widget.place.description ??
                              'No description found for this place',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: DesignTextStyle.bodySmall12.apply(
                            color: DesignColor.text400,
                          ),
                        ),
                      ),
                      const DesignSpace(),
                      if (isAdmin) ...[
                        const DesignSpace(),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: DesignSize.mediumSpace),
                          child: DesignButton(
                            onPressed: () => Get.to(
                                () => ProductEditPage(place: widget.place)),
                            title: 'Create Product',
                            isActive: true,
                          ),
                        ),
                        const DesignSpace(),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: DesignSize.mediumSpace),
                          child: DesignButton(
                            onPressed: () => Get.to(
                                () => EventEditPage(place: widget.place)),
                            title: 'Create Event',
                            isActive: true,
                          ),
                        ),
                      ],
                      Container(
                        height: 36,
                        width: Get.width,
                        padding: const EdgeInsets.symmetric(
                            horizontal: DesignSize.mediumSpace),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: DesignButton(
                                onPressed: () => Get.to(
                                    () => PostEditPage(place: widget.place)),
                                title: 'Postar no Mural',
                                isActive: true,
                              ),
                            ),
                            const DesignSpace(
                              orientation: DesignSpaceOrientation.horizontal,
                              size: DesignSize.smallSpace,
                            ),
                            Expanded(
                              child: DesignOutlinedButton(
                                onPressed: () => Get.to(
                                    RatingPage(ratedId: widget.place.uuid)),
                                title: 'Avaliar',
                                isActive: true,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (_, int index) {
                      return SizedBox(
                        height: 50,
                        child: TabBar(
                          labelColor: DesignColor.primary500,
                          unselectedLabelColor: DesignColor.text300,
                          indicatorColor: DesignColor.primary500,
                          indicatorWeight: 1.25,
                          indicatorSize: TabBarIndicatorSize.tab,
                          indicatorPadding: EdgeInsets.zero,
                          labelPadding: EdgeInsets.zero,
                          padding: EdgeInsets.zero,
                          tabs: [
                            if (controller.place.posts.isNotEmpty)
                              const DesignIcon(
                                icon: DesignIcons.grid,
                              ),
                            if (controller.place.products.isNotEmpty)
                              const DesignIcon(
                                icon: DesignIcons.product,
                              ),
                            if (controller.place.events.isNotEmpty)
                              const DesignIcon(
                                icon: DesignIcons.event,
                              ),
                            const DesignIcon(
                              icon: DesignIcons.map,
                            ),
                            if (controller.place.ratings.isNotEmpty)
                              const DesignIcon(
                                icon: DesignIcons.message,
                              ),
                          ],
                        ),
                      );
                    },
                    childCount: 1,
                  ),
                ),
              ];
            },
            body: TabBarView(
              children: <Widget>[
                if (controller.place.posts.isNotEmpty)
                  Obx(
                    () => DesignPostGridView(
                      place: controller.place,
                      isMasonry: controller.isMasonry.value,
                      onButtonPressed: controller.toggleMasonry,
                    ),
                  ),
                if (controller.place.products.isNotEmpty)
                  ProductListFragment(products: controller.place.products),
                if (controller.place.events.isNotEmpty)
                  EventListFragment(events: controller.place.events),
                DesignMap(
                  place: controller.place,
                ),
                if (controller.place.ratings.isNotEmpty)
                  RatingList(
                    ratings: controller.place.ratings,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
