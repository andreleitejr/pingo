import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pingo/constants/design_color.dart';
import 'package:pingo/constants/design_size.dart';
import 'package:pingo/core/extensions.dart';
import 'package:pingo/features/auth/models/city.dart';
import 'package:pingo/features/auth/models/country.dart';
import 'package:pingo/features/auth/models/province.dart';
import 'package:pingo/features/auth/pages/signup/signup_info_controller.dart';
import 'package:pingo/features/auth/repositories/auth_repository.dart';
import 'package:pingo/features/profile/models/gender.dart';
import 'package:pingo/features/profile/models/sexual_orientation.dart';
import 'package:pingo/features/profile/pages/edit/keywords/profile_keywords_edit_page.dart';
import 'package:pingo/widgets/design_appbar.dart';
import 'package:pingo/widgets/design_button.dart';
import 'package:pingo/widgets/design_date_input.dart';
import 'package:pingo/widgets/design_text_input.dart';
import 'package:pingo/widgets/design_space.dart';
import 'package:pingo/widgets/dialogs/design_selection_dialog.dart';

class SignUpInfoPage extends StatefulWidget {
  const SignUpInfoPage({Key? key}) : super(key: key);

  @override
  State<SignUpInfoPage> createState() => _SignUpInfoPageState();
}

class _SignUpInfoPageState extends State<SignUpInfoPage>
    implements SignUpInfoNavigator {
  late SignUpInfoController controller;

  @override
  void initState() {
    controller = Get.put(SignUpInfoController(this));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(DesignSize.appBarHeight),
        child: SafeArea(
          child: DesignAppBar(title: 'Personal Info'),
        ),
      ),
      // resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(DesignSize.mediumSpace),
        child: ListView(
          children: [
            Obx(
              () => DesignTextInput(
                value: controller.name.value,
                hint: 'Name',
                onChanged: controller.setName,
                isValid: controller.nameValid,
              ),
            ),
            const DesignSpace(),
            Obx(
              () => DesignTextInput(
                value: controller.email.value,
                hint: 'E-mail',
                isValid: controller.emailValid,
              ),
            ),
            const DesignSpace(),
            Obx(
              () => DesignDateInput(
                hint: 'Birthday',
                onPressed: controller.setBirthday,
                value: controller.birthday.value,
                isValid: controller.birthdayValid,
              ),
            ),
            const DesignSpace(),
            Obx(
              () {
                return DesignSelectionDialog<Country>(
                  items: controller.countries,
                  value: controller.countries.firstWhereOrNull(
                    (country) => country.name == controller.country.value,
                  ),
                  hint: 'Country',
                  onChanged: controller.setCountry,
                  isValid: controller.countryValid,
                  showSearch: true,
                );
              },
            ),
            const DesignSpace(),
            Obx(
              () {
                return DesignSelectionDialog<Province>(
                  items: controller.provinces,
                  value: controller.provinces.firstWhereOrNull(
                    (province) => province.name == controller.province.value,
                  ),
                  hint: 'Province',
                  onChanged: controller.setProvince,
                  isValid: controller.provinceValid,
                  showSearch: true,
                );
              },
            ),
            const DesignSpace(),
            Obx(
              () {
                return DesignSelectionDialog<City>(
                  items: controller.cities,
                  value: controller.cities.firstWhereOrNull(
                    (city) => city.name == controller.city.value,
                  ),
                  hint: 'City',
                  onChanged: controller.setCity,
                  isValid: controller.countryValid,
                  showSearch: true,
                );
              },
            ),
            const DesignSpace(),
            Obx(
              () => DesignSelectionDialog<Gender>(
                items: genders,
                value: genders.firstWhereOrNull(
                  (gender) => gender.title == controller.gender.value,
                ),
                hint: 'Gender',
                onChanged: controller.setGender,
                isValid: controller.genderValid,
              ),
            ),
            const DesignSpace(),
            Obx(
              () => DesignSelectionDialog<SexualOrientation>(
                items: sexualOrientations,
                value: sexualOrientations.firstWhereOrNull(
                  (sexualOrientation) =>
                      sexualOrientation.title ==
                      controller.sexualOrientation.value,
                ),
                hint: 'Sexual Orientation',
                onChanged: controller.setSexualOrientation,
                isValid: controller.sexualOrientationValid,
              ),
            ),
            const DesignSpace(),
            Obx(
              () => DesignButton(
                onPressed: () async => controller.save(),
                title: 'Sign In',
                isActive: controller.isInfoFormValid,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void success() => Get.to(() => ProfileKeywordsSelection());

  @override
  void error(AuthResult result) => Get.snackbar(
        result.title,
        result.message,
        backgroundColor: DesignColor.primary500,
        colorText: Colors.white,
      );
}

abstract class SignUpInfoNavigator {
  void success();

  void error(AuthResult result);
}
