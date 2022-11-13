import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pingo/constants/design_color.dart';
import 'package:pingo/constants/design_size.dart';
import 'package:pingo/constants/design_text_style.dart';
import 'package:pingo/widgets/shimmers/shimmer_section_title.dart';

class DesignSectionTitle extends StatelessWidget {
  const DesignSectionTitle({
    Key? key,
    required this.title,
    this.onActionPressed,
    this.actionTitle,
    this.padding,
    this.isLoading = false,
  }) : super(key: key);

  final String title;
  final Function()? onActionPressed;
  final String? actionTitle;
  final EdgeInsets? padding;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const ShimmerSectionTitle();
    }
    return Container(
      height: 36,
      padding: const EdgeInsets.symmetric(
        horizontal: DesignSize.mediumSpace,
      ),
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
