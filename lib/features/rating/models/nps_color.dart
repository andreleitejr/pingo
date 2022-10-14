import 'package:flutter/material.dart';

class NpsColor {
  static Color get(int index) {
    if (index <= 6) {
      return const Color(0xFFED8585);
    } else if (index <= 8) {
      return const Color(0xFFE7DD83);
    } else {
      return const Color(0xFF70CB9F);
    }
  }
}
