import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pingo/constants/design_size.dart';
import 'package:pingo/core/extensions.dart';
import 'package:pingo/features/place/pages/edit/place_edit_page.dart';
import 'package:pingo/features/product/models/product.dart';
import 'package:pingo/widgets/design_appbar.dart';
import 'package:pingo/widgets/design_list_tile.dart';

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
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (BuildContext context, int index) {
          final place = products[index];

          return DesignListTile(
            image: place.image,
            title: place.name,
            subtitle: place.description,
            trailing: place.distance.metricSystem,
          );
        },
      ),
    );
  }
}
