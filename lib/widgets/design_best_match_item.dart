import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:get/get.dart';
import 'package:pingo/constants/design_color.dart';
import 'package:pingo/constants/design_size.dart';
import 'package:pingo/constants/design_text_style.dart';
import 'package:pingo/core/extensions.dart';
import 'package:pingo/features/place/models/place.dart';
import 'package:pingo/features/place/pages/read/place_read_page.dart';
import 'package:pingo/widgets/design_grid_view.dart';

class DesignBestMatchItem extends StatelessWidget {
  const DesignBestMatchItem({Key? key, required this.bestMatch})
      : super(key: key);

  final Place bestMatch;

  DesignBlurHashImage get hash => DesignBlurHashImage(
        image:
            bestMatch.image!,
        hash:
            'yGRT3%s.{]kC9vr=wbD\$jZ-oWBOZogs9;dayAcj[\$yaySh~VbH5RoK+tWCS\$mjayXnjFozbcf+OsjZ\$LbcSOaKV@Tfj[rWaebHkCRj',
      );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(PlaceReadPage(place: bestMatch)),
      child: Container(
        alignment: Alignment.center,
        width: Get.width * 0.6,
        margin: const EdgeInsets.only(right: DesignSize.mediumSpace),
        child: BlurHash(
          image: hash.image,
          hash: hash.hash,
        ),
        // child: Stack(
        //   children: [
        //     Container(
        //       width: double.infinity,
        //       color: Colors.black.withOpacity(0.35),
        //     ),
        //     Padding(
        //       padding: const EdgeInsets.all(DesignSize.mediumSpace),
        //       child: Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         mainAxisAlignment: MainAxisAlignment.end,
        //         children: [
        //           Text(
        //             bestMatch.name,
        //             style: DesignTextStyle.bodyMedium16Bold
        //                 .apply(color: Colors.white),
        //           ),
        //           // Text(
        //           //   controller.bestMatch[index].keywords.toString(),
        //           // ),
        //           Text(
        //             'Match: ${bestMatch.match}',
        //             style: DesignTextStyle.bodyMedium16Bold
        //                 .apply(color: Colors.white),
        //           ),
        //           Text(
        //             'Distance: ${bestMatch.distance.metricSystem}',
        //             style: DesignTextStyle.bodyMedium16Bold
        //                 .apply(color: Colors.white),
        //           ),
        //           Text(
        //             'Rating: ${bestMatch.rating}',
        //             style: DesignTextStyle.bodyMedium16Bold
        //                 .apply(color: Colors.white),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
