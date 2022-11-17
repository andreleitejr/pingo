import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:get/get.dart';
import 'package:pingo/constants/design_color.dart';
import 'package:pingo/constants/design_images.dart';
import 'package:pingo/widgets/design_shimmer_widget.dart';

class DesignAvatarImage extends StatelessWidget {
  const DesignAvatarImage({
    Key? key,
    required this.image,
    this.blurHash,
    this.isLoading = false,
    this.height,
    this.width,
    this.isSelected = false,
  }) : super(key: key);

  final String? image;

  final String? blurHash;
  final bool isLoading;
  final double? height;
  final double? width;
  final bool isSelected;

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
      height: height ?? (isSelected ? 28 : 24),
      width: width ?? (isSelected ? 28 : 24),
      decoration: BoxDecoration(
        border: Border.all(
          width: isSelected ? 1.25 : 0,
          color: isSelected ? DesignColor.primary500 : Colors.transparent,
        ),
        borderRadius: BorderRadius.circular(60)
      ),
      padding: EdgeInsets.all(isSelected ? 2 : 0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(width ?? 16),
        child: BlurHash(
          imageFit: BoxFit.cover,
          image: image,
          hash: blurHash ?? 'LEHLk~WB2yk8pyo0adR*.7kCMdnj',
        ),
      ),
    );
  }
}
