import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pingo/constants/design_color.dart';
import 'package:pingo/constants/design_size.dart';
import 'package:pingo/features/home/filter/filter_controller.dart';
import 'package:pingo/widgets/design_button.dart';
import 'package:pingo/widgets/design_section_title.dart';
import 'package:pingo/widgets/design_slider.dart';
import 'package:pingo/widgets/design_space.dart';
import 'package:pingo/widgets/design_text_input.dart';

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
          DesignSectionTitle(
            title: 'Filter',
            actionTitle: 'Clean All',
            onActionPressed: () {},
          ),
          DesignSectionTitle(
            title: 'Distance',
            actionTitle: 'Clean',
            onActionPressed: () {},
          ),
          SizedBox(
            width: double.infinity,
            child: Obx(
              () => DesignSlider(
                value: controller.distance.value,
                minValue: controller.minValue.value,
                maxValue: controller.maxValue.value,
                divisions: controller.divisions,
                onChanged: controller.setDistance,
              ),
            ),
          ),
          DesignSectionTitle(
            title: 'Rating',
            actionTitle: 'Clean',
            onActionPressed: () {},
          ),
          SizedBox(
            width: double.infinity,
            child: Wrap(
              children: [
                for (var i = 1; i <= 5; i++) ...[
                  Obx(
                    () {
                      final isSelected = i >= controller.rating.value;
                      return GestureDetector(
                        onTap: () => controller.setRating(i),
                        child: Container(
                          height: 40,
                          width: ((Get.width - 64) * 0.2),
                          color:
                              isSelected ? DesignColor.primary500 : Colors.grey,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(i.toString()),
                              const Icon(Icons.star),
                            ],
                          ),
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
            onActionPressed: () {},
          ),
          Row(
            children: [
              Obx(
                () => Expanded(
                  child: DesignTextInput(
                    hint: 'R\$${controller.minPrice.round()}',
                    onChanged: controller.setMinPrice,
                  ),
                ),
              ),
              const DesignSpace(orientation: DesignSpaceOrientation.horizontal),
              Obx(
                () => Expanded(
                  child: DesignTextInput(
                    hint: 'R\$${controller.maxPrice.round()}',
                    onChanged: controller.setMaxPrice,
                  ),
                ),
              ),
            ],
          ),
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
