import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:get/get.dart';
import 'package:pingo/constants/design_color.dart';
import 'package:pingo/constants/design_size.dart';
import 'package:pingo/constants/design_text_style.dart';
import 'package:pingo/core/extensions.dart';
import 'package:pingo/features/place/models/place.dart';
import 'package:pingo/features/place/pages/read/place_read_page.dart';
import 'package:pingo/widgets/design_shimmer_widget.dart';
import 'package:pingo/widgets/design_space.dart';

class DesignBestMatchItem extends StatelessWidget {
  const DesignBestMatchItem({
    Key? key,
    required this.bestMatch,
    this.isLoading = false,
  }) : super(key: key);

  final Place? bestMatch;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return DesignShimmerWidget(
        child: Container(
          width: Get.width * 0.6,
          margin: const EdgeInsets.only(right: DesignSize.mediumSpace),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      );
    }
    return GestureDetector(
      onTap: () => Get.to(() => PlaceReadPage(place: bestMatch!)),
      child: Container(
        width: Get.width * 0.6,
        margin: const EdgeInsets.only(right: DesignSize.mediumSpace),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: bestMatch != null
              ? Stack(
                  children: [
                    BlurHash(
                      imageFit: BoxFit.cover,
                      image: bestMatch!.image!.image,
                      hash: bestMatch!.image!.blurHash,
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 6),
                              height: 24,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.85),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    bestMatch!.matchEmoji,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    bestMatch!.matchMessage,
                                    style:
                                        DesignTextStyle.bodySmall14Bold.apply(
                                      color: DesignColor.text500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(child: Container()),
                            Text(
                              bestMatch!.name,
                              style: DesignTextStyle.bodySmall14Bold.apply(
                                color: DesignColor.primary100,
                              ),
                            ),
                            const SizedBox(height: 4),
                            if (bestMatch!.description != null)
                              Container(
                                constraints:
                                    const BoxConstraints(maxWidth: 200),
                                child: Text(
                                  bestMatch!.description!,
                                  style: DesignTextStyle.bodySmall12.apply(
                                    color: Colors.white,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Container(
                                  constraints:
                                      const BoxConstraints(maxWidth: 200),
                                  child: Text(
                                    bestMatch!.rating.toString(),
                                    style: DesignTextStyle.bodySmall12.apply(
                                      color: Colors.white,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const DesignSpace(
                                  orientation:
                                      DesignSpaceOrientation.horizontal,
                                  size: DesignSize.smallSpace,
                                ),
                                Container(
                                  constraints:
                                      const BoxConstraints(maxWidth: 200),
                                  child: Text(
                                    bestMatch!.distance.metricSystem,
                                    style: DesignTextStyle.bodySmall12.apply(
                                      color: Colors.white,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              : Container(
                  color: DesignColor.text200,
                ),
        ),
      ),
    );
  }
}
