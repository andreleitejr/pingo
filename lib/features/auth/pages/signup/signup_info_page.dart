import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pingo/constants/design_color.dart';
import 'package:pingo/constants/design_size.dart';
import 'package:pingo/core/extensions.dart';
import 'package:pingo/features/auth/pages/signup/signup_info_controller.dart';
import 'package:pingo/features/auth/repositories/auth_repository.dart';
import 'package:pingo/features/profile/edit/profile_keywords_selection.dart';
import 'package:pingo/features/profile/models/gender.dart';
import 'package:pingo/features/profile/models/sexual_orientation.dart';
import 'package:pingo/widgets/design_address_selection.dart';
import 'package:pingo/widgets/design_appbar.dart';
import 'package:pingo/widgets/design_button.dart';
import 'package:pingo/widgets/design_date_input.dart';
import 'package:pingo/widgets/design_text_input.dart';
import 'package:pingo/widgets/design_space.dart';
import 'package:pingo/widgets/dialogs/design_selection_dialog.dart';

class SignUpInfoPage extends StatefulWidget {
  const SignUpInfoPage({Key? key}) : super(key: key);

  @override
  State<SignUpInfoPage> createState() => _SignUpInfoPageState();
}

class _SignUpInfoPageState extends State<SignUpInfoPage>
    implements SignUpInfoNavigator {
  late SignUpInfoController controller;

  @override
  void initState() {
    controller = Get.put(SignUpInfoController(this));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(DesignSize.appBarHeight),
        child: SafeArea(
          child: DesignAppBar(title: 'Personal Info'),
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(DesignSize.mediumSpace),
        child: ListView(
          children: [
            Obx(
              () => DesignTextInput(
                textEditingController: controller.nameController.value,
                hint: 'Name',
                onChanged: controller.setName,
                isValid: controller.nameValid,
              ),
            ),
            const DesignSpace(),
            Obx(
              () => DesignTextInput(
                textEditingController: controller.emailController.value,
                hint: 'E-mail',
              ),
            ),
            const DesignSpace(),
            Obx(
              () => DesignDateInput(
                hint: 'Birthday',
                onPressed: controller.setBirthday,
                value: controller.birthday.value,
                isValid: controller.birthdayValid,
              ),
            ),
            const DesignSpace(),
            Obx(
              () => DesignSelectionInput<Gender>(
                items: genders,
                value: genders.firstWhereOrNull(
                  (gender) => gender.title == controller.gender.value,
                ),
                hint: 'Gender',
                onChanged: controller.setGender,
                isValid: controller.genderValid,
              ),
            ),
            const DesignSpace(),
            Obx(
              () => DesignSelectionInput<SexualOrientation>(
                items: sexualOrientations,
                value: sexualOrientations.firstWhereOrNull(
                  (sexualOrientation) =>
                      sexualOrientation.title ==
                      controller.sexualOrientation.value,
                ),
                hint: 'Sexual Orientation',
                onChanged: controller.setSexualOrientation,
                isValid: controller.sexualOrientationValid,
              ),
            ),
            const DesignSpace(),
            Obx(
              () => DesignTextInput(
                textEditingController: controller.countryController.value,
                hint: 'Country',
                onChanged: controller.setCountry,
                isValid: controller.countryValid,
              ),
            ),
            const DesignSpace(),
            Obx(
              () => DesignTextInput(
                textEditingController: controller.stateController.value,
                hint: 'State',
                onChanged: controller.setProvince,
                isValid: controller.provinceValid,
              ),
            ),
            const DesignSpace(),
            Obx(
              () => DesignTextInput(
                textEditingController: controller.cityController.value,
                hint: 'City',
                onChanged: controller.setCity,
                isValid: controller.cityValid,
              ),
            ),
            const DesignSpace(),
            Obx(
              () => DesignButton(
                onPressed: () async => controller.save(),
                title: 'Sign In',
                isActive: controller.isInfoFormValid,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void success() => Get.to(() => ProfileKeywordsSelection());

  @override
  void error(AuthResult result) => Get.snackbar(
        result.title,
        result.message,
        backgroundColor: DesignColor.primary500,
        colorText: Colors.white,
      );
}

abstract class SignUpInfoNavigator {
  void success();

  void error(AuthResult result);
}
