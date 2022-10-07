import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pingo/constants/design_color.dart';
import 'package:pingo/constants/design_images.dart';
import 'package:pingo/core/extensions.dart';
import 'package:pingo/features/product/models/product.dart';
import 'package:pingo/features/product/pages/read/product_read_page.dart';

class DesignProductItem extends StatelessWidget {
  DesignProductItem({Key? key, required this.product}) : super(key: key);
  final Product product;

  final _height = 180.0;
  final _width = (Get.width / 3) - 26;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(ProductReadPage(product: product)),
      child: SizedBox(
        height: _height,
        width: _width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: _width,
              decoration: BoxDecoration(
                color: DesignColor.text200,
                image: DecorationImage(
                  image: NetworkImage(
                    product.image ?? DesignImages.fallbackImage,
                  ),
                  fit: BoxFit.fill,
                ),
              ),
            ),
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
                  child: Text(product.price.monetary,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: product.isPromotion ? DesignColor.text300 : Colors.black,
                        decoration: product.isPromotion
                            ? TextDecoration.lineThrough
                            : null,
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
