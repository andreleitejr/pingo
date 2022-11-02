import 'package:flutter/material.dart';
import 'package:pingo/widgets/design_icon.dart';

class DesignIconButton extends StatelessWidget {
  const DesignIconButton(
      {Key? key,
      required this.icon,
      required this.onPressed,
      this.height,
      this.width})
      : super(key: key);

  final String icon;
  final Function() onPressed;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(alignment: Alignment.centerRight),
        child: DesignIcon(
          icon: icon,
          height: height,
          width: width,
        ),
      ),
    );
  }
}
