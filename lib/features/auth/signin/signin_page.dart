import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pingo/constants/design_size.dart';
import 'package:pingo/features/auth/signup/signup_controller.dart';
import 'package:pingo/features/auth/signup/signup_info_page.dart';
import 'package:pingo/widgets/design_appbar.dart';
import 'package:pingo/widgets/design_button.dart';
import 'package:pingo/widgets/design_text_input.dart';
import 'package:pingo/widgets/design_vertical_space.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final controller = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(DesignSize.appBarHeight),
        child: DesignAppBar(title: 'Sign In'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(DesignSize.padding),
        child: Column(
          children: [
            DesignTextInput(
              hint: 'E-mail',
              onChanged: (String) {},
            ),
            const DesignVerticalSpace(),
            DesignTextInput(
              hint: 'Password',
              obscureText: true,
              onChanged: (String) {},
            ),
            const DesignVerticalSpace(),
            DesignButton(
              onPressed: () => Get.to(
                const SignUpInfoPage(),
              ),
              title: 'Sign Up',
            ),
          ],
        ),
      ),
    );
  }
}
