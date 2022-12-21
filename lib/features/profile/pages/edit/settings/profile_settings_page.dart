import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pingo/constants/design_size.dart';
import 'package:pingo/services/current_location.dart';
import 'package:pingo/features/auth/repositories/auth_repository.dart';
import 'package:pingo/models/user.dart';
import 'package:pingo/widgets/design_appbar.dart';
import 'package:pingo/widgets/design_list_button.dart';
import 'package:pingo/widgets/design_space.dart';

class ProfileSettingsPage extends StatelessWidget {
  ProfileSettingsPage({Key? key}) : super(key: key);

  final User user = Get.find();
  final CurrentLocation currentLocation = Get.find();
  final AuthRepository repository = AuthRepository();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(DesignSize.appBarHeight),
          child: DesignAppBar(
            title: 'Settings',
          ),
        ),
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: DesignSize.mediumSpace),
          child: Column(
            children: [
              const DesignSpace(),
              DesignListButton(
                title: 'Location',
                onTap: () => AppSettings.openLocationSettings(),
              ),
              DesignListButton(
                title: 'Notifications',
                onTap: () => AppSettings.openNotificationSettings(),
              ),
              DesignListButton(
                title: 'Connection',
                onTap: () => AppSettings.openWirelessSettings(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
