import 'package:flutter/material.dart';

class DesignDestinationMarker extends StatelessWidget {
  const DesignDestinationMarker({Key? key, required this.image})
      : super(key: key);

  final String image;
  final double _size = 36;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: _size),
      height: _size,
      width: _size,
      decoration: BoxDecoration(
        image: DecorationImage(image: NetworkImage(image), fit: BoxFit.cover),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(_size),
          topRight: Radius.circular(_size),
          bottomRight: Radius.circular(_size),
        ),
      ),
    );
  }
}
