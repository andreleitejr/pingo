import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pingo/constants/design_size.dart';
import 'package:pingo/core/extensions.dart';
import 'package:pingo/features/product/pages/read/product_read_page.dart';
import 'package:pingo/models/category.dart';
import 'package:pingo/features/product/models/product.dart';
import 'package:pingo/features/product/pages/list/product_list_controller.dart';
import 'package:pingo/features/product/pages/list/product_list_fragment.dart';
import 'package:pingo/widgets/design_appbar.dart';
import 'package:pingo/widgets/design_category_bullet_list.dart';
import 'package:pingo/widgets/design_list_tile.dart';
import 'package:pingo/widgets/design_product_item.dart';
import 'package:pingo/widgets/design_search_input.dart';
import 'package:pingo/widgets/design_section_title.dart';
import 'package:pingo/widgets/design_space.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({
    Key? key,
    this.title,
    required this.products,
    this.showLeading = true,
  }) : super(key: key);

  final String? title;
  final List<Product> products;
  final bool showLeading;

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  late ProductListController controller;

  @override
  void initState() {
    controller = Get.put(ProductListController(widget.products));
    super.initState();
  }

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
                title: 'Produtos',
              ),
            ),
            SliverAppBar(
              primary: false,
              pinned: true,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              title: DesignSearchInput(
                hint: 'Busque os melhores produtos',
                onChanged: controller.setSearch,
              ),
            ),
            const SliverToBoxAdapter(
                child: DesignSpace(size: DesignSize.smallSpace)),
            SliverToBoxAdapter(
              child: Obx(
                () => DesignCategoryBulletList(
                  categories: controller.categories,
                  value: controller.category.category.value,
                  onItemPressed: controller.category.setCategory,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Obx(
                () {
                  if (!controller.category.showAll ||
                      controller.search.value.isNotEmpty) {
                    return Container();
                  }
                  return const DesignSpace(
                    size: DesignSize.smallSpace,
                  );
                },
              ),
            ),
            SliverToBoxAdapter(
              child: Obx(
                () {
                  if (!controller.category.showAll ||
                      controller.search.value.isNotEmpty) {
                    return Container();
                  }
                  return const DesignSectionTitle(
                    title: 'Melhores preços pra você',
                    padding: EdgeInsets.symmetric(
                      horizontal: DesignSize.mediumSpace,
                    ),
                    actionTitle: '',
                  );
                },
              ),
            ),
            const SliverToBoxAdapter(
                child: DesignSpace(size: DesignSize.smallSpace)),
            SliverToBoxAdapter(
              child: Obx(() {
                if (!controller.category.showAll ||
                    controller.search.value.isNotEmpty) {
                  return Container();
                }
                return _products();
              }),
            ),
            SliverToBoxAdapter(child: Obx(() {
              if (!controller.category.showAll ||
                  controller.search.value.isNotEmpty) {
                return Container();
              }
              return const DesignSpace(
                size: DesignSize.smallSpace,
              );
            })),
            const SliverToBoxAdapter(
              child: DesignSectionTitle(
                title: 'Produtos próximos',
                padding: EdgeInsets.symmetric(
                  horizontal: DesignSize.mediumSpace,
                ),
                actionTitle: '',
              ),
            ),
            const SliverToBoxAdapter(
                child: DesignSpace(size: DesignSize.smallSpace)),
            Obx(
              () => SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    final product = controller.bestProducts[index];

                    return DesignListTile(
                      item: product,
                      onPressed: () =>
                          Get.to(() => ProductReadPage(product: product)),
                    );
                  },
                  childCount: controller.bestProducts.length, // 1000 list items
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _products() {
    final products = controller.bestProducts;

    return SizedBox(
      height: 175,
      child: ListView.builder(
        padding: const EdgeInsets.only(left: DesignSize.mediumSpace),
        itemCount: products.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DesignProductItem(
                product: products[index],
              ),
              const DesignSpace(
                orientation: DesignSpaceOrientation.horizontal,
              ),
            ],
          );
        },
      ),
    );
  }
}
