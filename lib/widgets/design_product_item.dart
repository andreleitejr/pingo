import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:get/get.dart';
import 'package:pingo/constants/design_color.dart';
import 'package:pingo/constants/design_icons.dart';
import 'package:pingo/constants/design_size.dart';
import 'package:pingo/constants/design_text_style.dart';
import 'package:pingo/core/extensions.dart';
import 'package:pingo/features/product/models/product.dart';

import 'package:pingo/features/product/pages/read/product_read_page.dart';
import 'package:pingo/widgets/design_icon.dart';
import 'package:pingo/widgets/design_shimmer_widget.dart';
import 'package:pingo/widgets/design_space.dart';
import 'package:pingo/widgets/shimmers/shimmer_product_item.dart';

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
      return ShimmerProductItem();
    }
    return GestureDetector(
      onTap: () => Get.to(() => ProductReadPage(product: product)),
      child: SizedBox(
        height: _height,
        width: _width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            const SizedBox(height: 8),
            Text(
              product.name,
              style: DesignTextStyle.bodySmall12Bold,
              overflow: TextOverflow.ellipsis,
            ),
            const DesignSpace(size: DesignSize.smallSpace),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 2),
                  child: Opacity(
                    opacity: 0.7,
                    child: DesignIcon(
                      icon: DesignIcons.pin,
                      width: 7,
                      height: 7,
                    ),
                  ),
                ),
                const DesignSpace(
                    orientation: DesignSpaceOrientation.horizontal,
                    size: DesignSize.minimumSpace),
                Text(
                  product.distance.metricSystem,
                  style: DesignTextStyle.labelSmall8.apply(
                    color: DesignColor.text400,
                  ),
                ),
                const SizedBox(width: 4),
                const Padding(
                  padding: EdgeInsets.only(bottom: 2),
                  child: Opacity(
                    opacity: 0.7,
                    child: DesignIcon(
                      icon: DesignIcons.star,
                      width: 7,
                      height: 7,
                    ),
                  ),
                ),
                const DesignSpace(
                    orientation: DesignSpaceOrientation.horizontal,
                    size: DesignSize.minimumSpace),
                Text(
                  product.rating.toString(),
                  style: DesignTextStyle.labelSmall8.apply(
                    color: DesignColor.text400,
                  ),
                ),
              ],
            ),
            const DesignSpace(size: DesignSize.smallSpace),
            Row(
              children: [
                if (product.isPromotion) ...[
                  Text(
                    product.promotionalPrice!.monetary,
                    style: DesignTextStyle.labelSmall10Bold.apply(
                      color: DesignColor.text500,
                    ),
                  ),
                  const SizedBox(width: 4),
                ],
                Expanded(
                  child: Text(
                    product.price.monetary,
                    overflow: TextOverflow.ellipsis,
                    style: DesignTextStyle.labelSmall10Bold.apply(
                      color: product.isPromotion
                          ? DesignColor.text400
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
