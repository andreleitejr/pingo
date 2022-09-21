import 'package:flutter/material.dart';
import 'package:pingo/constants/design_size.dart';

enum DesignSpaceOrientation { horizontal, vertical }

class DesignSpace extends StatelessWidget {
  const DesignSpace({
    Key? key,
    this.orientation = DesignSpaceOrientation.vertical,
  }) : super(key: key);

  final DesignSpaceOrientation? orientation;

  double get height => orientation == DesignSpaceOrientation.vertical
      ? DesignSize.mediumSpace
      : 0;

  double get width => orientation == DesignSpaceOrientation.horizontal
      ? DesignSize.mediumSpace
      : 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
    );
  }
}
