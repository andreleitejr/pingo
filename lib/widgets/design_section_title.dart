import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pingo/constants/design_color.dart';
import 'package:pingo/constants/design_text_style.dart';
import 'package:pingo/widgets/design_shimmer_widget.dart';

class DesignSectionTitle extends StatelessWidget {
  const DesignSectionTitle({
    Key? key,
    required this.title,
    required this.onActionPressed,
    this.actionTitle,
    this.padding,
    this.isLoading = false,
  }) : super(key: key);

  final String title;
  final Function() onActionPressed;
  final String? actionTitle;
  final EdgeInsets? padding;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Padding(
        padding: padding ?? EdgeInsets.zero,
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
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: DesignTextStyle.bodyMedium16Bold,
            ),
          ),
          TextButton(
            onPressed: onActionPressed,
            child: Text(
              actionTitle ?? 'See all',
              style: DesignTextStyle.bodySmall14Bold
                  .apply(color: DesignColor.primary500),
            ),
          ),
        ],
      ),
    );
  }
}
