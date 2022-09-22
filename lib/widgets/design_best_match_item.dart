import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pingo/constants/design_color.dart';
import 'package:pingo/constants/design_size.dart';
import 'package:pingo/constants/design_text_style.dart';
import 'package:pingo/core/extensions.dart';
import 'package:pingo/features/place/models/place.dart';
import 'package:pingo/features/place/pages/read/place_read_page.dart';

class DesignBestMatchItem extends StatelessWidget {
  const DesignBestMatchItem({Key? key, required this.bestMatch})
      : super(key: key);

  final Place bestMatch;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(PlaceReadPage(place: bestMatch)),
      child: Container(
        alignment: Alignment.center,
        width: Get.width * 0.6,
        margin: const EdgeInsets.only(right: DesignSize.mediumSpace),
        decoration: BoxDecoration(
          color: DesignColor.text200,
          image: DecorationImage(
            image: NetworkImage(
              bestMatch.image!,
            ),
            fit: BoxFit.fill,
          ),
        ),
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              color: Colors.black.withOpacity(0.35),
            ),
            Padding(
              padding: const EdgeInsets.all(DesignSize.mediumSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    bestMatch.name,
                    style: DesignTextStyle.bodyMedium16Bold
                        .apply(color: Colors.white),
                  ),
                  // Text(
                  //   controller.bestMatch[index].keywords.toString(),
                  // ),
                  Text(
                    'Match: ${bestMatch.match}',
                    style: DesignTextStyle.bodyMedium16Bold
                        .apply(color: Colors.white),
                  ),
                  Text(
                    'Distance: ${bestMatch.distance.metricSystem}',
                    style: DesignTextStyle.bodyMedium16Bold
                        .apply(color: Colors.white),
                  ),
                  Text(
                    'Rating: ${bestMatch.rating}',
                    style: DesignTextStyle.bodyMedium16Bold
                        .apply(color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
