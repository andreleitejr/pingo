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
    tabController = TabController(length: 5, vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                pinned: true,
                backgroundColor: Colors.white,
                automaticallyImplyLeading: false,
                elevation: 0,
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
                        DesignAvatarImage(image: widget.place.image?.image),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.place.name,
                                style: DesignTextStyle.bodyLarge18Bold,
                              ),
                              Row(
                                children: [
                                  Text(
                                    widget.place.distance.metricSystem,
                                    style: DesignTextStyle.bodySmall14,
                                  ),
                                  const SizedBox(width: 4),
                                  Container(
                                    height: 12,
                                    width: 1.25,
                                    color: DesignColor.text300,
                                  ),
                                  const SizedBox(width: 4),
                                  const DesignIcon(
                                    icon: DesignIcons.star,
                                    height: DesignSize.smallIcon,
                                    width: DesignSize.smallIcon,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${widget.place.rating.toString()} (${widget.place.ratings.length})',
                                    style: DesignTextStyle.bodySmall14,
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
                        style: DesignTextStyle.bodySmall14,
                      ),
                    ),
                    const DesignSpace(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: DesignSize.mediumSpace),
                      child: Text(
                        '${widget.place.address.line ?? 'Address not found'}, ${widget.place.address.number}',
                        style: DesignTextStyle.bodySmall14
                            .apply(color: DesignColor.primary700),
                      ),
                    ),
                    const DesignSpace(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: DesignSize.mediumSpace),
                      child: DesignButton(
                        onPressed: () =>
                            Get.to(RatingPage(ratedId: widget.place.uuid)),
                        title: 'Rate',
                        isActive: true,
                      ),
                    ),
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
                          onPressed: () =>
                              Get.to(() => EventEditPage(place: widget.place)),
                          title: 'Create Event',
                          isActive: true,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SliverToBoxAdapter(child: DesignSpace()),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (_, int index) {
                    return const SizedBox(
                      height: 50,
                      child: TabBar(
                        labelColor: DesignColor.primary500,
                        unselectedLabelColor: DesignColor.text300,
                        indicatorColor: DesignColor.primary500,
                        indicatorWeight: 2,
                        indicatorPadding: EdgeInsets.zero,
                        labelPadding: EdgeInsets.zero,
                        padding: EdgeInsets.zero,
                        tabs: [
                          DesignIcon(
                            icon: DesignIcons.grid,
                          ),
                          DesignIcon(
                            icon: DesignIcons.product,
                          ),
                          DesignIcon(
                            icon: DesignIcons.event,
                          ),
                          DesignIcon(
                            icon: DesignIcons.map,
                          ),
                          DesignIcon(
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
              Obx(
                () {
                  if (controller.place.photos == null) {
                    return const Center(
                      child: Text('No photos found'),
                    );
                  }
                  return DesignImageGridView(
                    images: controller.place.photos!,
                    isMasonry: controller.isMasonry.value,
                    onButtonPressed: controller.toggleMasonry,
                  );
                },
              ),
              ProductListFragment(products: controller.place.products),
              EventListFragment(events: controller.place.events),
              DesignMap(
                place: controller.place,
              ),
              RatingList(
                ratings: controller.place.ratings,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
