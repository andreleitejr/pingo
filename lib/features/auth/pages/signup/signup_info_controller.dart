import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';
import 'package:pingo/constants/apis.dart';
import 'package:pingo/core/extensions.dart';
import 'package:pingo/features/auth/models/city.dart';
import 'package:pingo/features/auth/models/country.dart';
import 'package:pingo/features/auth/models/province.dart';
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
    await _getBrazil();
    _getCountries();
  }

  Future<void> _getCountries() async {
    try {
      final response = await Dio().get(APIs.countries);

      final decodedData = json.decode(response.data) as List;

      final c = decodedData.map((data) => Country.fromJson(data)).toList();

      countries(c);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> _getBrazil() async {
    try {
      final json = await rootBundle
          .loadString(APIs.brazil)
          .then((jsonStr) => jsonDecode(jsonStr));

      final c = Country.fromJson(json);

      countries.add(c);
      country(c.name);

      provinces.addAll(c.states);

      final p = c.states
          .firstWhere((province) => province.id == Province.defaultProvince);
      province(p.name);

      cities.addAll(p.cities);

      final ct = p.cities.firstWhere((city) => city.id == City.defaultCity);
      city(ct.name);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  var countries = <Country>[].obs;
  var provinces = <Province>[].obs;
  var cities = <City>[].obs;

  Future<void> _getUser() async {
    final currentUser = await repository.currentUser();
    if (currentUser != null) {
      name(currentUser.displayName);
      email(currentUser.email);
      generateNickname();
    }
  }

  final name = ''.obs;
  final nickname = ''.obs;
  final email = ''.obs;
  final birthday = DateTime.now().legalAge.obs;
  final gender = ''.obs;
  final sexualOrientation = ''.obs;
  final country = ''.obs;
  final province = ''.obs;
  final city = ''.obs;

  void setName(String v) => name(v);

  void setBirthday(DateTime v) => birthday(v);

  void setGender(Gender? v) => gender(v?.text);

  void setSexualOrientation(SexualOrientation? v) =>
      sexualOrientation(v?.title);

  void setCountry(Country? v) {
    country(v?.text);

    if (v != null && v.states.isNotEmpty) {
      setProvince(v.states.first);
    }

    provinces(v?.states);

    if (v != null && v.states.first.cities.isNotEmpty) {
      setCity(v.states.first.cities.first);
    }
  }

  void setProvince(Province? v) {
    province(v?.name);

    city(v?.cities.first.name);

    cities(v?.cities);
  }

  void setCity(City? v) => city(v?.name);

  bool get nameValid => name.value.length >= 6;

  bool get emailValid => GetUtils.isEmail(email.value);

  bool get birthdayValid => birthday.value
      .isBefore(DateTime.now().add(const Duration(days: 1)).legalAge);

  bool get genderValid => gender.value.isNotEmpty;

  bool get sexualOrientationValid => sexualOrientation.value.isNotEmpty;

  bool get countryValid => country.isNotEmpty;

  bool get provinceValid => province.isNotEmpty;

  bool get cityValid => city.isNotEmpty;

  bool get isInfoFormValid =>
      // isAuthFormValid &&
      birthdayValid && genderValid && countryValid && cityValid;

  void generateNickname() {
    final splitName = name.split(' ');

    final randomNumber = Random().nextInt(100000);

    final generatedNickname = (splitName.first +
            (splitName.length > 1 ? splitName[1][0] : '') +
            randomNumber.toString())
        .toLowerCase();

    nickname(generatedNickname);
  }

  User get user => User(
        name: name.value,
        birthday: birthday.value,
        email: email.value,
        gender: gender.value,
        sexualOrientation: sexualOrientation.value,
        country: country.value,
        province: province.value,
        city: city.value,
        agreed: true,
        keywords: [],
        nickname: nickname.value,
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
