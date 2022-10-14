import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pingo/constants/design_color.dart';
import 'package:pingo/constants/design_size.dart';
import 'package:pingo/constants/design_text_style.dart';
import 'package:pingo/core/keyword.dart';
import 'package:pingo/features/place/models/place.dart';
import 'package:pingo/features/product/models/product_category.dart';
import 'package:pingo/features/product/pages/edit/product_edit_controller.dart';
import 'package:pingo/widgets/design_appbar.dart';
import 'package:pingo/widgets/design_button.dart';
import 'package:pingo/widgets/design_photo_selection.dart';
import 'package:pingo/widgets/design_text_input.dart';

import '../../../../widgets/design_space.dart';

class ProductEditPage extends StatefulWidget {
  ProductEditPage({Key? key, required this.place}) : super(key: key);

  final Place place;

  @override
  State<ProductEditPage> createState() => _ProductEditPageState();
}

class _ProductEditPageState extends State<ProductEditPage> {
  late ProductEditController controller;

  @override
  void initState() {
    controller = ProductEditController(widget.place);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(DesignSize.appBarHeight),
        child: DesignAppBar(
          title: 'Create Product',
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(DesignSize.mediumSpace),
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
            const DesignSpace(),
            Wrap(
              children: [
                for (final productType in productTypes) ...[
                  GestureDetector(
                    onTap: () => controller.toggleCategory(productType),
                    child: Obx(
                      () {
                        final isSelected =
                            controller.productCategories.contains(productType);
                        return Container(
                          padding: const EdgeInsets.all(8),
                          margin: const EdgeInsets.all(4),
                          color: isSelected
                              ? DesignColor.primary500
                              : DesignColor.text300,
                          child: Text(productType.title),
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
            const DesignSpace(),
            Obx(
              () => DesignPhotoSelection(
                displayImage: controller.displayImage.value,
                onButtonPressed: () async =>
                    await controller.setImage(ImageSource.gallery),
              ),
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
