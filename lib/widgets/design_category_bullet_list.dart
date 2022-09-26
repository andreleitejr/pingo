import 'package:flutter/material.dart';
import 'package:pingo/constants/design_color.dart';
import 'package:pingo/constants/design_size.dart';
import 'package:pingo/features/home/category/category.dart';

class DesignCategoryBulletList extends StatelessWidget {
  const DesignCategoryBulletList({
    Key? key,
    required this.value,
    required this.onItemPressed,
  }) : super(key: key);

  final Category value;
  final Function(Category) onItemPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        padding: const EdgeInsets.only(
          left: DesignSize.mediumSpace,
        ),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {
          final category = categories[index];
          final isSelected = value == category;
          return GestureDetector(
            onTap: () => onItemPressed(category),
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(
                  horizontal: DesignSize.mediumSpace),
              margin: const EdgeInsets.only(right: DesignSize.smallSpace),
              decoration: BoxDecoration(
                color:  isSelected ? DesignColor.primary500 : Colors.transparent,
                  border: Border.all(
                color: DesignColor.primary500,
                width: 2,
              )),
              child: Text(category.title),
            ),
          );
        },
      ),
    );
  }
}
