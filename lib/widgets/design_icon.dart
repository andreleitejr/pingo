import 'package:flutter/material.dart';
import 'package:pingo/constants/design_color.dart';
import 'package:pingo/constants/design_size.dart';
import 'package:pingo/widgets/design_shimmer_widget.dart';

class DesignIcon extends StatelessWidget {
  const DesignIcon({
    Key? key,
    required this.icon,
    this.height,
    this.width,
    this.isSelected = false,
    this.isLoading = false,
  }) : super(key: key);

  final String icon;
  final double? height;
  final double? width;
  final bool isSelected;
  final bool isLoading;

  double get _size => isSelected ? DesignSize.selectedIcon : DesignSize.icon;

  Color get _color => isSelected ? DesignColor.primary500 : DesignColor.text300;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return DesignShimmerWidget(
        child: Container(
          height: DesignSize.selectedIcon,
          width: DesignSize.selectedIcon,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(24),
          ),
        ),
      );
    }
    return Opacity(
      opacity: 1,
      child: SizedBox(
        height: height ?? _size,
        width: width ?? _size,
        child: ColorFiltered(
          colorFilter: ColorFilter.mode(_color, BlendMode.srcATop),
          child: Image.asset(icon),
        ),
      ),
    );
  }
}
