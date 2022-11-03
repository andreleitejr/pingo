import 'package:flutter/material.dart';
import 'package:pingo/constants/design_color.dart';
import 'package:shimmer/shimmer.dart';

class DesignShimmerWidget extends StatelessWidget {
  const DesignShimmerWidget({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: DesignColor.text200,
      highlightColor: Colors.white,
      child: child,
    );
  }
}
