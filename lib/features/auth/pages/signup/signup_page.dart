import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pingo/constants/design_color.dart';
import 'package:pingo/constants/design_images.dart';
import 'package:pingo/constants/design_size.dart';
import 'package:pingo/constants/design_text_style.dart';
import 'package:pingo/core/extensions.dart';
import 'package:pingo/features/auth/pages/signin/signin_page.dart';
import 'package:pingo/features/auth/pages/signup/signup_controller.dart';
import 'package:pingo/features/auth/pages/info/info_page.dart';
import 'package:pingo/features/auth/pages/signup/signup_navigator.dart';
import 'package:pingo/features/auth/repositories/auth_repository.dart';
import 'package:pingo/models/language.dart';
import 'package:pingo/widgets/design_button.dart';
import 'package:pingo/widgets/design_check_box.dart';
import 'package:pingo/widgets/design_text_input.dart';
import 'package:pingo/widgets/design_space.dart';
import 'package:pingo/widgets/dialogs/design_selection_dialog.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> implements SignUpNavigator {
  late SignUpController controller;

  @override
  void initState() {
    controller = Get.put(SignUpController(this));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(DesignSize.mediumSpace),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const DesignSpace(size: 24),
            Expanded(
              child: Image.asset(
                DesignImages.logo,
                width: 48,
              ),
            ),
            const DesignSpace(size: DesignSize.largeSpace),
            Obx(
              () => DesignTextInput(
                autofocus: true,
                hint: 'Name',
                onChanged: controller.setName,
                isValid: controller.nameValid,
                textInputAction: TextInputAction.next,
                textInputType: TextInputType.name,
              ),
            ),
            const DesignSpace(),
            Obx(
              () => DesignTextInput(
                hint: 'E-mail',
                onChanged: controller.setEmail,
                isValid: controller.emailValid,
                textInputAction: TextInputAction.next,
                textInputType: TextInputType.emailAddress,
              ),
            ),
            const DesignSpace(),
            Obx(
              () => DesignTextInput(
                hint: 'Password',
                obscureText: true,
                onChanged: controller.setPassword,
                isValid: controller.passwordValid,
                textInputAction: TextInputAction.next,
              ),
            ),
            const DesignSpace(),
            Obx(
              () => DesignTextInput(
                hint: 'Confirm Password',
                obscureText: true,
                onChanged: controller.setConfirmPassword,
                isValid: controller.confirmPasswordValid,
                textInputAction: TextInputAction.done,
              ),
            ),
            const DesignSpace(),
            Obx(
              () => DesignSelectionDialog<Language>(
                items: languages,
                value: languages.firstWhereOrNull(
                  (language) => language == controller.language.value,
                ),
                hint: 'Language',
                onChanged: controller.setLanguage,
                isValid: true,
              ),
            ),
            const DesignSpace(),
            const DesignSpace(size: DesignSize.smallSpace),
            termsAndConditions(),
            const DesignSpace(size: DesignSize.smallSpace),
            Obx(
              () => DesignButton(
                onPressed: () => controller.signUpWithEmailAndPassword(),
                title: 'Sign Up',
                isActive: controller.isAuthFormValid,
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  signIn(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget termsAndConditions() {
    return Row(
      children: [
        Obx(
          () => DesignCheckBox(
            isChecked: controller.acceptedTermsAndConditions.value,
            onChanged: controller.toggleTermsAndConditions,
          ),
        ),
        const DesignSpace(
          orientation: DesignSpaceOrientation.horizontal,
          size: DesignSize.smallSpace,
        ),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'I agree with',
                style: DesignTextStyle.labelSmall10
                    .apply(color: DesignColor.text400),
              ),
              TextSpan(
                text: ' Terms ',
                style: DesignTextStyle.labelSmall10
                    .apply(color: DesignColor.primary500),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    print('Terms');
                  },
              ),
              TextSpan(
                text: 'and',
                style: DesignTextStyle.labelSmall10
                    .apply(color: DesignColor.text400),
              ),
              TextSpan(
                text: ' Conditions',
                style: DesignTextStyle.labelSmall10
                    .apply(color: DesignColor.primary500),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    print('Conditions');
                  },
              ),
              TextSpan(
                text: '.',
                style: DesignTextStyle.bodySmall14
                    .apply(color: DesignColor.text400),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget signIn() {
    return TextButton(
      onPressed: () => Get.to(
        const SignInPage(),
      ),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Alread have an account?',
              style: DesignTextStyle.labelSmall10
                  .apply(color: DesignColor.text400),
            ),
            TextSpan(
              text: ' Sign In!',
              style: DesignTextStyle.labelSmall10
                  .apply(color: DesignColor.primary500),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void success() => Get.to(() => const SignUpInfoPage());

  @override
  void error(AuthResult result) => Get.snackbar(
        result.title,
        result.message,
        backgroundColor: DesignColor.primary500,
        colorText: Colors.white,
      );
}
