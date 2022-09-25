import 'package:flutter/material.dart';

class DesignSlider extends StatelessWidget {
  const DesignSlider({
    Key? key,
    required this.value,
    required this.minValue,
    required this.maxValue,
    this.divisions,
    required this.onChanged,
  }) : super(key: key);

  final double value;
  final double minValue;
  final double maxValue;
  final int? divisions;
  final Function(double) onChanged;

  @override
  Widget build(BuildContext context) {
    return Slider(
      value: value,
      min: minValue,
      max: maxValue,
      divisions: divisions,
      label: value.round().toString(),
      onChanged: onChanged,
    );
  }
}
