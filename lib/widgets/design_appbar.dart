import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pingo/constants/design_color.dart';
import 'package:pingo/constants/design_icons.dart';
import 'package:pingo/constants/design_size.dart';
import 'package:pingo/constants/design_text_style.dart';
import 'package:pingo/widgets/design_icon.dart';
import 'package:pingo/widgets/design_icon_button.dart';
import 'package:pingo/widgets/design_space.dart';

class DesignAppBar extends StatelessWidget {
  const DesignAppBar({
    super.key,
    this.title,
    this.showLeading = true,
    this.verified = false,
    this.actionText,
    this.onLeadingPressed,
    this.onActionPressed,
    this.actionValid = false,
    this.leadingIcon,
    this.actionIcon,
    this.textStyle,
  });

  final String? title;
  final bool showLeading;
  final bool verified;
  final String? actionText;
  final String? leadingIcon;
  final String? actionIcon;
  final Function()? onLeadingPressed;
  final Function()? onActionPressed;
  final bool actionValid;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          if (showLeading)
            SizedBox(
              width: 54,
              child: DesignIconButton(
                icon: leadingIcon ?? DesignIcons.arrowLeft,
                onPressed: onLeadingPressed ?? () => Get.back(),
                alignment: Alignment.centerLeft,
                width: 16,
                height: 16,
              ),
            ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (title != null)
                  Text(
                    title!,
                    style: textStyle ??
                        DesignTextStyle.bodySmall14Bold.apply(
                          color: DesignColor.text400,
                        ),
                    overflow: TextOverflow.ellipsis,
                  ),
                if (verified) ...[
                  const DesignSpace(
                    orientation: DesignSpaceOrientation.horizontal,
                    size: DesignSize.minimumSpace,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 2),
                    child: Opacity(
                      opacity: 0.9,
                      child: DesignIcon(
                        icon: DesignIcons.verified,
                        width: 11,
                        height: 11,
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ]
              ],
            ),
          ),
          if (actionText != null && actionIcon == null) ...[
            TextButton(
              onPressed: onActionPressed,
              child: Text(
                actionText!,
                textAlign: TextAlign.center,
                style: DesignTextStyle.bodySmall12Bold.apply(
                  color: actionValid
                      ? DesignColor.primary700
                      : DesignColor.text300,
                ),
              ),
            ),
            const DesignSpace(orientation: DesignSpaceOrientation.horizontal),
          ] else ...[
            SizedBox(
              width: 54,
              child: actionIcon != null
                  ? DesignIconButton(
                      height: 48,
                      onPressed: onActionPressed ?? () {},
                      icon: actionIcon!,
                    )
                  : Container(),
            ),
          ],
        ],
      ),
    );
  }
}
