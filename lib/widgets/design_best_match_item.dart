import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:get/get.dart';
import 'package:pingo/constants/design_color.dart';
import 'package:pingo/constants/design_size.dart';
import 'package:pingo/features/place/models/place.dart';
import 'package:pingo/features/place/pages/read/place_read_page.dart';

class DesignBestMatchItem extends StatelessWidget {
  const DesignBestMatchItem({
    Key? key,
    required this.bestMatch,
  }) : super(key: key);

  final Place? bestMatch;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => PlaceReadPage(place: bestMatch!)),
      child: Container(
        width: Get.width * 0.6,
        margin: const EdgeInsets.only(right: DesignSize.mediumSpace),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: bestMatch != null
              ? BlurHash(
                  imageFit: BoxFit.cover,
                  image: bestMatch!.image!.image,
                  hash: bestMatch!.image!.blurHash,
                )
              : Container(
                  color: DesignColor.text200,
                ),
        ),
      ),
    );
  }
}
