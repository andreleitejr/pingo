import 'package:flutter/material.dart';
import 'package:pingo/constants/design_color.dart';
import 'package:pingo/constants/design_size.dart';
import 'package:pingo/constants/design_text_style.dart';

class DesignBulletItem extends StatelessWidget {
  const DesignBulletItem({
    Key? key,
    required this.title,
    this.icon,
    this.isSelected = false,
    this.unselectedColor,
    this.onPressed,
    this.padding,
  }) : super(key: key);

  final String title;
  final Widget? icon;
  final bool isSelected;
  final Color? unselectedColor;
  final Function()? onPressed;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        height: 38,
        padding: padding ??
            const EdgeInsets.symmetric(horizontal: DesignSize.mediumSpace),
        margin: const EdgeInsets.only(right: DesignSize.smallSpace),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: isSelected ? DesignColor.primary100 : Colors.transparent,
          border: Border.all(
            color: isSelected
                ? DesignColor.primary100
                : (unselectedColor ?? DesignColor.primary500),
            width: 2,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) icon!,
            Text(
              title,
              style: DesignTextStyle.bodyMedium16Bold.apply(
                color: isSelected
                    ? DesignColor.primary700
                    : (unselectedColor ?? DesignColor.primary500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
