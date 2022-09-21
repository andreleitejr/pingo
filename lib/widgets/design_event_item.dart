import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pingo/constants/design_color.dart';
import 'package:pingo/core/extensions.dart';
import 'package:pingo/features/event/models/event.dart';
import 'package:pingo/features/product/models/product.dart';

class DesignEventItem extends StatelessWidget {
  const DesignEventItem({Key? key, required this.event}) : super(key: key);
  final Event event;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240,
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
                  event.image ?? 'https://www.generationsforpeace.org/wp-content/uploads/2018/03/empty.jpg',
                ),
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
            ],
          ),
          Row(
            children: [
              Text(event.price.monetary),
              const SizedBox(width: 8),
              Text(
                event.start.startAndEnd(event.end),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
