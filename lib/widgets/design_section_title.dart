import 'package:flutter/material.dart';
import 'package:pingo/constants/design_color.dart';
import 'package:pingo/constants/design_text_style.dart';

class DesignSectionTitle extends StatelessWidget {
  const DesignSectionTitle({
    Key? key,
    required this.title,
    required this.onActionPressed,
    this.actionTitle,
    this.padding,
  }) : super(key: key);

  final String title;
  final Function() onActionPressed;
  final String? actionTitle;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
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
