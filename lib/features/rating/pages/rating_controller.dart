import 'package:get/get.dart';
import 'package:pingo/features/rating/models/rating.dart';
import 'package:pingo/features/rating/repositories/rating_repository.dart';
import 'package:pingo/models/user.dart';

class RatingController extends GetxController {
  RatingController(this.ratedId);

  final User user = Get.find();
  final String ratedId;

  var message = ''.obs;
  var title = ''.obs;
  var nps = 10.obs;

  void setNps(int v) => nps(v);

  void setMessage(String v) => message(v);

  void setTitle(String v) => title(v);

  Rating get rating => Rating(
        nps: nps.value,
        ratedId: ratedId,
        message: message.value,
        title: title.value,
        image: user.image,
        ratedBy: user.uuid,
      );

  final _repository = RatingRepository();

  Future<void> save() async => await _repository.save(rating);
}
