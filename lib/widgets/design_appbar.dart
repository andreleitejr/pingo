import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pingo/constants/design_color.dart';
import 'package:pingo/constants/design_icons.dart';
import 'package:pingo/constants/design_text_style.dart';
import 'package:pingo/widgets/design_icon_button.dart';
import 'package:pingo/widgets/design_space.dart';

class DesignAppBar extends StatelessWidget {
  const DesignAppBar({
    super.key,
    this.title,
    this.showLeading = true,
    this.actionText,
    this.onLeadingPressed,
    this.onActionPressed,
    this.actionValid = false,
    this.actionIcon,
  });

  final String? title;
  final bool showLeading;
  final String? actionText;
  final String? actionIcon;
  final Function()? onLeadingPressed;
  final Function()? onActionPressed;
  final bool actionValid;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 94,
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              if (showLeading)
                DesignIconButton(
                  icon: DesignIcons.arrowLeft,
                  onPressed: onLeadingPressed ?? () => Get.back(),
                  alignment: Alignment.centerLeft,
                ),
              Expanded(
                child: title != null
                    ? Text(
                        title!,
                        textAlign: TextAlign.center,
                        style: DesignTextStyle.bodyMedium16Bold,
                      )
                    : Container(),
              ),
              if (showLeading && actionText == null) const SizedBox(width: 24),
              if (actionText != null && actionIcon == null) ...[
                TextButton(
                  onPressed: onActionPressed,
                  child: Text(
                    actionText!,
                    textAlign: TextAlign.center,
                    style: DesignTextStyle.bodySmall14Bold.apply(
                      color: actionValid
                          ? DesignColor.primary700
                          : DesignColor.text300,
                    ),
                  ),
                ),
                const DesignSpace(
                    orientation: DesignSpaceOrientation.horizontal),
              ] else ...[
                if (actionIcon != null)
                  DesignIconButton(
                    onPressed: onActionPressed ?? () {},
                    icon: actionIcon!,
                  ),
              ],
              // DesignIconButton()
            ],
          ),
        ],
      ),
    );
  }
}
