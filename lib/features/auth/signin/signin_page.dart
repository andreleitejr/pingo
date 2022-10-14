import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pingo/constants/design_color.dart';
import 'package:pingo/constants/design_size.dart';
import 'package:pingo/core/extensions.dart';
import 'package:pingo/features/auth/repositories/auth_repository.dart';
import 'package:pingo/features/auth/signin/sigin_controller.dart';
import 'package:pingo/features/auth/signup/signup_controller.dart';
import 'package:pingo/features/auth/signup/signup_info_page.dart';
import 'package:pingo/features/home/base_page.dart';
import 'package:pingo/widgets/design_appbar.dart';
import 'package:pingo/widgets/design_button.dart';
import 'package:pingo/widgets/design_text_input.dart';
import 'package:pingo/widgets/design_space.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final controller = Get.put(SignInController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(DesignSize.appBarHeight),
        child: DesignAppBar(title: 'Sign In'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(DesignSize.mediumSpace),
        child: Column(
          children: [
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
              () => DesignButton(
                onPressed: () async {
                  if (controller.isAuthFormValid) {
                    final result = await controller.signIn();
                    if (result == AuthResult.success) {
                      Get.to(const BasePage());
                    } else if (result == AuthResult.userNotFoundInDatabase) {
                      Get.to(const SignUpInfoPage());
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
                isActive: controller.isAuthFormValid,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
