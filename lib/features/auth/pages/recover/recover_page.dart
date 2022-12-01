import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pingo/constants/design_color.dart';
import 'package:pingo/constants/design_images.dart';
import 'package:pingo/constants/design_size.dart';
import 'package:pingo/core/extensions.dart';
import 'package:pingo/features/auth/pages/recover/recover_controller.dart';
import 'package:pingo/features/auth/pages/signin/signin_page.dart';
import 'package:pingo/features/auth/pages/signup/signup_page.dart';
import 'package:pingo/features/auth/repositories/auth_repository.dart';
import 'package:pingo/features/auth/pages/signup/signup_info_page.dart';
import 'package:pingo/features/home/base_page.dart';
import 'package:pingo/widgets/design_appbar.dart';
import 'package:pingo/widgets/design_button.dart';
import 'package:pingo/widgets/design_text_input.dart';
import 'package:pingo/widgets/design_space.dart';

class RecoverPasswordPage extends StatefulWidget {
  const RecoverPasswordPage({Key? key, required this.email}) : super(key: key);

  final String email;

  @override
  State<RecoverPasswordPage> createState() => _RecoverPasswordPageState();
}

class _RecoverPasswordPageState extends State<RecoverPasswordPage>
    implements RecoverNavigator {
  late RecoverPasswordController controller;

  @override
  void initState() {
    controller = Get.put(RecoverPasswordController(this, email: widget.email));
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
            onLeadingPressed: () => Get.back(),
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
                value: controller.email.value,
                hint: 'E-mail',
                onChanged: controller.setEmail,
                isValid: controller.emailValid,
              ),
            ),
            const DesignSpace(),
            Obx(
              () => DesignButton(
                onPressed: () async => await controller.recoverPassword(),
                title: 'Recover Password',
                isActive: controller.emailValid,
              ),
            ),
            Expanded(child: Container()),
          ],
        ),
      ),
    );
  }

  @override
  void success() => Get.back();

  @override
  void userNotFoundInDatabase() => Get.to(() => const SignUpInfoPage());

  @override
  void error(AuthResult result) => Get.snackbar(
        result.title,
        result.message,
        backgroundColor: DesignColor.primary500,
        colorText: Colors.white,
      );
}

abstract class RecoverNavigator {
  void success();

  void userNotFoundInDatabase();

  void error(AuthResult result);
}
