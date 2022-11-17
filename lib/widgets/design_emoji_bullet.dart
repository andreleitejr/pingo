import 'package:flutter/material.dart';
import 'package:pingo/constants/design_color.dart';
import 'package:pingo/constants/design_text_style.dart';

class DesignEmojiBullet extends StatelessWidget {
  const DesignEmojiBullet({
    Key? key,
    required this.emoji,
    required this.title,
    this.textStyle,
    this.emojiSize,
  }) : super(key: key);

  final String emoji;
  final String title;
  final TextStyle? textStyle;
  final double? emojiSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 6),
      height: 24,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.85),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            emoji,
            style: TextStyle(
              fontSize: emojiSize ?? 14,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            title,
            style: textStyle ??
                DesignTextStyle.bodySmall12Bold.apply(
                  color: DesignColor.text500,
                ),
          ),
        ],
      ),
    );
  }
}
