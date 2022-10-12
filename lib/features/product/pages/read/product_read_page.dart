import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pingo/constants/design_color.dart';
import 'package:pingo/constants/design_images.dart';
import 'package:pingo/constants/design_size.dart';
import 'package:pingo/constants/design_text_style.dart';
import 'package:pingo/core/extensions.dart';
import 'package:pingo/features/place/pages/read/place_read_page.dart';
import 'package:pingo/features/product/models/product.dart';
import 'package:pingo/features/rating/pages/rating_page.dart';
import 'package:pingo/widgets/design_appbar.dart';
import 'package:pingo/widgets/design_button.dart';
import 'package:pingo/widgets/design_read_image.dart';
import 'package:pingo/widgets/design_space.dart';

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
          actionIcon: Icons.share,
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: DesignSize.mediumSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: Get.width * 0.65,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      widget.product.image?.image ?? DesignImages.fallbackImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const DesignSpace(),
            Row(
              children: [
                Text(
                  widget.product.name,
                  style: DesignTextStyle.bodyLarge18Bold,
                ),
                const DesignSpace(
                    orientation: DesignSpaceOrientation.horizontal),
                const Icon(
                  Icons.heart_broken,
                  size: 14,
                  color: DesignColor.primary500,
                ),
                const SizedBox(width: 4),
                Text(
                  '${widget.product.rating.toString()} (${widget.product.ratings.length})',
                  style: DesignTextStyle.bodySmall14,
                ),
              ],
            ),
            const DesignSpace(size: DesignSize.smallSpace),
            RichText(
              text: TextSpan(
                  text: '${widget.product.distance.metricSystem} distance in ',
                  style: DesignTextStyle.bodySmall14
                      .apply(color: DesignColor.text400),
                  children: [
                    TextSpan(
                      text: '${widget.product.place?.name}',
                      style: DesignTextStyle.bodySmall14Bold.apply(
                        color: DesignColor.primary500,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Get.to(
                              PlaceReadPage(
                                place: widget.product.place!,
                              ),
                            ),
                    )
                  ]),
            ),
            const DesignSpace(size: DesignSize.smallSpace),
            Row(
              children: [
                if (widget.product.isPromotion) ...[
                  Text(widget.product.promotionalPrice!.monetary),
                  const SizedBox(width: 4),
                ],
                Expanded(
                  child: Text(
                    widget.product.price.monetary,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: widget.product.isPromotion
                          ? DesignColor.text300
                          : Colors.black,
                      decoration: widget.product.isPromotion
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  ),
                ),
              ],
            ),
            const DesignSpace(size: DesignSize.smallSpace),
            if (widget.product.description != null) ...[
              Text(
                widget.product.description!,
                style: DesignTextStyle.bodySmall14.apply(
                  color: DesignColor.text400,
                ),
              ),
            ],
            Expanded(child: Container()),
            DesignButton(
              onPressed: () => Get.to(
                PlaceReadPage(
                  place: widget.product.place!,
                ),
              ),
              title: 'Show Place',
              isActive: true,
            ),
            const DesignSpace(),
            GestureDetector(
                onTap: () => Get.to(RatingPage(ratedId: widget.product.uuid)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                      text: TextSpan(
                          text: 'Do you already know this product? ',
                          style: DesignTextStyle.bodySmall14.apply(
                            color: DesignColor.text400,
                          ),
                          children: [
                            TextSpan(
                              text: 'So rate it!',
                              style: DesignTextStyle.bodySmall14Bold.apply(
                                color: DesignColor.primary500,
                              ),
                            ),
                          ]),
                    ),
                  ],
                )),
            const DesignSpace(),
            const DesignSpace(),
          ],
        ),
      ),
    );
  }
}
