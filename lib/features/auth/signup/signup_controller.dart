import 'package:get/get.dart';
import 'package:pingo/core/extensions.dart';
import 'package:pingo/features/auth/repositories/auth_repository.dart';
import 'package:pingo/models/user.dart';

class SignUpController extends GetxController {
  final repository = AuthRepository();

  final name = ''.obs;
  final email = ''.obs;
  final password = ''.obs;
  final confirmPassword = ''.obs;
  final birthday = DateTime.now().obs;
  final gender = ''.obs;
  final country = ''.obs;
  final state = ''.obs;
  final city = ''.obs;
  final acceptedTermsAndConditions = false.obs;

  void setName(String v) => name(v);

  void setEmail(String v) => email(v);

  void setPassword(String v) => password(v);

  void setConfirmPassword(String v) => confirmPassword(v);

  void setBirthday(DateTime v) => birthday(v);

  void setGender(String v) => gender(v);

  void setCountry(String v) {
    country(v);
  }

  void setState(String? v) {
    state(v);
  }

  void setCity(String? v) => city(v);

  void toggleTermsAndConditions(bool? v) => acceptedTermsAndConditions(v!);

  User get user => User(
        name: name.value,
        birthday: birthday.value,
        email: email.value,
        gender: gender.value,
        country: country.value,
        state: state.value,
        city: city.value,
        agreed: acceptedTermsAndConditions.value,
        keywords: [],
      );

  bool get nameValid => name.value.length >= 6;

  bool get emailValid => GetUtils.isEmail(email.value);

  bool get passwordValid => password.value.passwordValid;

  bool get confirmPasswordValid =>
      confirmPassword.value.isNotEmpty &&
      confirmPassword.value == password.value;

  bool get birthdayValid => birthday.value.acceptedAge;

  bool get genderValid => gender.value.isNotEmpty;

  bool get countryValid => country.isNotEmpty;

  bool get stateValid => state.isNotEmpty;

  bool get cityValid => city.isNotEmpty;

  bool get isAuthFormValid =>
      nameValid &&
      emailValid &&
      passwordValid &&
      confirmPasswordValid &&
      acceptedTermsAndConditions.value;

  bool get isInfoFormValid =>
      // isAuthFormValid &&
      birthdayValid && genderValid && countryValid && stateValid && cityValid;

  Future<AuthResult> signUpWithEmailAndPassword() async {
    var result = await repository.signUpWithEmailAndPassword(
        name.value, email.value, password.value);

    if (result == AuthResult.success) {
      result = await repository.save(user);
    }

    return result;
  }
}
