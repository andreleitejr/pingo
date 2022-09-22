import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pingo/constants/design_color.dart';
import 'package:pingo/constants/design_size.dart';
import 'package:pingo/constants/design_text_style.dart';
import 'package:pingo/core/current_location.dart';
import 'package:pingo/core/extensions.dart';
import 'package:pingo/features/home/home_controller.dart';
import 'package:pingo/features/product/models/product.dart';
import 'package:pingo/models/user.dart';
import 'package:pingo/widgets/design_best_match_item.dart';
import 'package:pingo/widgets/design_category_item.dart';
import 'package:pingo/widgets/design_event_item.dart';
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
                      color: DesignColor.text300,
                      borderRadius: BorderRadius.circular(32),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hello, ${user.name}',
                          style: DesignTextStyle.labelMedium12.apply(
                            color: DesignColor.text400,
                          ),
                        ),
                        Text(
                          location.streetName,
                          style: DesignTextStyle.bodySmall14,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 32,
                    width: 32,
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        const Icon(
                          Icons.notification_important_outlined,
                          color: DesignColor.text500,
                        ),
                        Container(
                          width: 10,
                          height: 10,
                          margin: const EdgeInsets.fromLTRB(0, 3, 1, 0),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 2),
                              color: DesignColor.primary700,
                              borderRadius: BorderRadius.circular(100)),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          floating: true,
        ),
        const SliverAppBar(
          primary: false,
          pinned: true,
          backgroundColor: Colors.white,
          title: DesignSearchInput(
            hint: 'Search the best around you',
          ),
        ),
        SliverToBoxAdapter(
          child: DesignSectionTitle(
            title: 'Made for you',
            onActionPressed: () {},
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
            child: ListView(
              padding: const EdgeInsets.symmetric(
                horizontal: DesignSize.mediumSpace,
              ),
              scrollDirection: Axis.horizontal,
              children: const [
                DesignCategoryItem(title: 'Restaurants'),
                DesignSpace(orientation: DesignSpaceOrientation.horizontal),
                DesignCategoryItem(title: 'Events'),
                DesignSpace(orientation: DesignSpaceOrientation.horizontal),
                DesignCategoryItem(title: 'Products'),
                DesignSpace(orientation: DesignSpaceOrientation.horizontal),
                DesignCategoryItem(title: 'Pubs'),
                DesignSpace(orientation: DesignSpaceOrientation.horizontal),
                DesignCategoryItem(title: 'Museus'),
                DesignSpace(orientation: DesignSpaceOrientation.horizontal),
                DesignCategoryItem(title: 'Historicals'),
                DesignSpace(orientation: DesignSpaceOrientation.horizontal),
                DesignCategoryItem(title: 'Utils'),
                DesignSpace(orientation: DesignSpaceOrientation.horizontal),
                DesignCategoryItem(title: 'More'),
              ],
            ),
          ),
        ),
        const SliverToBoxAdapter(child: DesignSpace()),
        SliverToBoxAdapter(
          child: DesignSectionTitle(
            title: 'Best Prices Only',
            onActionPressed: () {},
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
            title: 'Time to Party',
            onActionPressed: () {},
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
            onActionPressed: () {},
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

                return Column(
                  children: [
                    SizedBox(
                      height: 60,
                      child: Row(
                        children: [
                          const DesignSpace(
                              orientation: DesignSpaceOrientation.horizontal),
                          Container(
                            width: 60,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              image: DecorationImage(
                                image: NetworkImage(place.image!),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const DesignSpace(
                            orientation: DesignSpaceOrientation.horizontal,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(place.name),
                                    ),
                                    Text(place.distance.metricSystem),
                                  ],
                                ),
                                Text(
                                  '${place.description}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: DesignTextStyle.labelMedium12,
                                ),
                                Text('Average price \$29.99'),
                              ],
                            ),
                          ),
                          const DesignSpace(
                              orientation: DesignSpaceOrientation.horizontal),
                        ],
                      ),
                    ),
                    const DesignSpace(),
                  ],
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
