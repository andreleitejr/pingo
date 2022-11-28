import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pingo/constants/design_color.dart';
import 'package:pingo/constants/design_images.dart';
import 'package:pingo/constants/design_size.dart';
import 'package:pingo/constants/design_text_style.dart';
import 'package:pingo/features/auth/pages/signin/signin_page.dart';
import 'package:pingo/features/auth/pages/signup/signup_controller.dart';
import 'package:pingo/features/auth/pages/signup/signup_info_page.dart';
import 'package:pingo/widgets/design_button.dart';
import 'package:pingo/widgets/design_check_box.dart';
import 'package:pingo/widgets/design_text_input.dart';
import 'package:pingo/widgets/design_space.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final controller = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(DesignSize.mediumSpace),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(child: Container()),
            Expanded(
              child: SizedBox(
                width: 48,
                child: Image.asset(DesignImages.logo),
              ),
            ),
            const DesignSpace(),
            const DesignSpace(),
            const DesignSpace(),
            Obx(
              () => DesignTextInput(
                hint: 'Name',
                onChanged: controller.setName,
                isValid: controller.nameValid,
              ),
            ),
            const DesignSpace(),
            Obx(
              () => DesignTextInput(
                hint: 'E-mail',
                onChanged: controller.setEmail,
                isValid: controller.emailValid,
              ),
            ),
            const DesignSpace(),
            Obx(
              () => DesignTextInput(
                hint: 'Password',
                obscureText: true,
                onChanged: controller.setPassword,
                isValid: controller.passwordValid,
              ),
            ),
            const DesignSpace(),
            Obx(
              () => DesignTextInput(
                hint: 'Confirm Password',
                obscureText: true,
                onChanged: controller.setConfirmPassword,
                isValid: controller.confirmPasswordValid,
              ),
            ),
            const DesignSpace(size: DesignSize.smallSpace),
            termsAndConditions(),
            const DesignSpace(size: DesignSize.smallSpace),
            Obx(
              () => DesignButton(
                onPressed: () async {
                  if (controller.isAuthFormValid) {
                    Get.to(const SignUpInfoPage());
                  }
                },
                title: 'Sign Up',
                isActive: controller.isAuthFormValid,
              ),
            ),
            signIn(),
            Expanded(child: Container()),
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
}
