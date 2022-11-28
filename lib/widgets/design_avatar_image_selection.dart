import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pingo/constants/design_color.dart';
import 'package:pingo/constants/design_text_style.dart';
import 'package:pingo/services/camera_controller.dart';
import 'package:pingo/widgets/design_space.dart';

class DesignAvatarImageSelection extends StatelessWidget {
  DesignAvatarImageSelection({
    Key? key,
    this.displayImage,
    required this.onButtonPressed,
  }) : super(key: key);

  final File? displayImage;
  final Function() onButtonPressed;

  final CameraController cameraController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const DesignSpace(),
        Center(
          child: !kIsWeb && defaultTargetPlatform == TargetPlatform.android
              ? FutureBuilder<void>(
                  future: cameraController.retrieveLostData(),
                  builder:
                      (BuildContext context, AsyncSnapshot<void> snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.done:
                        return _previewImage();
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
              : _previewImage(),
        )
      ],
    );
  }

  Widget _previewImage() {
    final Text? retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }

    final size = Get.width * 0.2;

    if (cameraController.pickImageError != null) {
      return Text(
        'Pick image error: ${cameraController.pickImageError}',
        textAlign: TextAlign.center,
      );
    }

    return Column(
      children: [
        GestureDetector(
          onTap: onButtonPressed,
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(size),
              color: DesignColor.text300,
              image: displayImage != null
                  ? DecorationImage(
                      image: FileImage(displayImage!),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
          ),
        ),
        TextButton(
          onPressed: onButtonPressed,
          child: Text(
            'Alterar foto de perfil',
            style: DesignTextStyle.bodySmall14Bold.apply(
              color: DesignColor.primary500,
            ),
          ),
        ),
      ],
    );
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
