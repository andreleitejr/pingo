import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pingo/constants/design_color.dart';
import 'package:pingo/constants/design_icons.dart';
import 'package:pingo/constants/design_images.dart';
import 'package:pingo/constants/design_size.dart';
import 'package:pingo/constants/design_text_style.dart';
import 'package:pingo/core/extensions.dart';
import 'package:pingo/features/place/models/place.dart';
import 'package:pingo/features/post/models/post.dart';
import 'package:pingo/widgets/design_appbar.dart';
import 'package:pingo/widgets/design_space.dart';

class DesignPostReader extends StatelessWidget {
  const DesignPostReader({
    Key? key,
    required this.post,
    required this.place,
  }) : super(key: key);

  final Post post;
  final Place place;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(DesignSize.appBarHeight),
        child: DesignAppBar(
          title: place.name,
          actionIcon: DesignIcons.share,
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: DesignSize.mediumSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: Get.width * 0.65,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      post.image?.image ?? DesignImages.fallbackImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const DesignSpace(),
            RichText(
              text: TextSpan(
                text: place.name,
                style: DesignTextStyle.bodySmall14Bold.apply(
                  color: Colors.black,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: post.description,
                    style: DesignTextStyle.bodySmall14,
                  ),
                ],
              ),
            ),
            const DesignSpace(size: DesignSize.smallSpace),
            Text(
              post.createdAt!.yMMMMd,
              style: DesignTextStyle.bodySmall12.apply(
                color: DesignColor.text300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
