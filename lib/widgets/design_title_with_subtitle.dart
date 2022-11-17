import 'package:flutter/material.dart';
import 'package:pingo/constants/design_color.dart';
import 'package:pingo/constants/design_size.dart';
import 'package:pingo/constants/design_text_style.dart';
import 'package:pingo/widgets/design_space.dart';

class DesignTitleWithSubtitle extends StatelessWidget {
  const DesignTitleWithSubtitle({Key? key, this.title, this.subtitle})
      : super(key: key);

  final String? title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: DesignSize.mediumSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Text(
              title!,
              style: DesignTextStyle.bodySmall14Bold.apply(
                color: DesignColor.text500,
              ),
            ),
          const DesignSpace(size: DesignSize.smallSpace),
          if (subtitle != null)
            Text(
              subtitle!,
              style: DesignTextStyle.bodySmall12.apply(
                color: DesignColor.text400,
              ),
            ),
        ],
      ),
    );
  }
}
