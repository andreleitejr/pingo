import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pingo/core/extensions.dart';
import 'package:pingo/core/keyword.dart';
import 'package:pingo/models/user.dart';
import 'package:pingo/repositories/user_repository.dart';

class SignUpController extends GetxController {
  final _repository = UserRepository();
  final _auth = auth.FirebaseAuth.instance;

  var name = ''.obs;
  final email = ''.obs;
  final password = ''.obs;
  final confirmPassword = ''.obs;
  final birthday = ''.obs;
  final gender = ''.obs;
  final country = ''.obs;
  final city = ''.obs;

  void setName(String v) => name(v);

  void setEmail(String v) => email(v);

  void setPassword(String v) => password(v);

  void setConfirmPassword(String v) => confirmPassword(v);

  void setBirthday(String v) => birthday(v);

  void setGender(String v) => gender(v);

  void setCountry(String v) => country(v);

  void setCity(String v) => city(v);

  var acceptedTermsAndConditions = false.obs;

  void toggleTermsAndConditions(bool? v) => acceptedTermsAndConditions(v!);

  User get user => User(
        name: name.value,
        birthday: DateTime.now(),
        email: email.value,
        gender: gender.value,
        country: country.value,
        city: city.value,
      );

  bool get nameValid => name.value.length >= 6;

  bool get emailValid => GetUtils.isEmail(email.value);

  bool get passwordValid => password.value.containsLettersAndNumbers;

  bool get confirmPasswordValid =>
      confirmPassword.value.isNotEmpty &&
      confirmPassword.value == password.value;

  // TODO: CHANGE TO DATETIME VALIDATION
  bool get birthdayValid => birthday.value.length >= 8;

  bool get genderValid => gender.value.isNotEmpty;

  bool get countryValid => country.isNotEmpty;

  bool get cityValid => city.isNotEmpty;

  bool get isAuthFormValid =>
      nameValid &&
      emailValid &&
      passwordValid &&
      confirmPasswordValid &&
      acceptedTermsAndConditions.value;

  bool get isInfoFormValid =>
      isAuthFormValid &&
      birthdayValid &&
      genderValid &&
      countryValid &&
      cityValid;

  Future<void> create() async {
    await _auth.createUserWithEmailAndPassword(
      email: email.value,
      password: password.value,
    );
  }

  Future<void> save() async {
    await _repository.save(user);
  }


  final PageController pageController = PageController();

  final _scrollTimeDuration = const Duration(milliseconds: 250);

  Future<void> nextPage() => pageController.nextPage(
    duration: _scrollTimeDuration,
    curve: Curves.easeIn,
  );

  Future<void> previousPage() => pageController.previousPage(
    duration: _scrollTimeDuration,
    curve: Curves.easeIn,
  );

  var keywords = <int>[].obs;

  void toggleKeyword(int v) {
    if (!keywords.contains(v)) {
      print('##### ADICIONOU $v');
      keywords.add(v);
    } else {
      print('##### REMOVEU $v');
      keywords.remove(v);
    }
  }

  bool quantityValid(List<Keyword> items, int expectedQuantity) {
    final list = <int>[];
    for (final item in items) {
      list.add(item.id);
    }
    return list.toSet().intersection(keywords.toSet()).length >
        expectedQuantity;
  }
}
