import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pingo/services/camera_controller.dart';
import 'package:pingo/widgets/design_button.dart';
import 'package:pingo/widgets/design_space.dart';

class DesignMultiImageSelection extends StatelessWidget {
  DesignMultiImageSelection({
    Key? key,
    this.displayPhotos,
    required this.onButtonPressed,
  }) : super(key: key);

  final List<File>? displayPhotos;
  final Function() onButtonPressed;

  final CameraController cameraController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DesignButton(
          onPressed: onButtonPressed,
          title: 'Select Photos',
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
                      case ConnectionState.done:
                        return _previewPhotos();
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                      default:
                        if (snapshot.hasError) {
                          return Text(
                            'Pick image/video error: ${snapshot.error}}',
                            textAlign: TextAlign.center,
                          );
                        } else {
                          return Container();
                        }
                    }
                  },
                )
              : _previewPhotos(),
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

  Text? _getRetrieveErrorWidget() {
    if (cameraController.retrieveDataError != null) {
      final Text result = Text(cameraController.retrieveDataError!);
      cameraController.retrieveDataError = null;
      return result;
    }
    return null;
  }
}
