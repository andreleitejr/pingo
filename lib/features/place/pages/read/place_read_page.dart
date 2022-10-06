import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  final PlaceReadController controller = Get.put(PlaceReadController());
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);

    super.initState();
  }

  final _listHeight = 23;

  final _crossAxisCount = 3;

  final _mainAxisSpacing = 2;
  final _crossAxisSpacing = 2;

  final itemSpace = 2;

  double get cardHeight => (Get.width / _crossAxisCount);

  bool get isDivisible => _listHeight % 3 == 0;

  double get rowLength => _listHeight / 3;

  double get _height => rowLength * cardHeight;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
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
              toolbarHeight: 8,
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(40.0),
                child: TabBar(
                  padding: EdgeInsets.zero,
                  tabs: tabs,
                  controller: tabController,
                  unselectedLabelColor: DesignColor.text400,
                  indicatorColor: DesignColor.primary500,
                  labelColor: DesignColor.primary500,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: _height,
                child: TabBarView(
                  controller: tabController,
                  children: [
                    // Wrap(
                    //   children: [
                    //     for(var i = 0; i <= 100; i++)...[
                    //       Container(
                    //         alignment: Alignment.center,
                    //         height: (Get.width - 2) / 3,
                    //         width: (Get.width - 2) / 3,
                    //         child: Text(i.toString()),
                    //       )
                    //     ]
                    //   ],
                    // ),
                    GridView.count(
                      physics: NeverScrollableScrollPhysics(),
                      // to disable GridView's scrolling
                      shrinkWrap: true,
                      // Create a grid with 2 columns. If you change the scrollDirection to
                      // horizontal, this produces 2 rows.
                      mainAxisSpacing: 2,
                      crossAxisSpacing: 2,
                      crossAxisCount: 3,
                      // Generate 100 widgets that display their index in the List.
                      children: List.generate(_listHeight, (index) {
                        print('salsahiosahsoihsoihsai $isDivisible');
                        return Container(
                          alignment: Alignment.center,
                          color: Colors.grey,
                          child: Text((index + 1).toString()),
                        );
                      }),
                    ),
                    // SliverGrid(
                    //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    //       crossAxisCount: 3,
                    //       mainAxisSpacing: 2,
                    //       crossAxisSpacing: 2,
                    //       childAspectRatio: 1),
                    //   delegate: SliverChildBuilderDelegate(
                    //         (BuildContext context, int index) {
                    //       return Obx(() {
                    //         if (controller.currentTab.value ==
                    //             PlaceTabItemValue.photos) {
                    //           return Container(
                    //             padding: EdgeInsets.all(8),
                    //             color: Colors.grey,
                    //             child: Center(
                    //               child: Text(
                    //                 index.toString(),
                    //                 textAlign: TextAlign.center,
                    //                 style: TextStyle(color: Colors.white, fontSize: 20),
                    //               ),
                    //             ),
                    //           );
                    //         }
                    //         return Container();
                    //       });
                    //     },
                    //     childCount: 100,
                    //   ),
                    // ),
                    Container(
                      height: 100,
                      width: 100,
                      color: Colors.pink,
                      child: Text('MAP'),
                    ),
                    Container(
                      child: Text('RATINGS'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final tabs = [
    PlaceTabItem(
      value: PlaceTabItemValue.photos,
      iconData: Icons.grid_on_outlined,
    ),
    PlaceTabItem(
      value: PlaceTabItemValue.map,
      iconData: Icons.map,
    ),
    PlaceTabItem(
      value: PlaceTabItemValue.ratings,
      iconData: Icons.comment,
    ),
  ];
}

class PlaceTabItem extends StatelessWidget {
  PlaceTabItem({required this.value, required this.iconData, Key? key})
      : super(key: key);

  final PlaceTabItemValue value;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Tab(
      icon: Icon(
        iconData,
      ),
    );
  }
}
