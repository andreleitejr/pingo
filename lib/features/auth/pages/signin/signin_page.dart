import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pingo/constants/design_color.dart';
import 'package:pingo/constants/design_images.dart';
import 'package:pingo/constants/design_size.dart';
import 'package:pingo/constants/design_text_style.dart';
import 'package:pingo/core/extensions.dart';
import 'package:pingo/features/auth/pages/recover/recover_page.dart';
import 'package:pingo/features/auth/pages/signin/signin_navigator.dart';
import 'package:pingo/features/auth/pages/signup/signup_page.dart';
import 'package:pingo/features/auth/repositories/auth_repository.dart';
import 'package:pingo/features/auth/pages/signin/sigin_controller.dart';
import 'package:pingo/features/auth/pages/info/info_page.dart';
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

class _SignInPageState extends State<SignInPage> implements SignInNavigator {
  late SignInController controller;

  @override
  void initState() {
    controller = Get.put(SignInController(this));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(DesignSize.appBarHeight),
        child: SafeArea(
          child: DesignAppBar(
            title: 'Sign In',
            onLeadingPressed: () => Get.to(() => const SignUpPage()),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(DesignSize.mediumSpace),
        child: Column(
          children: [
            Expanded(
              child: SizedBox(
                width: 48,
                child: Image.asset(DesignImages.logo),
              ),
            ),
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
                onPressed: () async => await controller.signIn(),
                title: 'Sign In',
                isActive: controller.isAuthFormValid,
              ),
            ),
            Obx(
              () => TextButton(
                  child: Text(
                    controller.recoveryMessage,
                    style: DesignTextStyle.labelSmall10
                        .apply(color: DesignColor.primary500),
                  ),
                  onPressed: () async {
                    final recovered = await Get.to(
                      () => RecoverPasswordPage(
                        email: controller.email.value,
                      ),
                    );
                    controller.showRecoveryMessage(recovered);
                  }),
            ),
            Expanded(child: Container()),
          ],
        ),
      ),
    );
  }

  @override
  void success() {
    Get.to(() => const BasePage());
  }

  @override
  void userNotFoundInDatabase() {
    Get.to(() => const SignUpInfoPage());
  }

  @override
  void error(AuthResult result) {
    Get.snackbar(
      result.title,
      result.message,
      backgroundColor: DesignColor.primary500,
      colorText: Colors.white,
    );
  }
}
