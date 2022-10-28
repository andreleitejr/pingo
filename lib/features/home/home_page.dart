import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pingo/constants/design_color.dart';
import 'package:pingo/constants/design_icons.dart';
import 'package:pingo/constants/design_images.dart';
import 'package:pingo/constants/design_size.dart';
import 'package:pingo/constants/design_text_style.dart';
import 'package:pingo/core/extensions.dart';
import 'package:pingo/features/event/pages/list/event_list_page.dart';
import 'package:pingo/features/home/category/category.dart';
import 'package:pingo/features/home/filter/filter_modal.dart';
import 'package:pingo/features/home/home_controller.dart';
import 'package:pingo/features/home/search/search_page.dart';
import 'package:pingo/features/place/pages/edit/place_edit_page.dart';
import 'package:pingo/features/place/pages/list/place_list_page.dart';
import 'package:pingo/features/place/pages/read/place_read_page.dart';
import 'package:pingo/features/product/models/product.dart';
import 'package:pingo/features/product/pages/list/product_list_page.dart';
import 'package:pingo/widgets/design_best_match_item.dart';
import 'package:pingo/widgets/design_category_bullet_list.dart';
import 'package:pingo/widgets/design_category_item.dart';
import 'package:pingo/widgets/design_event_item.dart';
import 'package:pingo/widgets/design_icon.dart';
import 'package:pingo/widgets/design_list_tile.dart';
import 'package:pingo/widgets/design_product_item.dart';
import 'package:pingo/widgets/design_search_input.dart';
import 'package:pingo/widgets/design_section_title.dart';
import 'package:pingo/widgets/design_space.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        if (controller.search.searchActive.value) {
          return SearchPage();
        }
        return CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              elevation: 0,
              title: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.to(PlaceEditPage());
                        },
                        child: Container(
                          height: 42,
                          width: 42,
                          margin: const EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            image: const DecorationImage(
                              image: AssetImage(DesignImages.weather),
                            ),
                            borderRadius: BorderRadius.circular(32),
                          ),
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
                                    Obx(
                                      () => Text(
                                        controller.temperature.toString(),
                                        style:
                                            DesignTextStyle.labelSmall10.apply(
                                          color: DesignColor.text400,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '°C',
                                      style: DesignTextStyle.labelSmall8.apply(
                                        color: DesignColor.text400,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 4),
                                Center(
                                  child: Container(
                                    width: 3,
                                    height: 3,
                                    decoration: BoxDecoration(
                                      color: DesignColor.text300,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  DateFormat.EEEE().format(DateTime.now()),
                                  style: DesignTextStyle.labelSmall10.apply(
                                    color: DesignColor.text400,
                                  ),
                                ),
                              ],
                            ),
                            Obx(
                              () => Text(
                                controller.address.value,
                                style: DesignTextStyle.bodySmall12.apply(
                                  color: DesignColor.text500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
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
                        child: const DesignIcon(
                          icon: DesignIcons.filter,
                        ),
                      )
                    ],
                  ),
                ],
              ),
              floating: true,
            ),
            SliverAppBar(
              primary: false,
              pinned: true,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              title: DesignSearchInput(
                hint: 'Busque o melhor ao redor',
                onChanged: controller.search.setSearch,
              ),
            ),
            SliverToBoxAdapter(
              child: DesignSectionTitle(
                title: 'Lugares feitos para você',
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
            const SliverToBoxAdapter(child: DesignSpace()),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 96,
                child: ListView.builder(
                  padding: const EdgeInsets.only(
                    left: DesignSize.mediumSpace,
                  ),
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (BuildContext context, int index) {
                    final category = categories[index];
                    return DesignCategoryItem(
                      onPressed: () {
                        controller.category.setCategory(category);

                        if (controller.category.category.value.id ==
                            Category.products) {
                          Get.to(
                            ProductListPage(
                              title: controller.category.category.value.title,
                              products: controller.productBestMatch,
                            ),
                          );
                        } else if (controller.category.category.value.id ==
                            Category.events) {
                          Get.to(
                            EventListPage(
                              title: controller.category.category.value.title,
                              events: controller.eventsBestMatch,
                            ),
                          );
                        } else {
                          Get.to(
                            PlaceListPage(
                              title: controller.category.category.value.title,
                              places: controller.places,
                            ),
                          );
                        }
                      },
                      title: category.title,
                      image: category.image,
                    );
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Obx(() {
                final events = controller.eventsBestMatch;

                if (events.isEmpty) return Container();

                return Column(
                  children: [
                    const DesignSpace(),
                    DesignSectionTitle(
                      title: 'Eventos próximos',
                      onActionPressed: () => Get.to(
                        EventListPage(
                            title: 'Events',
                            events: controller.eventsBestMatch),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: DesignSize.mediumSpace,
                      ),
                    ),
                    SizedBox(
                      height: 196,
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
                                  orientation:
                                      DesignSpaceOrientation.horizontal,
                                ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                );
              }),
            ),
            SliverToBoxAdapter(
              child: Obx(() {
                final products = controller.productBestMatch;

                if (products.isEmpty) return Container();

                return Column(
                  children: [
                    const DesignSpace(),
                    DesignSectionTitle(
                      title: 'Melhores preços da região',
                      onActionPressed: () => Get.to(
                        ProductListPage(
                            title: 'Best Prices Only',
                            products: controller.productBestMatch),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: DesignSize.mediumSpace,
                      ),
                    ),
                    SizedBox(
                      height: 142,
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
                                  orientation:
                                      DesignSpaceOrientation.horizontal,
                                ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                );
              }),
            ),
            const SliverToBoxAdapter(child: DesignSpace()),
            SliverToBoxAdapter(
              child: DesignSectionTitle(
                title: 'Tudo próximo',
                onActionPressed: () => Get.to(
                  PlaceListPage(
                      title: ''
                          '',
                      places: controller.places),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: DesignSize.mediumSpace,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: DesignCategoryBulletList(
                value: controller.category.category.value,
                onItemPressed: controller.category.setCategory,
              ),
            ),
            const SliverToBoxAdapter(child: DesignSpace()),
            Obx(
              () {
                final places = controller.places;

                if (places.isEmpty) {
                  return SliverToBoxAdapter(
                    child: Container(
                      alignment: Alignment.center,
                      height: 300,
                      child: const Text('Not Found'),
                    ),
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
              },
            ),
          ],
        );
      }),
    );
  }
}
