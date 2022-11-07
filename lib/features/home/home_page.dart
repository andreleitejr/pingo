import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pingo/constants/design_size.dart';
import 'package:pingo/core/extensions.dart';
import 'package:pingo/features/event/pages/list/event_list_page.dart';
import 'package:pingo/features/home/category/category.dart';
import 'package:pingo/features/home/home_controller.dart';
import 'package:pingo/features/home/components/search/search_page.dart';
import 'package:pingo/features/home/widgets/design_home_app_bar.dart';
import 'package:pingo/features/place/pages/list/place_list_page.dart';
import 'package:pingo/features/place/pages/read/place_read_page.dart';
import 'package:pingo/features/product/models/product.dart';
import 'package:pingo/features/product/pages/list/product_list_page.dart';
import 'package:pingo/widgets/design_best_match_item.dart';
import 'package:pingo/widgets/design_category_bullet_list.dart';
import 'package:pingo/widgets/design_category_item.dart';
import 'package:pingo/widgets/design_event_item.dart';
import 'package:pingo/widgets/design_list_tile.dart';
import 'package:pingo/widgets/design_product_item.dart';
import 'package:pingo/widgets/design_search_input.dart';
import 'package:pingo/widgets/design_section_title.dart';
import 'package:pingo/widgets/design_shimmer_widget.dart';
import 'package:pingo/widgets/design_space.dart';
import 'package:pingo/widgets/shimmers/shimmer_event_item.dart';
import 'package:pingo/widgets/shimmers/shimmer_list_tile.dart';
import 'package:pingo/widgets/shimmers/shimmer_product_item.dart';

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
              title: DesignHomeAppBar(),
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
                isLoading: controller.loading.value,
              ),
            ),
            const SliverToBoxAdapter(
              child: DesignSpace(
                size: DesignSize.smallSpace,
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
                isLoading: controller.loading.value,
              ),
            ),
            const SliverToBoxAdapter(child: DesignSpace()),
            SliverToBoxAdapter(
              child: _bestMatchList(),
            ),
            const SliverToBoxAdapter(child: DesignSpace()),
            SliverToBoxAdapter(
              child: _categoryList(),
            ),
            const SliverToBoxAdapter(child: DesignSpace()),
            const SliverToBoxAdapter(
              child: DesignSpace(
                size: DesignSize.smallSpace,
              ),
            ),
            SliverToBoxAdapter(
              child: _buildEvents(),
            ),
            SliverToBoxAdapter(
              child: _buildProducts(),
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
                isLoading: controller.loading.value,
              ),
            ),
            const SliverToBoxAdapter(child: DesignSpace()),
            SliverToBoxAdapter(
              child: DesignCategoryBulletList(
                value: controller.category.category.value,
                onItemPressed: controller.category.setCategory,
                isLoading: controller.loading.value,
              ),
            ),
            const SliverToBoxAdapter(child: DesignSpace()),
            _buildPlaces(),
          ],
        );
      }),
    );
  }

  Widget _bestMatchList() {
    return SizedBox(
      height: 150,
      child: Obx(
        () {
          if (controller.loading.value) {
            return ListView.builder(
              padding: const EdgeInsets.symmetric(
                horizontal: DesignSize.mediumSpace,
              ),
              itemCount: 5,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return const DesignBestMatchItem(
                  bestMatch: null,
                  isLoading: true,
                );
              },
            );
          }
          final bestMatches = controller.bestMatch;

          return ListView.builder(
            padding: const EdgeInsets.symmetric(
              horizontal: DesignSize.mediumSpace,
            ),
            itemCount: bestMatches.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              final bestMatch = bestMatches[index];
              return DesignBestMatchItem(
                bestMatch: bestMatch,
              );
            },
          );
        },
      ),
    );
  }

  Widget _categoryList() {
    return SizedBox(
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

              if (controller.category.category.value.id == Category.products) {
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
            isLoading: controller.loading.value,
          );
        },
      ),
    );
  }

  Widget _buildEvents() {
    return Obx(
      () {
        if (controller.loading.value) {
          return Column(
            children: [
              DesignSectionTitle(
                title: 'Eventos próximos',
                onActionPressed: () => Get.to(
                  EventListPage(
                      title: 'Events', events: controller.eventsBestMatch),
                ),
                isLoading: controller.loading.value,
              ),
              const DesignSpace(),
              SizedBox(
                height: 230,
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: DesignSize.mediumSpace,
                  ),
                  itemCount: 6,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ShimmerEventItem(),
                        const DesignSpace(
                          orientation: DesignSpaceOrientation.horizontal,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          );
        }
        final events = controller.eventsBestMatch;

        if (events.isEmpty) return Container();

        return Column(
          children: [
            DesignSectionTitle(
              title: 'Eventos próximos',
              onActionPressed: () => Get.to(
                EventListPage(
                    title: 'Events', events: controller.eventsBestMatch),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: DesignSize.mediumSpace,
              ),
              isLoading: controller.loading.value,
            ),
            const DesignSpace(),
            SizedBox(
              height: 230,
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
                        isLoading: controller.loading.value,
                      ),
                      if (!isLast)
                        const DesignSpace(
                          orientation: DesignSpaceOrientation.horizontal,
                        ),
                    ],
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildProducts() {
    return Obx(() {
      if (controller.loading.value) {
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
              isLoading: controller.loading.value,
            ),
            const DesignSpace(),
            SizedBox(
              height: 175,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: DesignSize.mediumSpace,
                ),
                itemCount: 6,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShimmerProductItem(),
                      const DesignSpace(
                        orientation: DesignSpaceOrientation.horizontal,
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        );
      }
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
            isLoading: controller.loading.value,
          ),
          const DesignSpace(),
          SizedBox(
            height: 175,
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
                      isLoading: controller.loading.value,
                    ),
                    if (!isLast)
                      const DesignSpace(
                        orientation: DesignSpaceOrientation.horizontal,
                      ),
                  ],
                );
              },
            ),
          ),
        ],
      );
    });
  }

  Widget _buildPlaces() {
    return Obx(
      () {
        if (controller.loading.value) {
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return const ShimmerListTile();
              },
              childCount: 80, // 1000 list items
            ),
          );
        }
        final places = controller.places;
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              final place = places[index];

              return DesignListTile(
                image: place.image,
                title: place.name,
                subtitle: place.description,
                trailing: place.distance.metricSystem,
                onPressed: () => Get.to(() => PlaceReadPage(place: place)),
                isLoading: controller.loading.value,
              );
            },
            childCount: places.length, // 1000 list items
          ),
        );
      },
    );
  }
}
