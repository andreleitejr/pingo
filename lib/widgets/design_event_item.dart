import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:get/get.dart';
import 'package:pingo/constants/design_color.dart';
import 'package:pingo/constants/design_icons.dart';
import 'package:pingo/constants/design_size.dart';
import 'package:pingo/constants/design_text_style.dart';
import 'package:pingo/core/extensions.dart';
import 'package:pingo/features/event/models/event.dart';
import 'package:pingo/features/event/pages/read/event_read_page.dart';
import 'package:pingo/widgets/design_icon.dart';
import 'package:pingo/widgets/design_shimmer_widget.dart';
import 'package:pingo/widgets/design_space.dart';

class DesignEventItem extends StatelessWidget {
  DesignEventItem({Key? key, required this.event, this.isLoading = false})
      : super(key: key);
  final Event event;
  final bool isLoading;

  final _width = (Get.width / 3);

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return DesignShimmerWidget(
        child: SizedBox(
          width: _width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: _width,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(16),
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
      onTap: () => Get.to(EventReadPage(event: event)),
      child: SizedBox(
        width: _width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: _width,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: BlurHash(
                  imageFit: BoxFit.cover,
                  image: event.image!.image,
                  hash: event.image!.blurHash,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              event.name,
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
                      color: DesignColor.primary300,
                    ),
                  ),
                ),
                const DesignSpace(
                    orientation: DesignSpaceOrientation.horizontal,
                    size: DesignSize.minimumSpace),
                Text(
                  event.distance.metricSystem,
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
                      color: DesignColor.primary300,
                    ),
                  ),
                ),
                const DesignSpace(
                    orientation: DesignSpaceOrientation.horizontal,
                    size: DesignSize.minimumSpace),
                Text(
                  event.rating.toString(),
                  style: DesignTextStyle.labelSmall8.apply(
                    color: DesignColor.text400,
                  ),
                ),
              ],
            ),
            const DesignSpace(size: DesignSize.smallSpace),
            Row(
              children: [
                Text(
                  event.price.monetary,
                  style: DesignTextStyle.labelSmall10Bold.apply(
                    color: DesignColor.text500,
                  ),
                ),
                const SizedBox(width: DesignSize.smallSpace),
                Expanded(
                  child: Text(
                    event.start.startAndEnd(event.end),
                    overflow: TextOverflow.ellipsis,
                    style: DesignTextStyle.labelSmall10Bold.apply(
                      color: DesignColor.text500,
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
