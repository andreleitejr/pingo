import 'package:flutter/material.dart';
import 'package:pingo/constants/design_color.dart';
import 'package:pingo/widgets/design_shimmer_widget.dart';

class DesignAvatarImage extends StatelessWidget {
  const DesignAvatarImage({
    Key? key,
    required this.image,
    this.isLoading = false,
  }) : super(key: key);

  final String? image;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    if (isLoading || image == null) {
      return DesignShimmerWidget(
        child: Container(
          height: 24,
          width: 24,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(24),
          ),
        ),
      );
    }
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: DesignColor.primary500,
        borderRadius: BorderRadius.circular(48),
        image: DecorationImage(
          image: NetworkImage(image!),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
