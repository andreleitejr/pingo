import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:get/get.dart';
import 'package:pingo/constants/design_color.dart';
import 'package:pingo/constants/design_icons.dart';
import 'package:pingo/constants/design_size.dart';
import 'package:pingo/constants/design_text_style.dart';
import 'package:pingo/core/extensions.dart';
import 'package:pingo/features/place/models/place.dart';
import 'package:pingo/features/place/pages/read/place_read_page.dart';
import 'package:pingo/models/base.dart';
import 'package:pingo/models/matchbase.dart';
import 'package:pingo/widgets/design_avatar_image.dart';
import 'package:pingo/widgets/design_icon.dart';
import 'package:pingo/widgets/design_read_image.dart';
import 'package:pingo/widgets/design_shimmer_widget.dart';
import 'package:pingo/widgets/design_space.dart';

class DesignBestMatchItem extends StatelessWidget {
  const DesignBestMatchItem({
    Key? key,
    required this.bestMatch,
    this.isLoading = false,
    this.width,
  }) : super(key: key);

  final Place bestMatch;
  final bool isLoading;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (bestMatch is Place) {
          Get.to(() => PlaceReadPage(place: bestMatch as Place));
        }
      },
      child: Container(
        width: width ?? Get.width * 0.6,
        margin: const EdgeInsets.only(right: DesignSize.mediumSpace),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            children: [
              BlurHash(
                imageFit: BoxFit.cover,
                image: bestMatch.image!.image,
                hash: bestMatch.image!.blurHash,
              ),
              Positioned(
                left: 0,
                top: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        height: 24,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.85),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              bestMatch.matchEmoji,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              bestMatch.matchMessage,
                              style: DesignTextStyle.bodySmall12Bold.apply(
                                color: DesignColor.text500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(child: Container()),
                      Row(
                        children: [
                          DesignAvatarImage(
                            image: bestMatch.image!.image,
                            blurHash: bestMatch.image!.blurHash,
                          ),
                          const DesignSpace(
                            orientation: DesignSpaceOrientation.horizontal,
                            size: DesignSize.smallSpace,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    bestMatch.name,
                                    style:
                                        DesignTextStyle.labelSmall11Bold.apply(
                                      color: DesignColor.primary100,
                                    ),
                                  ),
                                  const SizedBox(width: 2),
                                  if (bestMatch.verified)
                                    const Padding(
                                      padding: EdgeInsets.only(bottom: 2),
                                      child: Opacity(
                                        opacity: 0.9,
                                        child: DesignIcon(
                                          icon: DesignIcons.verified,
                                          width: 11,
                                          height: 11,
                                          color: Colors.transparent,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              const DesignSpace(size: DesignSize.minimumSpace),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(bottom: 2),
                                    child: Opacity(
                                      opacity: 0.9,
                                      child: DesignIcon(
                                        icon: DesignIcons.pin,
                                        width: 9,
                                        height: 9,
                                        color: DesignColor.primary100,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 2),
                                  Text(
                                    bestMatch.distance.metricSystem,
                                    style: DesignTextStyle.labelSmall10.apply(
                                      color: Colors.white,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const DesignSpace(
                                    orientation:
                                        DesignSpaceOrientation.horizontal,
                                    size: 8,
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(bottom: 2),
                                    child: Opacity(
                                      opacity: 0.9,
                                      child: DesignIcon(
                                        icon: DesignIcons.star,
                                        width: 9,
                                        height: 9,
                                        color: DesignColor.primary100,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 2),
                                  Text(
                                    bestMatch.rating.toString(),
                                    style: DesignTextStyle.labelSmall10.apply(
                                      color: Colors.white,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
