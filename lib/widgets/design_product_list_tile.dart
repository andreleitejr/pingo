import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:pingo/constants/design_color.dart';
import 'package:pingo/constants/design_icons.dart';
import 'package:pingo/constants/design_size.dart';
import 'package:pingo/constants/design_text_style.dart';
import 'package:pingo/core/extensions.dart';
import 'package:pingo/features/product/models/product.dart';
import 'package:pingo/widgets/design_icon.dart';
import 'package:pingo/widgets/design_space.dart';
import 'package:pingo/widgets/shimmers/shimmer_list_tile.dart';

class DesignProductListTile extends StatelessWidget {
  const DesignProductListTile({
    Key? key,
    required this.product,
    this.onPressed,
    this.isLoading = false,
  }) : super(key: key);

  final Product product;
  final Function()? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const ShimmerListTile();
    }
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: DesignSize.mediumSpace),
            height: 70,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 0.5,
                  color: DesignColor.text100,
                ),
              ),
            ),
            child: Row(
              children: [
                const DesignSpace(
                    orientation: DesignSpaceOrientation.horizontal),
                product.image != null
                    ? SizedBox(
                        width: 42,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: BlurHash(
                            imageFit: BoxFit.cover,
                            image: product.image!.image,
                            hash: product.image!.blurHash,
                          ),
                        ),
                      )
                    : Container(),
                const DesignSpace(
                  orientation: DesignSpaceOrientation.horizontal,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              product.name,
                              style: DesignTextStyle.bodySmall12Bold,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (product.isPromotion) ...[
                            Text(
                              product.promotionalPrice!.monetary,
                              style: DesignTextStyle.labelSmall10Bold.apply(
                                color: DesignColor.text500,
                              ),
                            ),
                            const SizedBox(width: 4),
                          ],
                          Text(
                            product.price.monetary,
                            overflow: TextOverflow.ellipsis,
                            style: DesignTextStyle.labelSmall10Bold.apply(
                              color: product.isPromotion
                                  ? DesignColor.text300
                                  : Colors.black,
                              decoration: product.isPromotion
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                          ),
                        ],
                      ),
                      const DesignSpace(size: DesignSize.minimumSpace),
                      Row(
                        children: [
                          const SizedBox(width: 4),
                          const Padding(
                            padding: EdgeInsets.only(bottom: 2),
                            child: Opacity(
                              opacity: 0.7,
                              child: DesignIcon(
                                icon: DesignIcons.star,
                                width: 7,
                                height: 7,
                                color: DesignColor.primary300,
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
                          SizedBox(
                            height: 12,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: product.keywords.length > 2
                                  ? 2
                                  : product.keywords.length,
                              itemBuilder: (BuildContext context, int index) {
                                return keywordBullet(
                                    product.keywords[index].keyword);
                              },
                            ),
                          ),
                        ],
                      ),
                      const DesignSpace(size: DesignSize.smallSpace),
                      Text(
                        '${product.description}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: DesignTextStyle.labelSmall10,
                      ),
                    ],
                  ),
                ),
                const DesignSpace(
                    orientation: DesignSpaceOrientation.horizontal),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget keywordBullet(String title) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 4),
      margin: const EdgeInsets.only(left: 4),
      height: 12,
      decoration: BoxDecoration(
        color: DesignColor.primary100.withOpacity(0.25),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: DesignColor.primary300.withOpacity(0.25),
          width: 0.5,
        ),
      ),
      child: Text(
        title,
        style: DesignTextStyle.labelSmall8.apply(
          color: DesignColor.primary500,
        ),
      ),
    );
  }
}
