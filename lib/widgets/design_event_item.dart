import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pingo/core/extensions.dart';
import 'package:pingo/features/event/models/event.dart';
import 'package:pingo/features/product/models/product.dart';

class DesignEventItem extends StatelessWidget {
  const DesignEventItem({Key? key, required this.event}) : super(key: key);
  final Event event;

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
            color: Colors.grey,
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
              Text(event.start.toString()),
            ],
          ),
        ],
      ),
    );
  }
}
