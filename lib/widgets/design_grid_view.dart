import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:pingo/constants/design_color.dart';
import 'package:pingo/constants/design_icons.dart';
import 'package:pingo/constants/design_size.dart';
import 'package:pingo/features/post/models/post.dart';
import 'package:pingo/services/blurhash_controller.dart';
import 'package:pingo/widgets/design_icon.dart';

class DesignImageGridView extends StatelessWidget {
  const DesignImageGridView({
    Key? key,
    required this.isMasonry,
    this.onButtonPressed,
    required this.posts,
  }) : super(key: key);

  final bool isMasonry;
  final Function()? onButtonPressed;

  final List<Post> posts;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (isMasonry) ...[
          MasonryGridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 2,
            crossAxisSpacing: 2,
            itemCount: posts.length,
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              final mediumCardWidth = Get.width * 0.75;
              final smallCardWidth = Get.width * 0.5;
              final cardHeight =
                  index % 2 == 0 ? mediumCardWidth : smallCardWidth;

              final image = posts[index].image!;

              return SizedBox(
                height: cardHeight,
                child: BlurHash(
                  hash: image.blurHash,
                  image: image.image,
                  imageFit: BoxFit.cover,
                ),
              );
            },
          )
        ] else ...[
          GridView.count(
            padding: EdgeInsets.zero,
            crossAxisCount: 3,
            crossAxisSpacing: 2,
            mainAxisSpacing: 2,
            children: List.generate(posts.length, (index) {
              final image = posts[index].image!;
              return BlurHash(
                hash: image.blurHash,
                image: image.image,
                imageFit: BoxFit.cover,
              );
            }),
          ),
        ],
        Positioned(
          bottom: DesignSize.mediumSpace,
          right: DesignSize.mediumSpace,
          child: SizedBox(
            height: 54,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                textStyle: const TextStyle(fontSize: 20),
                shape: const CircleBorder(),
              ),
              onPressed: onButtonPressed,
              child: DesignIcon(
                icon: isMasonry ? DesignIcons.grid : DesignIcons.masonry,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
