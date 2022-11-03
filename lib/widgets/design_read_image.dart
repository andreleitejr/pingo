import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pingo/constants/design_images.dart';
import 'package:pingo/widgets/design_shimmer_widget.dart';

class DesignAvatarImage extends StatelessWidget {
  const DesignAvatarImage({
    Key? key,
    required this.image,
    this.isLoading = false,
    this.height,
    this.width,
  }) : super(key: key);

  final String? image;
  final bool isLoading;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    if (isLoading || image == null) {
      return DesignShimmerWidget(
        child: Container(
          height: height ?? 24,
          width: width ?? 24,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(24),
          ),
        ),
      );
    }
    return Container(
      height: height ?? 24,
      width: width ?? 24,
      decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(image ?? DesignImages.fallbackImage),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(50)),
    );
  }
}
