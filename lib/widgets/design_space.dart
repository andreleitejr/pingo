import 'package:flutter/material.dart';
import 'package:pingo/constants/design_size.dart';

enum DesignSpaceOrientation { horizontal, vertical }

class DesignSpace extends StatelessWidget {
  const DesignSpace({
    Key? key,
    this.orientation = DesignSpaceOrientation.vertical,
    this.size,
  }) : super(key: key);

  final DesignSpaceOrientation? orientation;
  final double? size;

  double get height => orientation == DesignSpaceOrientation.vertical
      ? size ?? DesignSize.mediumSpace
      : 0;

  double get width => orientation == DesignSpaceOrientation.horizontal
      ? size ?? DesignSize.mediumSpace
      : 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
    );
  }
}
