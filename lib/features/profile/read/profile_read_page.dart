import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pingo/constants/design_color.dart';
import 'package:pingo/constants/design_icons.dart';
import 'package:pingo/constants/design_size.dart';
import 'package:pingo/constants/design_text_style.dart';
import 'package:pingo/core/current_location.dart';
import 'package:pingo/features/auth/repositories/auth_repository.dart';
import 'package:pingo/features/auth/signin/signin_page.dart';
import 'package:pingo/models/user.dart';
import 'package:pingo/widgets/design_appbar.dart';
import 'package:pingo/widgets/design_icon.dart';
import 'package:pingo/widgets/design_list_button.dart';
import 'package:pingo/widgets/design_outlined_button.dart';
import 'package:pingo/widgets/design_read_image.dart';
import 'package:pingo/widgets/design_space.dart';

class ProfileReadPage extends StatelessWidget {
  ProfileReadPage({Key? key}) : super(key: key);

  final User user = Get.find();
  final CurrentLocation currentLocation = Get.find();
  final AuthRepository repository = AuthRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(DesignSize.appBarHeight),
        child: DesignAppBar(
          showLeading: false,
          title: 'Profile',
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: DesignSize.mediumSpace),
        child: ListView(
          children: [
            Row(
              children: [
                DesignAvatarImage(image: user.image?.image),
                const DesignSpace(
                  orientation: DesignSpaceOrientation.horizontal,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.name,
                      style: DesignTextStyle.bodyMedium16Bold
                          .apply(color: DesignColor.text500),
                    ),
                    const DesignSpace(size: 4),
                    Row(
                      children: [
                        const DesignIcon(
                          icon: DesignIcons.place,
                          width: 8,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          currentLocation.currentLocationAddress,
                          style: DesignTextStyle.labelMedium12
                              .apply(color: DesignColor.text400),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
            const DesignSpace(),
            Text(
              user.description ?? 'My name is ${user.name} and I am awesome!',
            ),
            const DesignSpace(),
            DesignOutlinedButton(
              onPressed: () async {
                await repository
                    .signOut()
                    .then((_) => Get.to(() => const SignInPage()));
              },
              title: 'Edit Profile',
              isActive: true,
            ),
            const DesignSpace(),
            const DesignListButton(title: 'Preferences'),
            const DesignListButton(title: 'Settings'),
            const DesignListButton(title: 'Security'),
            const DesignListButton(title: 'Help'),
            const DesignListButton(title: 'About Pingo'),
          ],
        ),
      ),
    );
  }
}
