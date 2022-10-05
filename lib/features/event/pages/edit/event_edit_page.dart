import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pingo/constants/design_color.dart';
import 'package:pingo/constants/design_size.dart';
import 'package:pingo/constants/design_text_style.dart';
import 'package:pingo/core/keyword.dart';
import 'package:pingo/features/event/pages/edit/event_edit_controller.dart';
import 'package:pingo/features/place/models/place.dart';
import 'package:pingo/features/product/models/product_category.dart';
import 'package:pingo/features/product/pages/edit/product_edit_controller.dart';
import 'package:pingo/widgets/design_appbar.dart';
import 'package:pingo/widgets/design_button.dart';
import 'package:pingo/widgets/design_text_input.dart';

import '../../../../widgets/design_space.dart';

class EventEditPage extends StatefulWidget {
  const EventEditPage({Key? key, required this.place}) : super(key: key);

  final Place place;

  @override
  State<EventEditPage> createState() => _EventEditPageState();
}

class _EventEditPageState extends State<EventEditPage> {
  late EventEditController controller;

  @override
  void initState() {
    controller = EventEditController(widget.place);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(DesignSize.appBarHeight),
        child: DesignAppBar(
          title: 'Create Event',
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(DesignSize.padding),
        child: ListView(
          children: [
            Obx(
              () => DesignTextInput(
                hint: 'Name',
                onChanged: controller.setName,
                isValid: controller.nameValid,
              ),
            ),
            const DesignSpace(),
            Obx(
              () => DesignTextInput(
                hint: 'Description',
                onChanged: controller.setDescription,
                isValid: controller.descriptionValid,
              ),
            ),
            const DesignSpace(),
            DesignTextInput(
              hint: 'Image',
              onChanged: controller.setImage,
            ),
            const DesignSpace(),
            DesignTextInput(
              textInputType: TextInputType.number,
              hint: 'Price',
              onChanged: controller.setPrice,
            ),
            const DesignSpace(),
            DesignTextInput(
              textInputType: TextInputType.number,
              hint: 'Promotional Price',
              onChanged: controller.setPromotionalPrice,
            ),
            const Text(
              'Category',
              style: DesignTextStyle.bodyMedium16Bold,
            ),
            const DesignSpace(),
            Wrap(
              children: [
                for (final place in places) ...[
                  GestureDetector(
                    onTap: () => controller.toggleKeyword(place.id),
                    child: Obx(
                      () {
                        final isSelected =
                            controller.keywords.contains(place.id);
                        return Container(
                          padding: const EdgeInsets.all(8),
                          margin: const EdgeInsets.all(4),
                          color: isSelected
                              ? DesignColor.primary500
                              : DesignColor.text300,
                          child: Text(place.title),
                        );
                      },
                    ),
                  ),
                ]
              ],
            ),
            Obx(() {
              if (controller.productCategories
                  .any((c) => c.id == ProductCategory.food)) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Foods',
                      style: DesignTextStyle.bodyMedium16Bold,
                    ),
                    const DesignSpace(),
                    Wrap(
                      children: [
                        for (final other in foods) ...[
                          GestureDetector(
                            onTap: () => controller.toggleKeyword(other.id),
                            child: Obx(
                              () {
                                final isSelected =
                                    controller.keywords.contains(other.id);
                                return Container(
                                  padding: const EdgeInsets.all(8),
                                  margin: const EdgeInsets.all(4),
                                  color: isSelected
                                      ? DesignColor.primary500
                                      : DesignColor.text300,
                                  child: Text(other.title),
                                );
                              },
                            ),
                          ),
                        ]
                      ],
                    ),
                    const DesignSpace(),
                  ],
                );
              }
              return Container();
            }),
            const DesignSpace(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Type of Music',
                  style: DesignTextStyle.bodyMedium16Bold,
                ),
                const DesignSpace(),
                Wrap(
                  children: [
                    for (final other in musics) ...[
                      GestureDetector(
                        onTap: () => controller.toggleKeyword(other.id),
                        child: Obx(
                          () {
                            final isSelected =
                                controller.keywords.contains(other.id);
                            return Container(
                              padding: const EdgeInsets.all(8),
                              margin: const EdgeInsets.all(4),
                              color: isSelected
                                  ? DesignColor.primary500
                                  : DesignColor.text300,
                              child: Text(other.title),
                            );
                          },
                        ),
                      ),
                    ]
                  ],
                ),
                const DesignSpace(),
              ],
            ),
            const DesignSpace(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Miscellaneous',
                  style: DesignTextStyle.bodyMedium16Bold,
                ),
                const DesignSpace(),
                Wrap(
                  children: [
                    for (final other in miscellaneous) ...[
                      GestureDetector(
                        onTap: () => controller.toggleKeyword(other.id),
                        child: Obx(
                          () {
                            final isSelected =
                                controller.keywords.contains(other.id);
                            return Container(
                              padding: const EdgeInsets.all(8),
                              margin: const EdgeInsets.all(4),
                              color: isSelected
                                  ? DesignColor.primary500
                                  : DesignColor.text300,
                              child: Text(other.title),
                            );
                          },
                        ),
                      ),
                    ]
                  ],
                ),
                const DesignSpace(),
              ],
            ),
            Obx(
              () => DesignButton(
                onPressed: () async {
                  if (controller.isValid) {
                    await controller.save().then(
                          (value) => Get.back(),
                        );
                  }
                },
                title: 'Save',
                isActive: controller.isValid,
              ),
            ),
            const DesignSpace(),
          ],
        ),
      ),
    );
  }
}
