import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pingo/constants/design_color.dart';
import 'package:pingo/constants/design_size.dart';
import 'package:pingo/constants/design_text_style.dart';
import 'package:pingo/core/extensions.dart';
import 'package:pingo/core/keyword.dart';
import 'package:pingo/features/event/models/event.dart';
import 'package:pingo/features/event/repositories/event_repository.dart';
import 'package:pingo/features/home/home_controller.dart';
import 'package:pingo/features/product/models/product.dart';
import 'package:pingo/features/product/repositories/product_repository.dart';
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

  @override
  void initState() {
    controller = Get.put(HomeController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: SafeArea(
            child: Column(
              children: [
                const DesignSpace(),
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
                        children: const [
                          Text(
                            'Hello, John',
                            style: DesignTextStyle.labelMedium12,
                          ),
                          Text(
                            'Franklin Roosevelt Square, 128',
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
                          const Icon(Icons.notification_important_outlined),
                          Container(
                            width: 10,
                            height: 10,
                            margin: const EdgeInsets.fromLTRB(0, 3, 1, 0),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.white, width: 2),
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
          ),
        ),
        body: Column(
          children: [
            // const DesignVerticalSpace(),
            // Text('Keywords: '),
            // Text(
            //   controller.keywordsIds.toString(),
            // ),
            // const DesignVerticalSpace(),
            // Text('Places: '),
            const DesignSpace(),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: DesignSearchInput(
                hint: 'Search the best around you',
              ),
            ),
            // const DesignVerticalSpace(),
            DesignSectionTitle(
              title: 'Made for you',
              onActionPressed: () {},
              padding: const EdgeInsets.symmetric(
                horizontal: DesignSize.mediumSpace,
              ),
            ),
            SizedBox(
              height: 112,
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

                      return Container(
                          alignment: Alignment.center,
                          width: Get.width * 0.6,
                          decoration: BoxDecoration(
                            color: DesignColor.text200,
                            image: DecorationImage(
                              image: NetworkImage(
                                bestMatch.image!,
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                          margin: EdgeInsets.only(
                              right: index != controller.bestMatch.length - 1
                                  ? DesignSize.mediumSpace
                                  : 0),
                          child: Stack(
                            children: [
                              Container(
                                width: double.infinity,
                                color: Colors.black.withOpacity(0.35),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(
                                    DesignSize.mediumSpace),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      bestMatch.name,
                                      style: DesignTextStyle.bodyMedium16Bold
                                          .apply(color: Colors.white),
                                    ),
                                    // Text(
                                    //   controller.bestMatch[index].keywords.toString(),
                                    // ),
                                    Text(
                                      'Match: ${bestMatch.match}',
                                      style: DesignTextStyle.bodyMedium16Bold
                                          .apply(color: Colors.white),
                                    ),
                                    Text(
                                      'Distance: ${bestMatch.distance.metricSystem}',
                                      style: DesignTextStyle.bodyMedium16Bold
                                          .apply(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ));
                    },
                  );
                },
              ),
            ),
            const DesignSpace(),
            SizedBox(
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
            DesignSectionTitle(
              title: 'Best Prices Only',
              onActionPressed: () {},
              padding: const EdgeInsets.symmetric(
                horizontal: DesignSize.mediumSpace,
              ),
            ),
            Obx(() {
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
            Obx(() {
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
            DesignSectionTitle(
              title: 'Near you',
              onActionPressed: () {},
              padding: const EdgeInsets.symmetric(
                horizontal: DesignSize.mediumSpace,
              ),
            ),
            Expanded(
              child: Obx(() {
                final places = controller.places;

                if (places.isEmpty) return Container();

                return ListView.builder(
                  itemCount: places.length,
                  itemBuilder: (BuildContext context, int index) {
                    final place = places[index];
                    return Column(
                      children: [
                        SizedBox(
                          height: 60,
                          child: Row(
                            children: [
                              const DesignSpace(
                                  orientation:
                                      DesignSpaceOrientation.horizontal),
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
                                  orientation:
                                      DesignSpaceOrientation.horizontal),
                            ],
                          ),
                        ),
                        const DesignSpace(),
                      ],
                    );
                  },
                );
              }),
            ),
            // SizedBox(
            //   height: 50,
            //   child: TextButton(
            //     onPressed: () {
            //       // final placeRepository = PlaceRepository();
            //       final keywords = [
            //         Keyword.mexican,
            //         Keyword.fastFood,
            //       ];
            //       // final place = Place(
            //       //   name: 'Praça Franklin Roosevelt',
            //       //   description:
            //       //       'Praça conhecida por sua diversidade, obstáculos para skate e patins e pelo litrão barato.',
            //       //   address: addresses[0],
            //       //   createdBy: 'LBq1jxC7ZauF91cDEipT',
            //       //   open: 10,
            //       //   close: 22,
            //       //   email: 'contato@teste.com',
            //       //   image:
            //       //       'https://vejasp.abril.com.br/wp-content/uploads/2016/12/roosevelt.jpeg',
            //       //   keywords: keywords,
            //       // );
            //       // placeRepository.save(place);
            //       final productRepository = ProductRepository();
            //       final eventRepository = EventRepository();
            //       for (final event in events) {
            //         // productRepository.save(product);
            //         eventRepository.save(event);
            //       }
            //     },
            //     child: const Text('Save'),
            //   ),
            // ),
          ],
        ));
  }
}
