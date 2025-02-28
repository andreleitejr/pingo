import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pingo/constants/design_color.dart';
import 'package:pingo/constants/design_size.dart';
import 'package:pingo/features/home/home_controller.dart';
import 'package:pingo/features/place/models/place.dart';
import 'package:pingo/features/place/pages/read/place_read_page.dart';
import 'package:pingo/widgets/design_appbar.dart';
import 'package:pingo/widgets/design_best_match_item.dart';
import 'package:pingo/widgets/design_category_bullet_list.dart';
import 'package:pingo/widgets/design_place_list_tile.dart';
import 'package:pingo/widgets/design_search_input.dart';
import 'package:pingo/widgets/design_section_title.dart';
import 'package:pingo/widgets/design_shimmer_widget.dart';
import 'package:pingo/widgets/design_space.dart';
import 'package:pingo/widgets/shimmers/shimmer_list_tile.dart';

class PlaceListPage extends StatefulWidget {
  const PlaceListPage({
    Key? key,
    this.title,
    required this.places,
    this.showLeading = true,
  }) : super(key: key);

  final String? title;
  final List<Place> places;
  final bool showLeading;

  @override
  State<PlaceListPage> createState() => _PlaceListPageState();
}

class _PlaceListPageState extends State<PlaceListPage> {
  final HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: DesignAppBar(
                showLeading: widget.showLeading,
                title: widget.title ?? 'Lugares',
              ),
            ),
            SliverAppBar(
              primary: false,
              pinned: true,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              elevation: 0.4,
              shadowColor: DesignColor.text300.withOpacity(0.5),
              toolbarHeight: 48,
              title: DesignSearchInput(
                hint: 'Busque o melhor ao redor',
                onChanged: controller.search.setSearch,
              ),
            ),
            const SliverToBoxAdapter(
                child: DesignSpace(size: DesignSize.smallSpace)),
            SliverToBoxAdapter(
              child: Obx(
                () => DesignCategoryBulletList(
                  value: controller.category.category.value,
                  categories: controller.generalCategories,
                  onItemPressed: controller.category.setCategory,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Obx(
                () {
                  if (!controller.category.showAll ||
                      controller.search.text.isNotEmpty) {
                    return Container();
                  }
                  return const DesignSpace(
                    size: DesignSize.smallSpace,
                  );
                },
              ),
            ),
            SliverToBoxAdapter(
              child: Obx(() {
                if (!controller.category.showAll ||
                    controller.search.text.isNotEmpty) {
                  return Container();
                }
                return const DesignSectionTitle(
                  title: 'Melhores lugares',
                  padding: EdgeInsets.symmetric(
                    horizontal: DesignSize.mediumSpace,
                  ),
                  actionTitle: '',
                );
              }),
            ),
            const SliverToBoxAdapter(
                child: DesignSpace(size: DesignSize.smallSpace)),
            SliverToBoxAdapter(
              child: Obx(() {
                if (!controller.category.showAll ||
                    controller.search.text.isNotEmpty) {
                  return Container();
                }
                return _bestMatchList();
              }),
            ),
            SliverToBoxAdapter(child: Obx(() {
              if (!controller.category.showAll ||
                  controller.search.text.isNotEmpty) {
                return Container();
              }
              return const DesignSpace(
                size: DesignSize.smallSpace,
              );
            })),
            const SliverToBoxAdapter(
              child: DesignSectionTitle(
                title: 'Lugares próximos',
                padding: EdgeInsets.symmetric(
                  horizontal: DesignSize.mediumSpace,
                ),
                actionTitle: '',
              ),
            ),
            const SliverToBoxAdapter(
                child: DesignSpace(size: DesignSize.smallSpace)),
            _buildPlaces(),
          ],
        ),
      ),
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
                return DesignShimmerWidget(
                  child: Container(
                    width: Get.width * 0.6,
                    margin:
                        const EdgeInsets.only(right: DesignSize.mediumSpace),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
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

              return DesignPlaceListTile(
                place: place,
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
