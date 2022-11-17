import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pingo/constants/design_color.dart';
import 'package:pingo/constants/design_size.dart';
import 'package:pingo/core/extensions.dart';
import 'package:pingo/features/auth/repositories/auth_repository.dart';
import 'package:pingo/features/auth/signup/signup_controller.dart';
import 'package:pingo/features/profile/edit/profile_keywords_selection.dart';
import 'package:pingo/models/gender.dart';
import 'package:pingo/models/orientation.dart';
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

class _SignUpInfoPageState extends State<SignUpInfoPage> {
  final controller = Get.put(SignUpController());

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
                hint: 'Country',
                onChanged: controller.setCountry,
                isValid: controller.countryValid,
              ),
            ),
            const DesignSpace(),
            Obx(
              () => DesignTextInput(
                hint: 'City',
                onChanged: controller.setCity,
                isValid: controller.cityValid,
              ),
            ),
            const DesignSpace(),
            Obx(
              () => DesignButton(
                onPressed: () async {
                  if (controller.isInfoFormValid) {
                    final result =
                        await controller.signUpWithEmailAndPassword();

                    if (result == AuthResult.success) {
                      Get.to(() => ProfileKeywordsSelection());
                    } else {
                      Get.snackbar(
                        result.title,
                        result.message,
                        backgroundColor: DesignColor.primary500,
                        colorText: Colors.white,
                      );
                    }
                  }
                },
                title: 'Sign In',
                isActive: controller.isInfoFormValid,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
