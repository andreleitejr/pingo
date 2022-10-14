import 'package:flutter/material.dart';
import 'package:pingo/widgets/design_icon.dart';

class DesignIconButton extends StatelessWidget {
  const DesignIconButton(
      {Key? key, required this.icon, required this.onPressed})
      : super(key: key);

  final String icon;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: DesignIcon(
        icon: icon,
      ),
    );
  }
}
