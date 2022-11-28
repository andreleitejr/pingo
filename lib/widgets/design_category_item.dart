import 'package:flutter/material.dart';
import 'package:pingo/constants/design_color.dart';
import 'package:pingo/constants/design_size.dart';
import 'package:pingo/constants/design_text_style.dart';

class DesignCategoryItem extends StatelessWidget {
  const DesignCategoryItem({
    Key? key,
    required this.title,
    this.onPressed,
    required this.image,
    this.isLoading = false,
  }) : super(key: key);

  final String title;
  final Function()? onPressed;
  final String image;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 46,
        margin: const EdgeInsets.only(right: DesignSize.mediumSpace),
        child: Column(
          children: [
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: Text(
                  image,
                  style: const TextStyle(fontSize: 36),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            // const DesignSpace(),
            Container(
              height: 10,
              width: double.infinity,
              alignment: Alignment.center,
              child: Text(
                title,
                style: DesignTextStyle.labelSmall10.apply(color: DesignColor.text400),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
