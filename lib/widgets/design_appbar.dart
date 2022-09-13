import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pingo/constants/design_color.dart';
import 'package:pingo/constants/design_text_style.dart';
import 'package:pingo/widgets/design_horizontal_medium_divider.dart';
import 'package:pingo/widgets/design_icon.dart';

class DesignAppBar extends StatelessWidget {
  const DesignAppBar({
    super.key,
    this.title,
    this.showLeading = true,
    this.actionText,
    this.onLeadingPressed,
    this.onActionPressed,
    this.actionValid = false,
  });

  final String? title;
  final bool showLeading;
  final String? actionText;
  final Function()? onLeadingPressed;
  final Function()? onActionPressed;
  final bool actionValid;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Row(
          children: <Widget>[
            // const Spacer(),
            if (showLeading)
              DesignIconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 24,
                ),
                onPressed: onLeadingPressed ?? () => Get.back(),
              ),
            Expanded(
              child: title != null
                  ? Text(
                      title!,
                      textAlign: TextAlign.center,
                    )
                  : Container(),
            ),
            if (showLeading && actionText == null) const SizedBox(width: 24),
            if (actionText != null && onActionPressed != null) ...[
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
              const DesignHorizontalMediumDivider(),
            ]
            // DesignIconButton()
          ],
        ),
      ],
    );
  }
}
