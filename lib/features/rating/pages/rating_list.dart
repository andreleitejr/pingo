import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:pingo/constants/design_color.dart';
import 'package:pingo/constants/design_icons.dart';
import 'package:pingo/constants/design_size.dart';
import 'package:pingo/constants/design_text_style.dart';
import 'package:pingo/core/extensions.dart';
import 'package:pingo/features/rating/models/rating.dart';
import 'package:pingo/widgets/design_icon.dart';
import 'package:pingo/widgets/design_space.dart';

class RatingList extends StatelessWidget {
  const RatingList({Key? key, required this.ratings}) : super(key: key);

  final List<Rating> ratings;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: ratings.length,
      itemBuilder: (BuildContext context, int index) {
        final rating = ratings[index];

        return Column(
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: DesignSize.mediumSpace),
              height: 70,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 0.5,
                    color: DesignColor.text100,
                  ),
                ),
              ),
              child: Row(
                children: [
                  const DesignSpace(
                      orientation: DesignSpaceOrientation.horizontal),
                  rating.image != null
                      ? SizedBox(
                          width: 42,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: BlurHash(
                              imageFit: BoxFit.cover,
                              image: rating.image!.image,
                              hash: rating.image!.blurHash,
                            ),
                          ),
                        )
                      : Container(),
                  const DesignSpace(
                    orientation: DesignSpaceOrientation.horizontal,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                rating.title ?? 'No title found.',
                                style: DesignTextStyle.bodySmall12Bold,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(bottom: 2),
                              child: Opacity(
                                opacity: 0.7,
                                child: DesignIcon(
                                  icon: DesignIcons.event,
                                  width: 8,
                                  height: 8,
                                  color: DesignColor.text500,
                                ),
                              ),
                            ),
                            const DesignSpace(
                              orientation: DesignSpaceOrientation.horizontal,
                              size: DesignSize.smallSpace,
                            ),
                            Text(
                              rating.createdAt!.yMMMMd,
                              style: DesignTextStyle.labelSmall10,
                            ),
                          ],
                        ),
                        const DesignSpace(size: DesignSize.smallSpace),
                        Text(
                          '${rating.message}',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: DesignTextStyle.labelSmall10,
                        ),
                      ],
                    ),
                  ),
                  const DesignSpace(
                      orientation: DesignSpaceOrientation.horizontal),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
