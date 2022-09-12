import 'package:flutter/material.dart';

class DesignIconButton extends StatelessWidget {
  const DesignIconButton(
      {Key? key, required this.icon, required this.onPressed})
      : super(key: key);

  final Widget icon;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: icon,
      color: Colors.white,
      onPressed: onPressed,
    );
  }
}
