import 'package:flutter/material.dart';
import 'package:pingo/constants/design_color.dart';
import 'package:pingo/constants/design_size.dart';
import 'package:pingo/constants/design_text_style.dart';
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
                  borderRadius: BorderRadius.circular(18),
                  color:
                      isSelected ? DesignColor.primary100 : Colors.transparent,
                  border: Border.all(
                    color:  isSelected ? DesignColor.primary100 : DesignColor.primary500,
                    width: 2,
                  )),
              child: Text(
                category.title,
                style: DesignTextStyle.bodyMedium16Bold.apply(
                  color: isSelected
                      ? DesignColor.primary700
                      : DesignColor.primary500,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
