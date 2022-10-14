import 'package:flutter/material.dart';
import 'package:pingo/constants/design_size.dart';

class DesignIcon extends StatelessWidget {
  const DesignIcon({Key? key, required this.icon, this.height, this.width})
      : super(key: key);

  final String icon;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.5,
      child: SizedBox(
        height: height ?? DesignSize.icon,
        width: width ?? DesignSize.icon,
        child: Image.asset(icon),
      ),
    );
  }
}
