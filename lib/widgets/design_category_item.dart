import 'package:flutter/material.dart';
import 'package:pingo/constants/design_size.dart';
import 'package:pingo/widgets/design_space.dart';

class DesignCategoryItem extends StatelessWidget {
  const DesignCategoryItem({Key? key, required this.title, this.onPressed}) : super(key: key);

  final String title;
  final Function()? onPressed;

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
            Container(
              height: 72,
              color: Colors.grey,
            ),
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
