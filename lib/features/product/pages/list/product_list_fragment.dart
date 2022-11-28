import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pingo/features/product/models/product.dart';
import 'package:pingo/features/product/pages/read/product_read_page.dart';
import 'package:pingo/widgets/design_product_list_tile.dart';

class ProductListFragment extends StatelessWidget {
  const ProductListFragment({Key? key, required this.products})
      : super(key: key);

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (BuildContext context, int index) {
        final product = products[index];

        return GestureDetector(
          onTap: () => Get.to(() => ProductReadPage(product: product)),
          child: DesignProductListTile(

            product: product,
          ),
        );
      },
    );
  }
}
