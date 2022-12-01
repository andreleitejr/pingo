import 'package:flutter/material.dart';
import 'package:pingo/constants/design_color.dart';
import 'package:pingo/constants/design_size.dart';
import 'package:pingo/constants/design_text_style.dart';

class DesignOutlinedButton extends StatelessWidget {
  const DesignOutlinedButton({
    Key? key,
    required this.title,
    this.onPressed,
    this.isActive = true,
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
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: isActive
              ? (backgroundColor ?? Colors.white)
              : DesignColor.text300,
          foregroundColor: textColor ?? DesignColor.primary500,
          textStyle: DesignTextStyle.labelSmall11Bold,
          side: BorderSide(
            width: 1.25,
            color: isActive ? DesignColor.primary500 : DesignColor.text300,
          ),
        ),
        onPressed: onPressed,
        child: Text(title),
      ),
    );
  }
}
