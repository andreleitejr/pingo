import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pingo/constants/design_color.dart';
import 'package:pingo/constants/design_size.dart';
import 'package:pingo/constants/design_text_style.dart';
import 'package:pingo/core/keyword.dart';
import 'package:pingo/features/place/pages/edit/place_edit_controller.dart';
import 'package:pingo/widgets/design_appbar.dart';
import 'package:pingo/widgets/design_button.dart';
import 'package:pingo/widgets/design_avatar_image_selection.dart';
import 'package:pingo/widgets/design_multi_image_selection.dart';
import 'package:pingo/widgets/design_text_input.dart';

import '../../../../widgets/design_space.dart';

class PlaceEditPage extends StatelessWidget {
  PlaceEditPage({Key? key}) : super(key: key);

  final controller = PlaceEditController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(DesignSize.appBarHeight),
        child: DesignAppBar(
          title: 'Create Place',
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(DesignSize.mediumSpace),
        child: ListView(
          children: [
            Obx(
              () => DesignAvatarImageSelection(
                displayImage: controller.displayImage.value,
                onButtonPressed: () async =>
                    await controller.setImage(ImageSource.gallery),
              ),
            ),
            const DesignSpace(),
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
            Obx(
              () => DesignTextInput(
                textInputType: TextInputType.emailAddress,
                hint: 'E-mail',
                onChanged: controller.setEmail,
                isValid: controller.emailValid,
              ),
            ),
            const DesignSpace(),
            const DesignSpace(),
            Text(
              'Address',
              style: DesignTextStyle.bodyMedium16Bold,
            ),
            const DesignSpace(),
            SizedBox(
              height: 54,
              child: Row(
                children: [
                  Expanded(
                    child: Obx(
                      () => DesignTextInput(
                        textInputType: TextInputType.text,
                        hint: 'Line',
                        onChanged: controller.setLine,
                        isValid: controller.lineValid,
                      ),
                    ),
                  ),
                  const DesignSpace(
                    orientation: DesignSpaceOrientation.horizontal,
                  ),
                  SizedBox(
                    width: 100,
                    child: Obx(
                      () => DesignTextInput(
                        textInputType: TextInputType.number,
                        hint: 'Num',
                        onChanged: controller.setNumber,
                        isValid: controller.numberValid,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const DesignSpace(),
            Obx(
              () => DesignTextInput(
                textEditingController: controller.subLocalityController,
                textInputType: TextInputType.text,
                hint: 'Neighborhood',
                onChanged: controller.setSubLocality,
                isValid: controller.subLocalityValid,
              ),
            ),
            const DesignSpace(),
            Obx(
              () => DesignTextInput(
                textEditingController: controller.zipController,
                textInputType: TextInputType.text,
                hint: 'ZIP Code',
                onChanged: controller.setZip,
                isValid: controller.zipValid,
              ),
            ),
            const DesignSpace(),
            DesignTextInput(
              textInputType: TextInputType.text,
              hint: 'Complement (Optional)',
              onChanged: controller.setComplement,
              // isValid: controller.emailValid,
            ),
            const DesignSpace(),
            SizedBox(
              height: 54,
              child: Row(
                children: [
                  Expanded(
                    child: DesignTextInput(
                      textEditingController: controller.latitudeController,
                      textInputType: TextInputType.number,
                      hint: 'Latitude',
                      onChanged: controller.setLatitude,
                    ),
                  ),
                  const DesignSpace(
                    orientation: DesignSpaceOrientation.horizontal,
                  ),
                  Expanded(
                    child: DesignTextInput(
                      textEditingController: controller.longitudeController,
                      textInputType: TextInputType.number,
                      hint: 'Longitude',
                      onChanged: controller.setLongitude,
                    ),
                  )
                ],
              ),
            ),
            const DesignSpace(),
            Text(
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
            const DesignSpace(),
            Obx(() {
              if (controller.keywords.contains(Keyword.restaurant)) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
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
            Text(
              'Musics',
              style: DesignTextStyle.bodyMedium16Bold,
            ),
            const DesignSpace(),
            Wrap(
              children: [
                for (final music in musics) ...[
                  GestureDetector(
                    onTap: () => controller.toggleKeyword(music.id),
                    child: Obx(
                      () {
                        final isSelected =
                            controller.keywords.contains(music.id);
                        return Container(
                          padding: const EdgeInsets.all(8),
                          margin: const EdgeInsets.all(4),
                          color: isSelected
                              ? DesignColor.primary500
                              : DesignColor.text300,
                          child: Text(music.title),
                        );
                      },
                    ),
                  ),
                ]
              ],
            ),
            const DesignSpace(),
            Text(
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
            DesignMultiImageSelection(
              displayPhotos: controller.displayPhotos,
              onButtonPressed: () async =>
                  await controller.selectPhotos(ImageSource.gallery),
            ),
            const DesignSpace(),
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
