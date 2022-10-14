import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pingo/constants/design_size.dart';
import 'package:pingo/widgets/design_space.dart';

class DesignCategoryItem extends StatelessWidget {
  const DesignCategoryItem({Key? key, required this.title, this.onPressed, required this.image})
      : super(key: key);

  final String title;
  final Function()? onPressed;
  final String image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 72,
        width: 80,
        margin: const EdgeInsets.only(right: DesignSize.mediumSpace),
        child: Column(
          children: [
            Text(image, style: const TextStyle(fontSize: 54),),
            const DesignSpace(),
            Text(
              title,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
