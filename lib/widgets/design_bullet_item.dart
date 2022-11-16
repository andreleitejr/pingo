import 'package:flutter/material.dart';
import 'package:pingo/constants/design_color.dart';
import 'package:pingo/constants/design_size.dart';
import 'package:pingo/constants/design_text_style.dart';
import 'package:pingo/widgets/design_shimmer_widget.dart';

class DesignBulletItem extends StatelessWidget {
  const DesignBulletItem({
    Key? key,
    required this.title,
    this.icon,
    this.isSelected = false,
    this.unselectedColor,
    this.onPressed,
    this.padding,
    this.isLoading = false,
  }) : super(key: key);

  final String title;
  final Widget? icon;
  final bool isSelected;
  final Color? unselectedColor;
  final Function()? onPressed;
  final EdgeInsetsGeometry? padding;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return DesignShimmerWidget(
        child: Container(
          alignment: Alignment.center,
          height: 38,
          padding: padding ??
              const EdgeInsets.symmetric(horizontal: DesignSize.mediumSpace),
          margin: const EdgeInsets.only(right: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: Colors.black,
            border: Border.all(
              width: 1.35,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) icon!,
              Text(
                title,
                style: DesignTextStyle.bodyMedium16Bold,
              ),
            ],
          ),
        ),
      );
    }
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        height: 38,
        padding: padding ??
            const EdgeInsets.symmetric(horizontal: DesignSize.mediumSpace),
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: isSelected ? DesignColor.primary100 : Colors.transparent,
          border: Border.all(
            color: isSelected
                ? DesignColor.primary100
                : (unselectedColor ?? DesignColor.primary500),
            width: 1.35,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) icon!,
            Text(
              title,
              style: isSelected
                  ? DesignTextStyle.bodySmall12Bold.apply(
                      color: DesignColor.primary700,
                    )
                  : DesignTextStyle.bodySmall12.apply(
                      color: (unselectedColor ?? DesignColor.primary500),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
