import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pingo/constants/design_color.dart';
import 'package:pingo/constants/design_size.dart';
import 'package:pingo/constants/design_text_style.dart';
import 'package:pingo/core/extensions.dart';
import 'package:pingo/features/event/pages/edit/event_edit_page.dart';
import 'package:pingo/features/place/models/place.dart';
import 'package:pingo/features/place/pages/read/place_read_controller.dart';
import 'package:pingo/features/product/pages/edit/product_edit_page.dart';
import 'package:pingo/features/rating/pages/rating_page.dart';
import 'package:pingo/widgets/design_appbar.dart';
import 'package:pingo/widgets/design_button.dart';
import 'package:pingo/widgets/design_map.dart';
import 'package:pingo/widgets/design_read_image.dart';
import 'package:pingo/widgets/design_space.dart';

import 'package:flutter/services.dart' show rootBundle;

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
    tabController = TabController(length: 3, vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => CustomScrollView(
            slivers: <Widget>[
              const SliverAppBar(
                pinned: true,
                backgroundColor: Colors.white,
                automaticallyImplyLeading: false,
                elevation: 0,
                title: DesignAppBar(
                  actionIcon: Icons.share,
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
                        DesignAvatarImage(image: widget.place.image),
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
                                  const Icon(
                                    Icons.heart_broken,
                                    size: 14,
                                    color: DesignColor.primary500,
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
                  ],
                ),
              ),
              SliverToBoxAdapter(child: const DesignSpace()),
              SliverAppBar(
                pinned: true,
                backgroundColor: Colors.white,
                automaticallyImplyLeading: false,
                elevation: 1,
                titleSpacing: 0,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    for (final tab in tabs) ...[tab],
                  ],
                ),
              ),
              if (controller.currentTab.value == PlaceTabItemValue.photos) ...[
                SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 2,
                      crossAxisSpacing: 2,
                      childAspectRatio: 1),
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      if (controller.currentTab.value ==
                          PlaceTabItemValue.photos) {
                        return Container(
                          padding: const EdgeInsets.all(8),
                          color: DesignColor.text200,
                          child: Center(
                            child: Text(
                              index.toString(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: DesignColor.text300,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        );
                      }
                      return Container();
                    },
                    childCount: 100,
                  ),
                ),
              ] else if (controller.currentTab.value ==
                  PlaceTabItemValue.map) ...[
                SliverFillRemaining(
                  child: DesignMap(
                    position: controller.userPosition,
                    completer: controller.mapController,
                  ),
                ),
              ] else ...[
                SliverFillRemaining(
                  child: Container(
                    color: DesignColor.text200,
                    alignment: Alignment.center,
                    child: Text('Ratings'),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  List<PlaceTabItem> get tabs => [
        PlaceTabItem(
          value: PlaceTabItemValue.photos,
          iconData: Icons.grid_on_outlined,
          controller: controller,
        ),
        PlaceTabItem(
          value: PlaceTabItemValue.map,
          iconData: Icons.map,
          controller: controller,
        ),
        PlaceTabItem(
          value: PlaceTabItemValue.ratings,
          iconData: Icons.comment,
          controller: controller,
        ),
      ];
}

class PlaceTabItem extends StatelessWidget {
  const PlaceTabItem(
      {required this.value,
      required this.iconData,
      required this.controller,
      Key? key})
      : super(key: key);

  final PlaceTabItemValue value;
  final IconData iconData;
  final PlaceReadController controller;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.setTabItem(value),
      child: Obx(() {
        final isSelected = controller.currentTab.value == value;

        return Container(
          width: (Get.width / 3) - 2,
          height: 56,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected ? DesignColor.primary500 : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Icon(
            iconData,
            color: isSelected ? DesignColor.primary500 : DesignColor.text400,
          ),
        );
      }),
    );
  }
}
