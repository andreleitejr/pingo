import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pingo/constants/design_size.dart';
import 'package:pingo/features/auth/signup/signup_controller.dart';
import 'package:pingo/features/profile/edit/info/profile_info_controller.dart';
import 'package:pingo/features/profile/edit/profile_keywords_selection.dart';
import 'package:pingo/widgets/design_appbar.dart';
import 'package:pingo/widgets/design_button.dart';
import 'package:pingo/widgets/design_date_input.dart';
import 'package:pingo/widgets/design_photo_selection.dart';
import 'package:pingo/widgets/design_text_input.dart';
import 'package:pingo/widgets/design_space.dart';

class ProfileInfoPage extends StatefulWidget {
  const ProfileInfoPage({Key? key}) : super(key: key);

  @override
  State<ProfileInfoPage> createState() => _ProfileInfoPageState();
}

class _ProfileInfoPageState extends State<ProfileInfoPage> {
  final controller = Get.put(ProfileInfoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(DesignSize.appBarHeight),
        child: DesignAppBar(title: 'Personal Info'),
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(DesignSize.mediumSpace),
        child: ListView(
          children: [
            Obx(
              () => DesignPhotoSelection(
                displayImage: controller.displayImage.value,
                onButtonPressed: () async =>
                    await controller.setImage(ImageSource.camera),
              ),
            ),
            DesignTextInput(
              hint: 'Name',
              onChanged: controller.setName,
            ),
            const DesignSpace(),
            DesignTextInput(
              hint: 'Nickname',
              onChanged: controller.setNickname,
            ),
            const DesignSpace(),
            DesignTextInput(
              hint: 'Description',
              onChanged: controller.setDescription,
            ),
            const DesignSpace(),
            DesignButton(
              onPressed: () async => controller.save(),
              title: 'Save',
              isActive: true,
            ),
          ],
        ),
      ),
    );
  }
}
