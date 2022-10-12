import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pingo/constants/design_color.dart';
import 'package:pingo/constants/design_size.dart';
import 'package:pingo/constants/design_text_style.dart';
import 'package:pingo/core/keyword.dart';
import 'package:pingo/features/place/pages/edit/place_edit_controller.dart';
import 'package:pingo/widgets/design_appbar.dart';
import 'package:pingo/widgets/design_button.dart';
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
            Obx(
              () => DesignTextInput(
                textInputType: TextInputType.emailAddress,
                hint: 'E-mail',
                onChanged: controller.setEmail,
                isValid: controller.emailValid,
              ),
            ),
            const DesignSpace(),
            // const DesignSpace(),
            // SizedBox(
            //   height: 54,
            //   child: Row(
            //     children: [
            //       Expanded(
            //         child: DesignTextInput(
            //           textInputType: TextInputType.number,
            //           hint: 'Open Hour',
            //           onChanged: controller.setOpenHour,
            //         ),
            //       ),
            //       const DesignSpace(
            //         orientation: DesignSpaceOrientation.horizontal,
            //       ),
            //       Expanded(
            //         child: DesignTextInput(
            //           textInputType: TextInputType.number,
            //           hint: 'Open Minute',
            //           onChanged: controller.setOpenHour,
            //         ),
            //       )
            //     ],
            //   ),
            // ),
            // const DesignSpace(),
            // SizedBox(
            //   height: 54,
            //   child: Row(
            //     children: [
            //       Expanded(
            //         child: DesignTextInput(
            //           textInputType: TextInputType.number,
            //           hint: 'Close Hour',
            //           onChanged: controller.setCloseHour,
            //         ),
            //       ),
            //       const DesignSpace(
            //         orientation: DesignSpaceOrientation.horizontal,
            //       ),
            //       Expanded(
            //         child: DesignTextInput(
            //           textInputType: TextInputType.number,
            //           hint: 'Close Minute',
            //           onChanged: controller.setCloseMinute,
            //         ),
            //       )
            //     ],
            //   ),
            // ),
            const DesignSpace(),
            const Text(
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
            const DesignSpace(),
            Obx(() {
              if (controller.keywords.contains(Keyword.restaurant)) {
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
            const Text(
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
            Obx(
              () => DesignButton(
                onPressed: () async =>
                    await controller.setImage(ImageSource.gallery),
                title: 'Profile Photo',
                isActive: controller.isValid,
              ),
            ),
            const DesignSpace(),
            Center(
              child: !kIsWeb && defaultTargetPlatform == TargetPlatform.android
                  ? FutureBuilder<void>(
                      future: controller.cameraController.retrieveLostData(),
                      builder:
                          (BuildContext context, AsyncSnapshot<void> snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                          case ConnectionState.waiting:
                            return const Text(
                              'You have not yet picked an image.',
                              textAlign: TextAlign.center,
                            );
                          case ConnectionState.done:
                            return _previewImage();
                          default:
                            if (snapshot.hasError) {
                              return Text(
                                'Pick image/video error: ${snapshot.error}}',
                                textAlign: TextAlign.center,
                              );
                            } else {
                              return const Text(
                                'You have not yet picked an image.',
                                textAlign: TextAlign.center,
                              );
                            }
                        }
                      },
                    )
                  : _previewPhotos(),
            ),
            const DesignSpace(),
            Obx(
              () => DesignButton(
                onPressed: () async =>
                    await controller.selectPhotos(ImageSource.gallery),
                title: 'Other Photos',
                isActive: controller.isValid,
              ),
            ),
            const DesignSpace(),
            Center(
              child: !kIsWeb && defaultTargetPlatform == TargetPlatform.android
                  ? FutureBuilder<void>(
                      future: controller.cameraController.retrieveLostData(),
                      builder:
                          (BuildContext context, AsyncSnapshot<void> snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                          case ConnectionState.waiting:
                            return const Text(
                              'You have not yet picked an image.',
                              textAlign: TextAlign.center,
                            );
                          case ConnectionState.done:
                            return _previewPhotos();
                          default:
                            if (snapshot.hasError) {
                              return Text(
                                'Pick image/video error: ${snapshot.error}}',
                                textAlign: TextAlign.center,
                              );
                            } else {
                              return const Text(
                                'You have not yet picked an image.',
                                textAlign: TextAlign.center,
                              );
                            }
                        }
                      },
                    )
                  : _previewPhotos(),
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

  Widget _previewPhotos() {
    final Text? retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    return Obx(() {
      if (controller.photos.isNotEmpty) {
        return SizedBox(
          height: 200,
          child: GridView.count(
            key: UniqueKey(),
            padding: EdgeInsets.zero,
            crossAxisCount: 3,
            crossAxisSpacing: 2,
            mainAxisSpacing: 2,
            children: List.generate(controller.photos.length, (index) {
              final image = File(controller.photos[index].path);
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: FileImage(image),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            }),
          ),
        );
      } else if (controller.cameraController.pickImageError != null) {
        return Text(
          'Pick image error: ${controller.cameraController.pickImageError}',
          textAlign: TextAlign.center,
        );
      } else {
        return const Text(
          'You have not yet picked an image.',
          textAlign: TextAlign.center,
        );
      }
    });
  }

  Widget _previewImage() {
    final Text? retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    return Obx(() {
      if (controller.image.value.path.isNotEmpty) {
        return SizedBox(
          height: 250,
          child: BlurHash(
            image: controller.image.value.path,
            hash: controller.imageBlurHash.value,
          ),
        );
      } else if (controller.cameraController.pickImageError != null) {
        return Text(
          'Pick image error: ${controller.cameraController.pickImageError}',
          textAlign: TextAlign.center,
        );
      } else {
        return const Text(
          'You have not yet picked an image.',
          textAlign: TextAlign.center,
        );
      }
    });
  }

  Text? _getRetrieveErrorWidget() {
    if (controller.cameraController.retrieveDataError != null) {
      final Text result = Text(controller.cameraController.retrieveDataError!);
      controller.cameraController.retrieveDataError = null;
      return result;
    }
    return null;
  }
}
