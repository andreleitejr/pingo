import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pingo/constants/design_color.dart';
import 'package:pingo/constants/design_icons.dart';
import 'package:pingo/constants/design_images.dart';
import 'package:pingo/constants/design_size.dart';
import 'package:pingo/constants/design_text_style.dart';
import 'package:pingo/core/extensions.dart';
import 'package:pingo/features/event/models/event.dart';
import 'package:pingo/features/place/pages/read/place_read_page.dart';
import 'package:pingo/features/rating/pages/rating_page.dart';
import 'package:pingo/widgets/design_appbar.dart';
import 'package:pingo/widgets/design_button.dart';
import 'package:pingo/widgets/design_read_image.dart';
import 'package:pingo/widgets/design_space.dart';

class EventReadPage extends StatefulWidget {
  const EventReadPage({Key? key, required this.event}) : super(key: key);

  final Event event;

  @override
  State<EventReadPage> createState() => _EventReadPageState();
}

class _EventReadPageState extends State<EventReadPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(DesignSize.appBarHeight),
        child: DesignAppBar(
          title: widget.event.name,
          actionIcon: DesignIcons.share,
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
                      widget.event.image?.image ?? DesignImages.fallbackImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const DesignSpace(),
            Row(
              children: [
                Text(
                  widget.event.name,
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
                  '${widget.event.rating.toString()} (${widget.event.ratings.length})',
                  style: DesignTextStyle.bodySmall14,
                ),
              ],
            ),
            const DesignSpace(size: DesignSize.smallSpace),
            RichText(
              text: TextSpan(
                  text: '${widget.event.distance.metricSystem} distance in ',
                  style: DesignTextStyle.bodySmall14
                      .apply(color: DesignColor.text400),
                  children: [
                    TextSpan(
                      text: '${widget.event.place?.name}',
                      style: DesignTextStyle.bodySmall14Bold.apply(
                        color: DesignColor.primary500,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Get.to(
                              PlaceReadPage(
                                place: widget.event.place!,
                              ),
                            ),
                    )
                  ]),
            ),
            const DesignSpace(size: DesignSize.smallSpace),
            Row(
              children: [
                if (widget.event.isPromotion) ...[
                  Text(
                    widget.event.promotionalPrice!.monetary,
                    style: DesignTextStyle.bodySmall14Bold,
                  ),
                  const SizedBox(width: 4),
                ],
                Text(
                  widget.event.price.monetary,
                  overflow: TextOverflow.ellipsis,
                  style: DesignTextStyle.bodySmall14Bold.apply(
                    color: widget.event.isPromotion
                        ? DesignColor.text300
                        : Colors.black,
                    decoration: widget.event.isPromotion
                        ? TextDecoration.lineThrough
                        : null,
                  ),
                ),
                const DesignSpace(
                  orientation: DesignSpaceOrientation.horizontal,
                  size: DesignSize.smallSpace,
                ),
                Container(
                  height: 4,
                  width: 4,
                  decoration: BoxDecoration(
                    color: DesignColor.text300,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const DesignSpace(
                  orientation: DesignSpaceOrientation.horizontal,
                  size: DesignSize.smallSpace,
                ),
                Text(
                  '${widget.event.start.jm} -  ${widget.event.end.jm}',
                  style: DesignTextStyle.bodySmall14Bold,
                ),
              ],
            ),
            const DesignSpace(size: DesignSize.smallSpace),
            if (widget.event.description != null) ...[
              Text(
                widget.event.description!,
                style: DesignTextStyle.bodySmall14.apply(
                  color: DesignColor.text400,
                ),
              ),
            ],
            Expanded(child: Container()),
            DesignButton(
              onPressed: () => Get.to(
                PlaceReadPage(
                  place: widget.event.place!,
                ),
              ),
              title: 'Show Place',
              isActive: true,
            ),
            // const DesignSpace(),
            // GestureDetector(
            //   onTap: () => Get.to(RatingPage(ratedId: widget.event.uuid)),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       RichText(
            //         text: TextSpan(
            //             text: 'Do you already know this product? ',
            //             style: DesignTextStyle.bodySmall14.apply(
            //               color: DesignColor.text400,
            //             ),
            //             children: [
            //               TextSpan(
            //                 text: 'So rate it!',
            //                 style: DesignTextStyle.bodySmall14Bold.apply(
            //                   color: DesignColor.primary500,
            //                 ),
            //               ),
            //             ]),
            //       ),
            //     ],
            //   ),
            // ),
            const DesignSpace(),
            const DesignSpace(),
          ],
        ),
      ),
    );
  }
}
