import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pingo/constants/design_size.dart';
import 'package:pingo/features/auth/repositories/auth_repository.dart';
import 'package:pingo/features/auth/signin/signin_page.dart';
import 'package:pingo/models/user.dart';
import 'package:pingo/widgets/design_appbar.dart';
import 'package:pingo/widgets/design_button.dart';
import 'package:pingo/widgets/design_read_image.dart';

class ProfileReadPage extends StatelessWidget {
  ProfileReadPage({Key? key}) : super(key: key);

  final User user = Get.find();
  final AuthRepository repository = AuthRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(DesignSize.appBarHeight),
        child: DesignAppBar(
          showLeading: false,
          title: user.name,
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DesignReadImage(image: user.image),
          Text(user.name),
          if (user.description != null) Text(user.description!),
          DesignButton(
            onPressed: () async {
              await repository
                  .signOut()
                  .then((_) => Get.to(() => const SignInPage()));
            },
            title: 'Log out',
            isActive: true,
          ),
        ],
      ),
    );
  }
}
