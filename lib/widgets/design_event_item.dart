import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:get/get.dart';
import 'package:pingo/constants/design_color.dart';
import 'package:pingo/constants/design_images.dart';
import 'package:pingo/constants/design_size.dart';
import 'package:pingo/core/extensions.dart';
import 'package:pingo/features/event/models/event.dart';
import 'package:pingo/features/event/pages/read/event_read_page.dart';
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
      onTap: () => Get.to(EventReadPage(event: event)),
      child: SizedBox(
        width: _width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: _width,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: BlurHash(
                  imageFit: BoxFit.cover,
                  image: event.image!.image,
                  hash: event.image!.blurHash,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              event.name,
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              children: [
                Text(event.distance.metricSystem),
                const SizedBox(width: 4),
                Text(event.rating.toString()),
              ],
            ),
            Row(
              children: [
                Text(event.price.monetary),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    event.start.startAndEnd(event.end),
                    overflow: TextOverflow.ellipsis,
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
