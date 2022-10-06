import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pingo/constants/design_color.dart';
import 'package:pingo/constants/design_images.dart';
import 'package:pingo/core/extensions.dart';
import 'package:pingo/features/event/models/event.dart';
import 'package:pingo/features/event/pages/read/event_read_page.dart';

class DesignEventItem extends StatelessWidget {
  DesignEventItem({Key? key, required this.event}) : super(key: key);
  final Event event;

  final _height = 221.0;
  final _width = (Get.width / 2) - 32;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(EventReadPage(event: event)),
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
