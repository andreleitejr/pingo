import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pingo/constants/design_color.dart';
import 'package:pingo/constants/design_images.dart';
import 'package:pingo/core/extensions.dart';
import 'package:pingo/features/event/models/event.dart';
import 'package:pingo/features/event/pages/read/event_read_page.dart';

class DesignEventItem extends StatelessWidget {
  const DesignEventItem({Key? key, required this.event}) : super(key: key);
  final Event event;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(EventReadPage(event: event)),
      child: SizedBox(
        height: 180,
        width: (Get.width / 3) - 26,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: (Get.width / 3) - 26,
              decoration: BoxDecoration(
                color: DesignColor.text200,
                image: DecorationImage(
                  image:
                      NetworkImage(event.image ?? DesignImages.fallbackImage),
                  fit: BoxFit.fill,
                ),
              ),
            ),
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
                Expanded(child:
                Text(
                  event.start.startAndEnd(event.end),
                  overflow: TextOverflow.ellipsis,
                ),),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
