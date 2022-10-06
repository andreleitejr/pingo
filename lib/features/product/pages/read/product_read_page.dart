import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pingo/constants/design_size.dart';
import 'package:pingo/core/extensions.dart';
import 'package:pingo/features/product/models/product.dart';
import 'package:pingo/features/rating/pages/rating_page.dart';
import 'package:pingo/widgets/design_appbar.dart';
import 'package:pingo/widgets/design_button.dart';
import 'package:pingo/widgets/design_read_image.dart';

class ProductReadPage extends StatefulWidget {
  const ProductReadPage({Key? key, required this.product}) : super(key: key);

  final Product product;

  @override
  State<ProductReadPage> createState() => _ProductReadPageState();
}

class _ProductReadPageState extends State<ProductReadPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(DesignSize.appBarHeight),
        child: DesignAppBar(
          title: widget.product.name,
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DesignAvatarImage(image: widget.product.image),
          Text(widget.product.name),
          Text(widget.product.distance.metricSystem),
          if (widget.product.description != null) Text(widget.product.description!),
          DesignButton(
            onPressed: () => Get.to(RatingPage(ratedId: widget.product.uuid)),
            title: 'Avaliar',
          )
        ],
      ),
    );
  }
}
