import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pingo/constants/design_color.dart';
import 'package:pingo/core/extensions.dart';
import 'package:pingo/features/product/models/product.dart';
import 'package:pingo/widgets/design_space.dart';

class DesignProductItem extends StatelessWidget {
  const DesignProductItem({Key? key, required this.product}) : super(key: key);
  final Product product;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 221,
      width: (Get.width / 2) - 24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: (Get.width / 2) - 32,
            decoration: BoxDecoration(
              color: DesignColor.text200,
              image: DecorationImage(
                image: NetworkImage(
                  product.image ?? 'https://www.generationsforpeace.org/wp-content/uploads/2018/03/empty.jpg',
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
            ],
          ),
          Row(
            children: [
              Text(product.price.monetary),
              const SizedBox(width: 8),
              if (product.isPromotion) Text(product.promotionalPrice!.monetary),
            ],
          ),
        ],
      ),
    );
  }
}
