import 'package:custom_map_markers/custom_map_markers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:pingo/constants/design_color.dart';
import 'package:pingo/constants/design_size.dart';
import 'package:pingo/constants/design_text_style.dart';
import 'package:pingo/core/extensions.dart';
import 'package:pingo/features/place/models/place.dart';
import 'package:pingo/features/place/pages/read/place_read_controller.dart';
import 'package:pingo/features/rating/pages/rating_page.dart';
import 'package:pingo/widgets/design_appbar.dart';
import 'package:pingo/widgets/design_button.dart';
import 'package:pingo/widgets/design_list_tile.dart';
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
    tabController = TabController(length: 3, vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
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
                          Icon(
                            Icons.grid_on_outlined,
                          ),
                          Icon(
                            Icons.map_outlined,
                          ),
                          Icon(
                            Icons.chat_bubble_outline,
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
              GridView.count(
                padding: EdgeInsets.zero,
                crossAxisCount: 3,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
                children: List.generate(100, (index) {
                  return Container(
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
                }),
              ),
              DesignMap(
                place: controller.place,
              ),
              ListView.builder(
                  itemCount: controller.place.ratings.length,
                  itemBuilder: (BuildContext context, int index) {
                    final rating = controller.place.ratings[index];

                    return DesignListTile(
                      image: rating.image,
                      title: rating.title!,
                      subtitle: rating.message,
                      trailing: DateFormat('yMd').format(rating.createdAt!),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
