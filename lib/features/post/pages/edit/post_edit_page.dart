import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pingo/constants/design_size.dart';
import 'package:pingo/features/place/models/place.dart';
import 'package:pingo/features/post/pages/edit/post_edit_controller.dart';
import 'package:pingo/widgets/design_appbar.dart';
import 'package:pingo/widgets/design_button.dart';
import 'package:pingo/widgets/design_image_selection.dart';
import 'package:pingo/widgets/design_space.dart';
import 'package:pingo/widgets/design_text_input.dart';

class PostEditPage extends StatefulWidget {
  const PostEditPage({Key? key, required this.place}) : super(key: key);

  final Place place;

  @override
  State<PostEditPage> createState() => _PostEditPageState();
}

class _PostEditPageState extends State<PostEditPage> {
  late PostEditController controller;

  @override
  void initState() {
    controller = PostEditController(widget.place);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(DesignSize.appBarHeight),
        child: DesignAppBar(
          title: 'Post',
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(DesignSize.mediumSpace),
        child: Column(
          children: [
            Obx(
              () => DesignImageSelection(
                displayImage: controller.displayImage.value,
                onButtonPressed: () async =>
                    await controller.setImage(ImageSource.camera),
              ),
            ),
            const DesignSpace(),
            DesignTextInput(
              hint: 'Description',
              onChanged: controller.setDescription,
            ),
            const DesignSpace(),
            Expanded(child: Container()),
            SizedBox(
              height: DesignSize.buttonHeight,
              child: DesignButton(
                onPressed: () async =>
                    await controller.save().then((_) => Get.back()),
                title: 'Enviar',
                isActive: true,
                // isActive: controller.isAuthFormValid,
              ),
            ),
            const DesignSpace(),
          ],
        ),
      ),
    );
  }
}
