import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:get/get.dart';
import 'package:pingo/constants/design_color.dart';
import 'package:pingo/core/extensions.dart';
import 'package:pingo/features/product/models/product.dart';

import 'package:pingo/features/product/pages/read/product_read_page.dart';
import 'package:pingo/widgets/design_shimmer_widget.dart';

class DesignProductItem extends StatelessWidget {
  DesignProductItem({
    Key? key,
    required this.product,
    this.isLoading = false,
  }) : super(key: key);
  final Product product;

  final _height = 180.0;
  final _width = (Get.width / 3) - 26;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return DesignShimmerWidget(
        child: SizedBox(
          height: _height,
          width: _width + 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: _width,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              const SizedBox(height: 4),
              Container(
                width: double.infinity,
                height: 14,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Container(
                width: 90,
                height: 14,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Container(
                width: double.infinity,
                height: 14,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],
          ),
        ),
      );
    }
    return GestureDetector(
      onTap: () => Get.to(() => ProductReadPage(product: product)),
      child: SizedBox(
        height: _height,
        width: _width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: _width,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: BlurHash(
                  imageFit: BoxFit.cover,
                  image: product.image!.image,
                  hash: product.image!.blurHash,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              product.name,
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              children: [
                Text(product.distance.metricSystem),
                const SizedBox(width: 4),
                Text(product.rating.toString()),
              ],
            ),
            Row(
              children: [
                if (product.isPromotion) ...[
                  Text(product.promotionalPrice!.monetary),
                  const SizedBox(width: 4),
                ],
                Expanded(
                  child: Text(
                    product.price.monetary,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: product.isPromotion
                          ? DesignColor.text300
                          : Colors.black,
                      decoration: product.isPromotion
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
