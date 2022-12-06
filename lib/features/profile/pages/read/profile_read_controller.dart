import 'package:get/get.dart';
import 'package:pingo/constants/support.dart';
import 'package:pingo/features/auth/repositories/auth_repository.dart';
import 'package:pingo/features/profile/pages/read/profile_read_page.dart';
import 'package:pingo/models/user.dart';
import 'package:pingo/services/current_location.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileReadController extends GetxController {
  ProfileReadController(this.navigator);

  final ProfileReadNavigator navigator;

  final User user = Get.find();

  final CurrentLocation currentLocation = Get.find();

  final AuthRepository repository = Get.find();

  // var whatsappUrl = "whatsapp://send?phone=${Support.whatsapp}";
  var whatsappUrl =
      "whatsapp://send?phone=${Support.whatsapp}&text=${Uri.encodeComponent('Estou tendo um problema...')}";

  Future<void> openSupport() async {
    try {
      final uri = Uri.parse(whatsappUrl);
      launchUrl(uri);
    } catch (e) {
      navigator.supportError();
    }
  }
}
