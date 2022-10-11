import 'package:flutter/material.dart';
import 'package:pingo/constants/design_size.dart';
import 'package:pingo/features/product/models/product.dart';
import 'package:pingo/features/product/pages/list/product_list_fragment.dart';
import 'package:pingo/widgets/design_appbar.dart';

class ProductListPage extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(DesignSize.appBarHeight),
        child: DesignAppBar(
          showLeading: showLeading,
          title: title ?? 'Products',
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: ProductListFragment(products: products),
    );
  }
}
