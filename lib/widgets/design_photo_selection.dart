import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pingo/services/camera_controller.dart';
import 'package:pingo/widgets/design_button.dart';
import 'package:pingo/widgets/design_space.dart';

class DesignPhotoSelection extends StatelessWidget {
  DesignPhotoSelection({
    Key? key,
    this.displayImage,
    this.displayPhotos,
    this.isMultiImage = false,
    required this.onButtonPressed,
  }) : super(key: key);

  final File? displayImage;
  final List<File>? displayPhotos;
  final bool isMultiImage;
  final CameraController cameraController = Get.find();
  final Function() onButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DesignButton(
          onPressed: onButtonPressed,
          title: 'Profile Photo',
          isActive: true,
        ),
        const DesignSpace(),
        Center(
          child: !kIsWeb && defaultTargetPlatform == TargetPlatform.android
              ? FutureBuilder<void>(
                  future: cameraController.retrieveLostData(),
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
                        return isMultiImage
                            ? _previewPhotos()
                            : _previewImage();
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
              : isMultiImage
                  ? _previewPhotos()
                  : _previewImage(),
        )
      ],
    );
  }

  Widget _previewPhotos() {
    final Text? retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }

    if (displayPhotos != null && displayPhotos!.isNotEmpty) {
      return SizedBox(
        height: 200,
        child: GridView.count(
          key: UniqueKey(),
          padding: EdgeInsets.zero,
          crossAxisCount: 3,
          crossAxisSpacing: 2,
          mainAxisSpacing: 2,
          children: List.generate(displayPhotos!.length, (index) {
            final image = File(displayPhotos![index].path);
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
    } else if (cameraController.pickImageError != null) {
      return Text(
        'Pick image error: ${cameraController.pickImageError}',
        textAlign: TextAlign.center,
      );
    } else {
      return const Text(
        'You have not yet picked an image.',
        textAlign: TextAlign.center,
      );
    }
  }

  Widget _previewImage() {
    final Text? retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }

    if (displayImage != null && displayImage!.path.isNotEmpty) {
      return SizedBox(
        height: 250,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: FileImage(displayImage!),
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    } else if (cameraController.pickImageError != null) {
      return Text(
        'Pick image error: ${cameraController.pickImageError}',
        textAlign: TextAlign.center,
      );
    } else {
      return const Text(
        'You have not yet picked an image.',
        textAlign: TextAlign.center,
      );
    }
  }

  Text? _getRetrieveErrorWidget() {
    if (cameraController.retrieveDataError != null) {
      final Text result = Text(cameraController.retrieveDataError!);
      cameraController.retrieveDataError = null;
      return result;
    }
    return null;
  }
}
