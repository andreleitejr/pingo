import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CameraController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  final double maxWidth = 250;
  final double maxHeight = 250;
  final int quality = 20;

  // var maxWidth = 250.0.obs;
  // var maxHeight = 250.0.obs;
  // var quality = 10.obs;
  //
  // void setMaxWidth(String v) => maxWidth(double.parse(v));
  //
  // void setMaxHeight(String v) => maxHeight(double.parse(v));
  //
  // void setQuality(String v) => quality(int.parse(v));
  //
  // final TextEditingController maxWidthController = TextEditingController();
  // final TextEditingController maxHeightController = TextEditingController();
  // final TextEditingController qualityController = TextEditingController();

  var imageFileList = <XFile>[].obs;

  void _setImageFileListFromFile(XFile? value) {
    if (value != null) imageFileList.add(value);
  }

  dynamic pickImageError;

  String? retrieveDataError;

  Future<void> getImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
  }

  Future<void> takePhoto() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await _picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      if (response.files == null) {
        _setImageFileListFromFile(response.file);
      } else {
        imageFileList.value = response.files ?? [];
      }
    } else {
      retrieveDataError = response.exception!.code;
    }
  }

  Future<void> onImageButtonPressed(ImageSource source,
      {bool isMultiImage = false}) async {
    if (isMultiImage) {
      try {
        final List<XFile> pickedFileList = await _picker.pickMultiImage(
          maxWidth: maxWidth,
          maxHeight: maxHeight,
          imageQuality: quality,
        );

        imageFileList.value = pickedFileList;
      } catch (e) {
        pickImageError = e;
      }
    } else {
      try {
        final XFile? pickedFile = await _picker.pickImage(
          source: source,
          maxWidth: maxWidth,
          maxHeight: maxHeight,
          imageQuality: quality,
        );

        _setImageFileListFromFile(pickedFile);
      } catch (e) {
        pickImageError = e;
      }
    }
  }
}
//
// class CameraPage extends StatefulWidget {
//   const CameraPage({Key? key, this.title}) : super(key: key);
//
//   final String? title;
//
//   @override
//   State<CameraPage> createState() => _CameraPageState();
// }
//
// class _CameraPageState extends State<CameraPage> {
//   final CameraController controller = CameraController();
//
//   @override
//   void deactivate() {
//     super.deactivate();
//   }
//
//   @override
//   void dispose() {
//     maxWidthController.dispose();
//     maxHeightController.dispose();
//     qualityController.dispose();
//     super.dispose();
//   }
//
//   Widget _previewImages() {
//     final Text? retrieveError = _getRetrieveErrorWidget();
//     if (retrieveError != null) {
//       return retrieveError;
//     }
//     if (controller.imageFileList != null) {
//       return Semantics(
//         label: 'image_picker_example_picked_images',
//         child: GridView.count(
//           key: UniqueKey(),
//           padding: EdgeInsets.zero,
//           crossAxisCount: 3,
//           crossAxisSpacing: 2,
//           mainAxisSpacing: 2,
//           children: List.generate(controller.imageFileList!.length, (index) {
//             final image = controller.imageFileList![index];
//             return Container(
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   image: NetworkImage(image.path),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             );
//           }),
//         ),
//       );
//     } else if (controller.pickImageError != null) {
//       return Text(
//         'Pick image error: ${controller.pickImageError}',
//         textAlign: TextAlign.center,
//       );
//     } else {
//       return const Text(
//         'You have not yet picked an image.',
//         textAlign: TextAlign.center,
//       );
//     }
//   }
//
//   Widget _handlePreview() {
//     return _previewImages();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title!),
//       ),
//       body: Center(
//         child: !kIsWeb && defaultTargetPlatform == TargetPlatform.android
//             ? FutureBuilder<void>(
//                 future: controller.retrieveLostData(),
//                 builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
//                   switch (snapshot.connectionState) {
//                     case ConnectionState.none:
//                     case ConnectionState.waiting:
//                       return const Text(
//                         'You have not yet picked an image.',
//                         textAlign: TextAlign.center,
//                       );
//                     case ConnectionState.done:
//                       return _handlePreview();
//                     default:
//                       if (snapshot.hasError) {
//                         return Text(
//                           'Pick image/video error: ${snapshot.error}}',
//                           textAlign: TextAlign.center,
//                         );
//                       } else {
//                         return const Text(
//                           'You have not yet picked an image.',
//                           textAlign: TextAlign.center,
//                         );
//                       }
//                   }
//                 },
//               )
//             : _handlePreview(),
//       ),
//       floatingActionButton: Column(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: <Widget>[
//           Semantics(
//             label: 'image_picker_example_from_gallery',
//             child: FloatingActionButton(
//               onPressed: () {
//                 _displayPickImageDialog(context, source: ImageSource.gallery);
//               },
//               heroTag: 'image0',
//               tooltip: 'Pick Image from gallery',
//               child: const Icon(Icons.photo),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 16.0),
//             child: FloatingActionButton(
//               onPressed: () {
//                 _displayPickImageDialog(
//                   context,
//                   source: ImageSource.gallery,
//                   isMultiImage: true,
//                 );
//               },
//               heroTag: 'image1',
//               tooltip: 'Pick Multiple Image from gallery',
//               child: const Icon(Icons.photo_library),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 16.0),
//             child: FloatingActionButton(
//               onPressed: () {
//                 _displayPickImageDialog(
//                   context,
//                   source: ImageSource.camera,
//                   isMultiImage: false,
//                 );
//               },
//               heroTag: 'image2',
//               tooltip: 'Take a Photo',
//               child: const Icon(Icons.camera_alt),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Text? _getRetrieveErrorWidget() {
//     if (controller.retrieveDataError != null) {
//       final Text result = Text(controller.retrieveDataError!);
//       controller.retrieveDataError = null;
//       return result;
//     }
//     return null;
//   }
//
//   Future<void> _displayPickImageDialog(BuildContext context,
//       {required ImageSource source, bool isMultiImage = false}) async {
//     return showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: const Text('Add optional parameters'),
//             content: Column(
//               children: <Widget>[
//                 TextField(
//                   controller: maxWidthController,
//                   keyboardType:
//                       const TextInputType.numberWithOptions(decimal: true),
//                   decoration: const InputDecoration(
//                       hintText: 'Enter maxWidth if desired'),
//                 ),
//                 TextField(
//                   controller: maxHeightController,
//                   keyboardType:
//                       const TextInputType.numberWithOptions(decimal: true),
//                   decoration: const InputDecoration(
//                       hintText: 'Enter maxHeight if desired'),
//                 ),
//                 TextField(
//                   controller: qualityController,
//                   keyboardType: TextInputType.number,
//                   decoration: const InputDecoration(
//                       hintText: 'Enter quality if desired'),
//                 ),
//               ],
//             ),
//             actions: <Widget>[
//               TextButton(
//                 child: const Text('CANCEL'),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//               ),
//               TextButton(
//                   child: const Text('PICK'),
//                   onPressed: () async {
//                     controller.onImageButtonPressed(source);
//                     Navigator.of(context).pop();
//                   }),
//             ],
//           );
//         });
//   }
// }
