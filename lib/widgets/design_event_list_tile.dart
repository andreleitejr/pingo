import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:pingo/constants/design_color.dart';
import 'package:pingo/constants/design_icons.dart';
import 'package:pingo/constants/design_size.dart';
import 'package:pingo/constants/design_text_style.dart';
import 'package:pingo/core/extensions.dart';
import 'package:pingo/features/event/models/event.dart';
import 'package:pingo/widgets/design_icon.dart';
import 'package:pingo/widgets/design_space.dart';
import 'package:pingo/widgets/shimmers/shimmer_list_tile.dart';

class DesignEventListTile extends StatelessWidget {
  const DesignEventListTile({
    Key? key,
    required this.event,
    this.onPressed,
    this.isLoading = false,
  }) : super(key: key);

  final Event event;
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
          Container(
            padding: const EdgeInsets.only(bottom: DesignSize.mediumSpace),
            height: 54,
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
                event.image != null
                    ? SizedBox(
                        width: 42,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: BlurHash(
                            imageFit: BoxFit.cover,
                            image: event.image!.image,
                            hash: event.image!.blurHash,
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
                            child: Text(
                              event.name,
                              style: DesignTextStyle.bodySmall12Bold,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(bottom: 2),
                            child: Opacity(
                              opacity: 0.7,
                              child: DesignIcon(
                                icon: DesignIcons.pin,
                                width: 8,
                                height: 8,
                                color: DesignColor.primary300,
                              ),
                            ),
                          ),
                          const DesignSpace(
                            orientation: DesignSpaceOrientation.horizontal,
                            size: DesignSize.minimumSpace,
                          ),
                          Text(
                            event.distance.metricSystem,
                            style: DesignTextStyle.labelSmall10,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const SizedBox(width: 4),
                          const Padding(
                            padding: EdgeInsets.only(bottom: 2),
                            child: Opacity(
                              opacity: 0.7,
                              child: DesignIcon(
                                icon: DesignIcons.star,
                                width: 7,
                                height: 7,
                                color: DesignColor.primary300,
                              ),
                            ),
                          ),
                          const DesignSpace(
                              orientation: DesignSpaceOrientation.horizontal,
                              size: DesignSize.minimumSpace),
                          Text(
                            event.rating.toString(),
                            style: DesignTextStyle.labelSmall8.apply(
                              color: DesignColor.text400,
                            ),
                          ),
                          SizedBox(
                            height: 12,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: event.keywords.length > 2
                                  ? 2
                                  : event.keywords.length,
                              itemBuilder: (BuildContext context, int index) {
                                return keywordBullet(
                                    event.keywords[index].keyword);
                              },
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '${event.description}',
                        maxLines: 1,
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
          const DesignSpace(),
        ],
      ),
    );
  }

  Widget keywordBullet(String title) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 4),
      margin: const EdgeInsets.only(left: 4),
      height: 12,
      decoration: BoxDecoration(
        color: DesignColor.primary100.withOpacity(0.25),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: DesignColor.primary300.withOpacity(0.25),
          width: 0.5,
        ),
      ),
      child: Text(
        title,
        style: DesignTextStyle.labelSmall8.apply(
          color: DesignColor.primary500,
        ),
      ),
    );
  }
}
