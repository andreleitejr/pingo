import 'package:flutter/material.dart';
import 'package:pingo/constants/design_color.dart';
import 'package:pingo/constants/design_size.dart';

class DesignOutlinedButton extends StatelessWidget {
  const DesignOutlinedButton({
    Key? key,
    required this.title,
    this.onPressed,
    this.isActive = true,
  }) : super(key: key);

  final String title;
  final Function()? onPressed;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: DesignSize.buttonHeight,
      width: double.infinity,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          primary: isActive ? DesignColor.primary500 : DesignColor.text300,
          textStyle: const TextStyle(fontSize: 20),
          side: BorderSide(
            width: 2,
            color: isActive ? DesignColor.primary500 : DesignColor.text300,
          ),
        ),
        onPressed: onPressed,
        child: Text(title),
      ),
    );
  }
}
