import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pingo/constants/design_size.dart';
import 'package:pingo/features/auth/signup/signup_controller.dart';
import 'package:pingo/features/profile/edit/profile_keywords_selection.dart';
import 'package:pingo/widgets/design_appbar.dart';
import 'package:pingo/widgets/design_button.dart';
import 'package:pingo/widgets/design_date_input.dart';
import 'package:pingo/widgets/design_text_input.dart';
import 'package:pingo/widgets/design_space.dart';

class SignUpInfoPage extends StatefulWidget {
  const SignUpInfoPage({Key? key}) : super(key: key);

  @override
  State<SignUpInfoPage> createState() => _SignUpInfoPageState();
}

class _SignUpInfoPageState extends State<SignUpInfoPage> {
  final controller = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    print('USER Uuid: ${controller.user.uuid}');
    print('USER Name: ${controller.name}');
    print('USER Email: ${controller.email}');
    print('USER Password: ${controller.password}');

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(DesignSize.appBarHeight),
        child: DesignAppBar(title: 'Personal Info'),
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(DesignSize.padding),
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
              () => DesignTextInput(
                hint: 'Gender',
                onChanged: controller.setGender,
                isValid: controller.genderValid,
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
                    await controller.signUpWithEmailAndPassword().then((value) {
                      Get.to(() => const ProfileKeywordsSelection());
                    });
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
