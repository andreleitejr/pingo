import 'package:flutter/material.dart';
import 'package:pingo/constants/design_images.dart';

class DesignAvatarImage extends StatelessWidget {
  const DesignAvatarImage({Key? key, required this.image}) : super(key: key);

  final String? image;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(image ?? DesignImages.fallbackImage),
          fit: BoxFit.cover,
          
        ),
        borderRadius: BorderRadius.circular(50)
      ),
    );
  }
}
