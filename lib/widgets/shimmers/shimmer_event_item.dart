import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pingo/widgets/design_shimmer_widget.dart';

class ShimmerEventItem extends StatelessWidget {
  ShimmerEventItem({Key? key}) : super(key: key);

  final _width = (Get.width / 2) - 32;

  @override
  Widget build(BuildContext context) {
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
}
