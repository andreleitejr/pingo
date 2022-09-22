import 'package:flutter/material.dart';

class NpsColor {
  static Color get(int index) {
    if (index <= 6) {
      return Colors.red;
    } else if (index <= 8) {
      return Colors.amber;
    } else {
      return Colors.green;
    }
  }
}
