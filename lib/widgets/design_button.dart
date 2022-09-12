import 'package:flutter/material.dart';
import 'package:pingo/constants/design_color.dart';
import 'package:pingo/constants/design_size.dart';

class DesignButton extends StatelessWidget {
  const DesignButton({
    Key? key,
    required this.title,
    this.onPressed,
    this.isActive = false,
  }) : super(key: key);

  final String title;
  final Function()? onPressed;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: DesignSize.buttonHeight,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: isActive ? DesignColor.primary500 : DesignColor.text300,
          textStyle: const TextStyle(fontSize: 20),
        ),
        onPressed: onPressed,
        child: Text(title),
      ),
    );
  }
}
