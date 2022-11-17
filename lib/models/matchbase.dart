import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:pingo/constants/design_emojis.dart';
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

  MatchItem get matchItem {
    if (match == null) return matchItems.last;

    return matchItems.firstWhere((m) => match! >= m.value);
  }

  MatchBase.fromMap(DocumentSnapshot document) : super.fromMap(document);

  int compareTo(MatchBase other) {
    // TODO: SUBSTITUIR PELA MAX DISTANCE DO FILTRO
    if (distance <= 1000 && other.distance <= 1000) {
      if (match == other.match) return distance.compareTo(other.distance);
      return match!.compareTo(other.match!) * -1;
    } else {
      return distance.compareTo(other.distance);
    }
  }
}

class MatchItem {
  final int value;
  final String emoji;
  final String message;

  MatchItem(this.value, this.emoji, this.message);
}

// TODO: DAR NOME AOS VALORES
final matchItems = [
  MatchItem(10, DesignEmojis.smilingWithHeartEyes, 'Alma gêmea'),
  MatchItem(7, DesignEmojis.smilingWithHearts, 'Tudo a ver'),
  MatchItem(4, DesignEmojis.smilingWithOpenHands, 'Sua cara'),
  MatchItem(2, DesignEmojis.winkingTongue, 'Você pode gostar'),
  MatchItem(0, DesignEmojis.thinkingFace, 'Outro perfil'),
];
