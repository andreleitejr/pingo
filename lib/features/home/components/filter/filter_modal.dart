import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pingo/constants/design_color.dart';
import 'package:pingo/constants/design_size.dart';
import 'package:pingo/constants/design_text_style.dart';
import 'package:pingo/features/home/components/filter/filter_controller.dart';
import 'package:pingo/models/matchbase.dart';
import 'package:pingo/widgets/design_bullet_item.dart';
import 'package:pingo/widgets/design_button.dart';
import 'package:pingo/widgets/design_emoji_bullet.dart';
import 'package:pingo/widgets/design_section_title.dart';
import 'package:pingo/widgets/design_slider.dart';

class FilterModal extends StatelessWidget {
  FilterModal({Key? key}) : super(key: key);
  final FilterController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.9,
      padding: const EdgeInsets.all(DesignSize.mediumSpace),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            height: 4,
            width: 42,
            decoration: BoxDecoration(
                color: DesignColor.text200.withOpacity(0.35),
                borderRadius: BorderRadius.circular(42)),
          ),
          DesignSectionTitle(
            title: '',
            actionTitle: 'Clean All',
            onActionPressed: () => controller.cleanAll(),
          ),
          DesignSectionTitle(
            title: 'Match',
            actionTitle: 'Clean',
            onActionPressed: () => controller.cleanDistance(),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            width: double.infinity,
            child: Wrap(
              children: [
                for (var i = 0; i < matchItems.length; i++) ...[
                  Obx(
                    () {
                      final isSelected =
                          matchItems[i].value >= controller.match.value;

                      return GestureDetector(
                        onTap: () => controller.setMatch(matchItems[i]),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              margin:
                                  const EdgeInsets.only(bottom: 12, right: 8),
                              decoration: BoxDecoration(
                                  color: isSelected
                                      ? DesignColor.primary500
                                      : const Color(0xFFECECEC),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(0.25),
                                        spreadRadius: 0,
                                        blurRadius: 1,
                                        offset: const Offset(0, 1.5))
                                  ],
                                  borderRadius: BorderRadius.circular(100)),
                              child: DesignEmojiBullet(
                                title: matchItems[i].message,
                                emoji: matchItems[i].emoji,
                                textStyle:
                                    DesignTextStyle.labelSmall11Bold.apply(
                                  color: DesignColor.text500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ],
            ),
          ),

          DesignSectionTitle(
            title: 'Distance',
            actionTitle: 'Clean',
            onActionPressed: () => controller.cleanDistance(),
          ),
          SizedBox(
            width: double.infinity,
            child: Obx(
              () => DesignSlider(
                maxValue: controller.distance.value,
                min: controller.min.value,
                max: controller.max.value,
                divisions: controller.divisions,
                onChanged: controller.setDistance,
              ),
            ),
          ),
          DesignSectionTitle(
            title: 'Rating',
            actionTitle: 'Clean',
            onActionPressed: () => controller.cleanRating(),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            width: double.infinity,
            child: Wrap(
              children: [
                for (var i = 1; i <= 5; i++) ...[
                  Obx(
                    () {
                      final isSelected = i >= controller.rating.value;
                      final unselectedColor =
                          DesignColor.text300.withOpacity(0.75);
                      return SizedBox(
                        height: 32,
                        width: ((Get.width - 64) * 0.2),
                        child: DesignBulletItem(
                          onPressed: () => controller.setRating(i),
                          title: i.toString(),
                          icon: Icon(
                            Icons.star,
                            size: 16,
                            color: isSelected
                                ? DesignColor.primary700
                                : unselectedColor,
                          ),
                          isSelected: isSelected,
                          padding: EdgeInsets.zero,
                          unselectedColor: unselectedColor,
                        ),
                      );
                    },
                  ),
                  if (i < 5) const SizedBox(width: DesignSize.smallSpace)
                ],
              ],
            ),
          ),
          DesignSectionTitle(
            title: 'Price',
            actionTitle: 'Clean',
            onActionPressed: () => controller.cleanPrice(),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            width: double.infinity,
            child: Obx(
              () => DesignSlider(
                isRange: true,
                minValue: controller.minPrice.value,
                maxValue: controller.maxPrice.value,
                min: controller.min.value,
                max: 20000,
                divisions: controller.divisions,
                onRangeChanged: (RangeValues values) {
                  controller.setMinPrice(values.start);
                  controller.setMaxPrice(values.end);
                },
              ),
            ),
          ),
          // Row(
          //   children: [
          //     Expanded(
          //       child: Obx(() => DesignTextInput(
          //             initialValue: controller.minPrice.toString(),
          //             hint: 'R\$${controller.minPrice.round()}',
          //             onChanged: controller.setMinPrice,
          //           )),
          //     ),
          //     const DesignSpace(orientation: DesignSpaceOrientation.horizontal),
          //     Obx(
          //       () => Expanded(
          //         child: DesignTextInput(
          //           initialValue: controller.maxPrice.toString(),
          //           hint: 'R\$${controller.maxPrice.round()}',
          //           onChanged: controller.setMaxPrice,
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          Expanded(child: Container()),
          DesignButton(
            onPressed: () => Get.back(),
            title: 'Save Filter',
            isActive: true,
          ),
        ],
      ),
    );
  }
}
