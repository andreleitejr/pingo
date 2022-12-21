import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pingo/constants/design_color.dart';
import 'package:pingo/constants/design_icons.dart';
import 'package:pingo/constants/design_size.dart';
import 'package:pingo/constants/design_text_style.dart';
import 'package:pingo/features/profile/pages/edit/info/profile_info_edit_page.dart';
import 'package:pingo/features/profile/pages/edit/settings/profile_settings_page.dart';
import 'package:pingo/features/profile/pages/read/profile_read_controller.dart';
import 'package:pingo/features/auth/pages/signin/signin_page.dart';
import 'package:pingo/widgets/design_appbar.dart';
import 'package:pingo/widgets/design_icon.dart';
import 'package:pingo/widgets/design_list_button.dart';
import 'package:pingo/widgets/design_outlined_button.dart';
import 'package:pingo/widgets/design_read_image.dart';
import 'package:pingo/widgets/design_space.dart';

class ProfileReadPage extends StatefulWidget {
  const ProfileReadPage({Key? key}) : super(key: key);

  @override
  State<ProfileReadPage> createState() => _ProfileReadPageState();
}

class _ProfileReadPageState extends State<ProfileReadPage>
    implements ProfileReadNavigator {
  late ProfileReadController controller;

  @override
  void initState() {
    controller = Get.put(ProfileReadController(this));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(DesignSize.appBarHeight),
          child: DesignAppBar(
            showLeading: false,
            title: '@${controller.user.nickname}',
          ),
        ),
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding:
          const EdgeInsets.symmetric(horizontal: DesignSize.mediumSpace),
          child: Column(
            children: [
              Row(
                children: [
                  DesignAvatarImage(image: controller.user.image?.image),
                  const DesignSpace(
                    orientation: DesignSpaceOrientation.horizontal,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.user.name,
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
                            controller.currentLocation.currentAddress,
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
                controller.user.description ??
                    'My name is ${controller.user.name} and I am awesome!',
              ),
              const DesignSpace(),
              DesignOutlinedButton(
                onPressed: () => Get.to(() => const ProfileInfoEditPage()),
                title: 'Edit Profile',
                isActive: true,
              ),
              const DesignSpace(),
              DesignListButton(
                title: 'Settings',
                onTap: () => Get.to(() => ProfileSettingsPage()),
              ),
              // const DesignListButton(title: 'Security'),
              DesignListButton(
                title: 'Support',
                onTap: () => controller.openSupport(),
              ),
              const DesignListButton(title: 'About Pingo'),
              Expanded(child: Container()),
              DesignListButton(
                title: 'Sign Out',
                onTap: () async {
                  await controller.repository.signOut();
                  Get.to(() => const SignInPage());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void supportError() {
    Get.snackbar(
      'Support Error',
      'Unknow problem ocurred',
      backgroundColor: DesignColor.primary500,
      colorText: Colors.white,
    );
  }
}

abstract class ProfileReadNavigator {
  void supportError();
}
