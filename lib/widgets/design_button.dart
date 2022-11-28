import 'package:flutter/material.dart';
import 'package:pingo/constants/design_color.dart';
import 'package:pingo/constants/design_size.dart';
import 'package:pingo/constants/design_text_style.dart';

class DesignButton extends StatelessWidget {
  const DesignButton({
    Key? key,
    required this.title,
    this.onPressed,
    this.isActive = false,
    this.backgroundColor,
    this.textColor,
  }) : super(key: key);

  final String title;
  final Function()? onPressed;
  final bool isActive;
  final Color? backgroundColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: DesignSize.buttonHeight,
      width: double.infinity,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: isActive
              ? (backgroundColor ?? DesignColor.primary500)
              : DesignColor.text200,
          foregroundColor: Colors.white,
          textStyle: DesignTextStyle.labelSmall11Bold,
        ),
        onPressed: onPressed,
        child: Text(title),
      ),
    );
  }
}
