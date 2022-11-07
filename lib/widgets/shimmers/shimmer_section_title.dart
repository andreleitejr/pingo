import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pingo/constants/design_size.dart';
import 'package:pingo/widgets/design_shimmer_widget.dart';

class ShimmerSectionTitle extends StatelessWidget {
  const ShimmerSectionTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: DesignSize.mediumSpace,
      ),
      child: DesignShimmerWidget(
        child: Row(
          children: [
            Container(
              height: 18,
              width: Get.width * 0.5,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(40),
              ),
            ),
            Expanded(child: Container()),
            Container(
              height: 18,
              width: 60,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(40),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
