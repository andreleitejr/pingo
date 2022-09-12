import 'package:flutter/material.dart';
import 'package:pingo/constants/design_color.dart';
import 'package:pingo/constants/design_size.dart';
import 'package:pingo/constants/design_text_style.dart';

class DesignTitleWithSubtitle extends StatelessWidget {
  const DesignTitleWithSubtitle({Key? key, this.title, this.subtitle})
      : super(key: key);

  final String? title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(DesignSize.padding),
      height: 72,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Text(
              title!,
              style: DesignTextStyle.bodyLarge18Bold.apply(
                color: DesignColor.text400,
              ),
            ),
          if (subtitle != null)
            Text(
              subtitle!,
              style: DesignTextStyle.bodyMedium16.apply(
                color: DesignColor.text500,
              ),
            ),
        ],
      ),
    );
  }
}
