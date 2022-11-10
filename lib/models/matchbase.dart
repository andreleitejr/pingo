import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:pingo/models/base.dart';
import 'package:pingo/models/user.dart';

class MatchBase extends Base {
  MatchBase(
      {required super.name,
      required super.keywords,
      super.image,
      super.description});

  int? match;
  final User user = Get.find();

  int get matchPercentage {
    if (match == null) return 0;
    final keywords = user.keywords.length;
    return (match! * 100 / keywords).round();
  }

  String get matchMessage {
    if (matchPercentage > 90) {
      return 'Alma gêmea';
    } else if (matchPercentage > 80) {
      return 'Tudo a ver';
    } else if (matchPercentage > 70) {
      return 'Sua cara';
    } else if (matchPercentage > 40) {
      return 'Você pode gostar';
    } else {
      return 'Outro perfil';
    }
  }

  MatchBase.fromMap(DocumentSnapshot document) : super.fromMap(document);

  int compareTo(MatchBase other) {
    // TODO: SUBSTITUIR PELA MAX DISTANCE DO FILTRO
    if (distance <= 1000 && other.distance <= 1000) {
      if (match == other.match) return distance.compareTo(other.distance);
      return match!.compareTo(other.match!) * -1;
    } else {
      return distance.compareTo(other.distance);

      // if (match == other.match) return distance.compareTo(other.distance);
    }
  }
}
