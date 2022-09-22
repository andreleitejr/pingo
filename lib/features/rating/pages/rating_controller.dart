import 'package:get/get.dart';
import 'package:pingo/features/rating/models/rating.dart';
import 'package:pingo/features/rating/repositories/rating_repository.dart';

class RatingController extends GetxController {
  RatingController(this.ratedId);

  final String ratedId;

  var message = ''.obs;
  var nps = 10.obs;

  void setNps(int v) => nps(v);

  void setMessage(String v) => message(v);

  Rating get rating => Rating(
        nps: nps.value,
        ratedId: ratedId,
        message: message.value,
      );

  final _repository = RatingRepository();

  Future<void> save() async => await _repository.save(rating);
}
