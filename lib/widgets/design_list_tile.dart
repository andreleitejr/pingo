import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:get/get.dart';
import 'package:pingo/constants/design_text_style.dart';
import 'package:pingo/services/blurhash_controller.dart';
import 'package:pingo/widgets/design_shimmer_widget.dart';
import 'package:pingo/widgets/design_space.dart';
import 'package:pingo/widgets/shimmers/shimmer_list_tile.dart';

class DesignListTile extends StatelessWidget {
  const DesignListTile({
    Key? key,
    this.image,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onPressed,
    this.isLoading = false,
  }) : super(key: key);

  final ImageBlurHash? image;
  final String title;
  final String? subtitle;
  final String? trailing;
  final Function()? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const ShimmerListTile();
    }
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          SizedBox(
            height: 60,
            child: Row(
              children: [
                const DesignSpace(
                    orientation: DesignSpaceOrientation.horizontal),
                image != null
                    ? SizedBox(
                        width: 60,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: BlurHash(
                            imageFit: BoxFit.cover,
                            image: image!.image,
                            hash: image!.blurHash,
                          ),
                        ),
                      )
                    : Container(),
                const DesignSpace(
                  orientation: DesignSpaceOrientation.horizontal,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(title),
                          ),
                          trailing != null ? Text(trailing!) : Container(),
                        ],
                      ),
                      subtitle != null
                          ? Text(
                              subtitle!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: DesignTextStyle.labelMedium12,
                            )
                          : Container(),
                      const Text('Average price \$29.99'),
                    ],
                  ),
                ),
                const DesignSpace(
                    orientation: DesignSpaceOrientation.horizontal),
              ],
            ),
          ),
          const DesignSpace(),
        ],
      ),
    );
  }
}
