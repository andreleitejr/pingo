import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pingo/constants/design_size.dart';
import 'package:pingo/features/auth/signup/signup_controller.dart';
import 'package:pingo/features/profile/edit/info/profile_info_edit_controller.dart';
import 'package:pingo/features/profile/edit/profile_keywords_selection.dart';
import 'package:pingo/widgets/design_appbar.dart';
import 'package:pingo/widgets/design_button.dart';
import 'package:pingo/widgets/design_date_input.dart';
import 'package:pingo/widgets/design_avatar_image_selection.dart';
import 'package:pingo/widgets/design_text_input.dart';
import 'package:pingo/widgets/design_space.dart';

class ProfileInfoEditPage extends StatefulWidget {
  const ProfileInfoEditPage({Key? key}) : super(key: key);

  @override
  State<ProfileInfoEditPage> createState() => _ProfileInfoEditPageState();
}

class _ProfileInfoEditPageState extends State<ProfileInfoEditPage> {
  final controller = Get.put(ProfileInfoEditController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(DesignSize.appBarHeight),
        child: DesignAppBar(
          title: 'Personal Info',
          actionText: 'Concluir',
          onActionPressed: () async =>
              controller.save().then((value) => Get.back()),
          actionValid: true,
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
          ],
        ),
      ),
    );
  }
}
