import 'package:flutter/material.dart';
import 'package:pingo/constants/design_color.dart';
import 'package:pingo/constants/design_text_style.dart';

class DesignTextButton extends StatelessWidget {
  const DesignTextButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Text(
        'Forgot your password?',
        style: DesignTextStyle.bodyMedium16.apply(color: DesignColor.primary500),
      ),
    );
  }
}
