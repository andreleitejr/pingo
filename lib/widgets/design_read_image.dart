import 'package:flutter/material.dart';
import 'package:pingo/constants/design_images.dart';

class DesignReadImage extends StatelessWidget {
  const DesignReadImage({Key? key, required this.image}) : super(key: key);

  final String? image;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(image ?? DesignImages.fallbackImage),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
