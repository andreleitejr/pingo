import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pingo/constants/design_color.dart';
import 'package:pingo/constants/design_images.dart';
import 'package:pingo/constants/design_size.dart';
import 'package:pingo/constants/design_text_style.dart';
import 'package:pingo/core/current_location.dart';
import 'package:pingo/core/extensions.dart';
import 'package:pingo/core/keyword.dart';
import 'package:pingo/features/event/pages/list/event_list_page.dart';
import 'package:pingo/features/home/filter/filter_modal.dart';
import 'package:pingo/features/home/home_controller.dart';
import 'package:pingo/features/place/models/place.dart';
import 'package:pingo/features/place/pages/list/place_list_page.dart';
import 'package:pingo/features/place/pages/read/place_read_page.dart';
import 'package:pingo/features/product/models/product.dart';
import 'package:pingo/features/product/pages/list/product_list_page.dart';
import 'package:pingo/models/user.dart';
import 'package:pingo/widgets/design_best_match_item.dart';
import 'package:pingo/widgets/design_category_item.dart';
import 'package:pingo/widgets/design_event_item.dart';
import 'package:pingo/widgets/design_list_tile.dart';
import 'package:pingo/widgets/design_product_item.dart';
import 'package:pingo/widgets/design_search_input.dart';
import 'package:pingo/widgets/design_section_title.dart';
import 'package:pingo/widgets/design_space.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeController controller;
  final CurrentLocation location = Get.find();
  final User user = Get.find();

  @override
  void initState() {
    controller = Get.put(HomeController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: Colors.white,
          title: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 32,
                    width: 32,
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(DesignImages.weather),
                      ),
                      borderRadius: BorderRadius.circular(32),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '21',
                                  style: DesignTextStyle.labelMedium12.apply(
                                    color: DesignColor.text400,
                                  ),
                                ),
                                Text(
                                  '°C',
                                  style: DesignTextStyle.labelSmall6.apply(
                                    color: DesignColor.text400,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 4),
                            Center(
                              child: Container(
                                width: 4,
                                height: 4,
                                decoration: BoxDecoration(
                                  color: DesignColor.text300,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              location.city,
                              style: DesignTextStyle.labelMedium12.apply(
                                color: DesignColor.text400,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          location.streetName,
                          style: DesignTextStyle.bodySmall14,
                        ),
                      ],
                    ),
                  ),
                  // Container(
                  //   height: 32,
                  //   width: 32,
                  //   margin: const EdgeInsets.symmetric(horizontal: 16),
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(32),
                  //   ),
                  //   child: Stack(
                  //     alignment: Alignment.topRight,
                  //     children: [
                  //       const Icon(
                  //         Icons.notification_important_outlined,
                  //         color: DesignColor.text500,
                  //       ),
                  //       Container(
                  //         width: 10,
                  //         height: 10,
                  //         margin: const EdgeInsets.fromLTRB(0, 3, 1, 0),
                  //         decoration: BoxDecoration(
                  //             border: Border.all(color: Colors.white, width: 2),
                  //             color: DesignColor.primary700,
                  //             borderRadius: BorderRadius.circular(100)),
                  //       )
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
          floating: true,
        ),
        SliverAppBar(
          primary: false,
          pinned: true,
          backgroundColor: Colors.white,
          title: DesignSearchInput(
            hint: 'Search the best around you',
            onFilter: () {
              showModalBottomSheet<void>(
                isScrollControlled: true,
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                backgroundColor: Colors.white,
                builder: (BuildContext context) {
                  return FilterModal();
                },
              );
            },
          ),
        ),
        SliverToBoxAdapter(
          child: DesignSectionTitle(
            title: 'Made for you',
            onActionPressed: () => Get.to(
              PlaceListPage(
                  title: 'Made for you', places: controller.bestMatch),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: DesignSize.mediumSpace,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 150,
            child: Obx(
              () {
                final bestMatches = controller.bestMatch;
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: DesignSize.mediumSpace,
                  ),
                  itemCount: bestMatches.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    final bestMatch = bestMatches[index];

                    return DesignBestMatchItem(bestMatch: bestMatch);
                  },
                );
              },
            ),
          ),
        ),
        const SliverToBoxAdapter(child: DesignSpace()),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 110,
            child: Obx(
              () => ListView.builder(
                padding: const EdgeInsets.only(
                  left: DesignSize.mediumSpace,
                ),
                scrollDirection: Axis.horizontal,
                itemCount: controller.categories.length,
                itemBuilder: (BuildContext context, int index) {
                  final category = controller.categories[index];
                  return DesignCategoryItem(
                    onPressed: () => Get.to(
                      PlaceListPage(
                        title: category.title,
                        places: category.list as List<Place>,
                      ),
                    ),
                    title: category.title,
                  );
                },
              ),
            ),
          ),
        ),
        const SliverToBoxAdapter(child: DesignSpace()),
        SliverToBoxAdapter(
          child: DesignSectionTitle(
            title: 'Best Prices Only',
            onActionPressed: () => Get.to(
              ProductListPage(
                  title: 'Best Prices Only',
                  products: controller.productBestMatch),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: DesignSize.mediumSpace,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Obx(
            () {
              final products = controller.productBestMatch;

              return SizedBox(
                height: 216,
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: DesignSize.mediumSpace,
                  ),
                  itemCount: products.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    final product = products[index];
                    final isLast = index == products.length - 1;
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DesignProductItem(
                          product: product,
                        ),
                        if (!isLast)
                          const DesignSpace(
                            orientation: DesignSpaceOrientation.horizontal,
                          ),
                      ],
                    );
                  },
                ),
              );
            },
          ),
        ),
        const SliverToBoxAdapter(child: DesignSpace()),
        SliverToBoxAdapter(
          child: DesignSectionTitle(
            title: 'Events',
            onActionPressed: () => Get.to(
              EventListPage(
                  title: 'Events', events: controller.eventsBestMatch),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: DesignSize.mediumSpace,
            ),
          ),
        ),
        const SliverToBoxAdapter(child: DesignSpace()),
        SliverToBoxAdapter(
          child: Obx(
            () {
              final events = controller.eventsBestMatch;

              return SizedBox(
                height: 216,
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: DesignSize.mediumSpace,
                  ),
                  itemCount: events.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    final event = events[index];
                    final isLast = index == products.length - 1;
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DesignEventItem(
                          event: event,
                        ),
                        if (!isLast)
                          const DesignSpace(
                            orientation: DesignSpaceOrientation.horizontal,
                          ),
                      ],
                    );
                  },
                ),
              );
            },
          ),
        ),
        const SliverToBoxAdapter(child: DesignSpace()),
        SliverToBoxAdapter(
          child: DesignSectionTitle(
            title: 'Near you',
            onActionPressed: () => Get.to(
              PlaceListPage(title: 'Near You', places: controller.places),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: DesignSize.mediumSpace,
            ),
          ),
        ),
        const SliverToBoxAdapter(child: DesignSpace()),
        Obx(() {
          final places = controller.places;

          if (places.isEmpty) {
            return SliverToBoxAdapter(
              child: Container(),
            );
          }

          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                final place = places[index];

                return DesignListTile(
                  image: place.image,
                  title: place.name,
                  subtitle: place.description,
                  trailing: place.distance.metricSystem,
                  onPressed: () => Get.to(PlaceReadPage(place: place)),
                );
              },
              childCount: places.length, // 1000 list items
            ),
          );
        }),
      ],
    ));
  }
}
