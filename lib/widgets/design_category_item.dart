import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pingo/constants/design_size.dart';
import 'package:pingo/widgets/design_shimmer_widget.dart';
import 'package:pingo/widgets/design_space.dart';

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
    if (isLoading) {
      return DesignShimmerWidget(
          child: Column(
        children: [
          Expanded(
            child: Container(
              width: 64,
              margin: const EdgeInsets.only(right: DesignSize.mediumSpace),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(40),
              ),
            ),
          ),
          const DesignSpace(),
          Container(
            height: 16,
            width: 64,
            margin: const EdgeInsets.only(right: DesignSize.mediumSpace),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(40),
            ),
          ),
        ],
      ));
    }
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.only(right: DesignSize.mediumSpace),
        child: Column(
          children: [
            Text(
              image,
              style: const TextStyle(fontSize: 42),
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
