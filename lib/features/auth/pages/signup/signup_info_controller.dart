import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pingo/constants/apis.dart';
import 'package:pingo/core/extensions.dart';
import 'package:pingo/features/auth/models/city.dart';
import 'package:pingo/features/auth/pages/signup/signup_info_page.dart';
import 'package:pingo/features/profile/models/gender.dart';
import 'package:pingo/features/profile/models/sexual_orientation.dart';
import 'package:pingo/models/user.dart';
import 'package:pingo/features/auth/repositories/auth_repository.dart';

class SignUpInfoController extends GetxController {
  SignUpInfoController(this.navigator);

  final AuthRepository repository = AuthRepository();

  final SignUpInfoNavigator navigator;

  @override
  Future<void> onReady() async {
    _getUser();
    _getCountries();
  }

  Future<void> _getCountries() async {
    try {
      final response = await Dio().get(APIs.countries);

      final decodedData = json.decode(response.data) as List;

      try {
        final c = decodedData.map((data) => Country.fromJson(data)).toList();
        print(countries.length);
        countries(c);
        print(countries.length);

      } catch (e) {
        print('HUSDAHASDUHADSUDAHUHADSU $e');
      }
    } catch (e) {
      print(e);
    }
  }

  var countries = <Country>[].obs;

  Future<void> _getUser() async {
    final currentUser = await repository.currentUser();
    if (currentUser != null) {
      nameController.value.text = currentUser.displayName!;
      emailController.value.text = currentUser.email!;
    }
  }

  final nameController = TextEditingController().obs;
  final emailController = TextEditingController().obs;

  final name = ''.obs;
  final email = ''.obs;
  final birthday = DateTime.now().legalAge.obs;
  final gender = ''.obs;
  final sexualOrientation = ''.obs;
  final country = ''.obs;
  final state = ''.obs;
  final city = ''.obs;

  void setName(String v) => name(v);

  void setBirthday(DateTime v) => birthday(v);

  void setGender(Gender? v) => gender(v?.title);

  void setSexualOrientation(SexualOrientation? v) =>
      sexualOrientation(v?.title);

  void setCountry(String v) => country(v);

  void setState(String? v) => state(v);

  void setCity(String? v) => city(v);

  bool get nameValid => name.value.length >= 6;

  bool get birthdayValid => birthday.value
      .isBefore(DateTime.now().add(const Duration(days: 1)).legalAge);

  bool get genderValid => gender.value.isNotEmpty;

  bool get sexualOrientationValid => sexualOrientation.value.isNotEmpty;

  bool get countryValid => country.isNotEmpty;

  bool get stateValid => state.isNotEmpty;

  bool get cityValid => city.isNotEmpty;

  bool get isInfoFormValid =>
      // isAuthFormValid &&
      birthdayValid && genderValid && countryValid && cityValid;

  User get user => User(
        name: name.value,
        birthday: birthday.value,
        email: email.value,
        gender: gender.value,
        sexualOrientation: sexualOrientation.value,
        country: country.value,
        state: state.value,
        city: city.value,
        agreed: true,
        keywords: [],
      );

  Future<void> save() async {
    if (isInfoFormValid) {
      final result = await repository.save(user);

      if (result == AuthResult.success) {
        navigator.success();
      } else {
        navigator.error(result);
      }
    } else {
      navigator.error(AuthResult.required);
    }
  }
}
