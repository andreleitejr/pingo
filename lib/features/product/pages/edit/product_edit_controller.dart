import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:pingo/core/keyword.dart';
import 'package:pingo/features/place/models/place.dart';
import 'package:pingo/features/place/repositories/place_repository.dart';
import 'package:pingo/models/address.dart';

class ProductEditController extends GetxController {
  final repository = PlaceRepository();

  var name = ''.obs;
  var description = ''.obs;
  var email = ''.obs;
  var image = ''.obs;

  var price = 0.0.obs;
  var promotionalPrice = 0.0.obs;
  var placeId = ''.obs;

  void setName(String v) => name(v);

  void setDescription(String v) => description(v);

  void setEmail(String v) => email(v);

  void setImage(String v) => image(v);

  String getStringFormattedHour(int hour, int minute) {
    if (hour >= 24) {
      hour = 23;
    }
    String h = hour <= 0 ? '0$hour' : hour.toString();

    if (minute >= 60) {
      minute = 59;
    }
    String m = minute <= 0 ? '0$minute' : minute.toString();

    return '$h:$m';
  }

  bool get nameValid => name.isNotEmpty;

  bool get descriptionValid => description.isNotEmpty;

  bool get emailValid =>
      email.isNotEmpty ? GetUtils.isEmail(email.value) : true;

  // bool get cityValid => city.isNotEmpty;
  //
  // bool get countryValid => country.isNotEmpty;
  //
  // bool get lineValid => line.isNotEmpty;
  //
  // bool get numberValid => number.isNotEmpty;
  //
  // bool get stateValid => state.isNotEmpty;
  //
  // bool get zipValid => zip.isNotEmpty;

  bool get isValid => nameValid && descriptionValid;

  // cityValid &&
  // countryValid &&
  // lineValid &&
  // numberValid &&
  // stateValid &&
  // zipValid

  Address get address => Address(
        city: 'São Paulo',
        complement: '',
        country: 'Brazil',
        line: 'Praça Franklin Roosevelt',
        location: GeoPoint(-23.548471, -46.6466175),
        neighborhood: 'Centro Histórico de São Paulo',
        number: '2',
        state: 'São Paulo',
        zip: '01120010',
      );

  // Address(
  //   city: city.value,
  //   complement: complement.value,
  //   country: country.value,
  //   line: line.value,
  //   state: state.value,
  //   zip: zip.value,
  //   number: number.value,
  //   location: GeoPoint(latitude.value, longitude.value),
  // );

  Place get place => Place(
        address: address,
        description: description.value,
        name: name.value,
        email: email.value,
        open: '08:30',
        close: '22:30',
        image: image.value,
        keywords: [
          Keyword.util,
          Keyword.emergency,
          Keyword.hospital,
        ],
      );

  Future<void> save() async => await repository.save(place);
}
