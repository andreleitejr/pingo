import 'package:flutter/material.dart';

class DesignDestionationMarker extends StatelessWidget {
  const DesignDestionationMarker({Key? key, required this.image})
      : super(key: key);

  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 54),
      height: 54,
      width: 54,
      decoration: BoxDecoration(
        image: DecorationImage(image: NetworkImage(image), fit: BoxFit.cover),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(54),
          topRight: Radius.circular(54),
          bottomRight: Radius.circular(54),
        ),
      ),
    );
  }
}
