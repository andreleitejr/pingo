import 'package:flutter/material.dart';
import 'package:pingo/constants/design_color.dart';
import 'package:pingo/constants/design_text_style.dart';

class DesignListButton extends StatelessWidget {
  const DesignListButton({Key? key, required this.title, this.icon})
      : super(key: key);

  final String title;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 56,
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: DesignColor.text200,
            ),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(title,
              style: DesignTextStyle.bodySmall14Bold,),
            ),
            Icon(
              icon ?? Icons.arrow_forward_ios,
              size: 16,
            )
          ],
        ),
      ),
    );
  }
}
