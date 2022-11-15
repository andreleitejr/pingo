import 'package:flutter/material.dart';
import 'package:pingo/constants/design_color.dart';
import 'package:pingo/constants/design_size.dart';
import 'package:pingo/constants/design_text_style.dart';
import 'package:pingo/models/category.dart';
import 'package:pingo/widgets/design_bullet_item.dart';

class DesignCategoryBulletList extends StatelessWidget {
  const DesignCategoryBulletList({
    Key? key,
    required this.value,
    required this.onItemPressed,
    this.isLoading = false,
    required this.categories,
  }) : super(key: key);

  final Category value;
  final Function(Category) onItemPressed;
  final bool isLoading;
  final List<Category> categories;

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
            onTap: () {
              print(
                  'CATEGORY SDHUSADHSUDHSDAUUSAHDUSH ${value.title} $isSelected}');
              onItemPressed(category);
            },
            child: DesignBulletItem(
              title: category.title,
              isSelected: isSelected,
              isLoading: isLoading,
            ),
          );
        },
      ),
    );
  }
}
