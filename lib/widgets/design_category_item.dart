import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pingo/widgets/design_space.dart';

class DesignCategoryItem extends StatelessWidget {
  const DesignCategoryItem({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 72,
      width: 80,
      child: Column(
        children: [
          Container(
            height: 72,
            color: Colors.grey,
          ),
          const DesignSpace(),
          Text(
            title,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
