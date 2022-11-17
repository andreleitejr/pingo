import 'package:flutter/material.dart';
import 'package:pingo/constants/design_color.dart';

class DesignSlider extends StatelessWidget {
  const DesignSlider({
    Key? key,
    this.minValue,
    required this.maxValue,
    required this.min,
    required this.max,
    this.divisions,
    this.onChanged,
    this.isRange = false,
    this.onRangeChanged,
  }) : super(key: key);

  final double? minValue;
  final double maxValue;
  final double min;
  final double max;
  final int? divisions;
  final Function(double)? onChanged;
  final Function(RangeValues)? onRangeChanged;
  final bool isRange;

  RangeValues get _currentRangeValues => RangeValues(minValue ?? 0, maxValue);

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        valueIndicatorColor: DesignColor.primary500,
        inactiveTrackColor: DesignColor.primary100,
        activeTrackColor: DesignColor.primary500,
        trackHeight: 2,
        thumbColor: DesignColor.primary500,
        overlayColor: const Color(0x29EB1555),
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
        overlayShape: const RoundSliderOverlayShape(overlayRadius: 20),
      ),
      child: isRange
          ? RangeSlider(
              values: _currentRangeValues,
              max: max,
              divisions: 5,
              labels: RangeLabels(
                _currentRangeValues.start.round().toString(),
                _currentRangeValues.end.round().toString(),
              ),
              onChanged: onRangeChanged,
            )
          : Slider(
              value: maxValue,
              min: min,
              max: max,
              divisions: divisions,
              label: maxValue.round().toString(),
              onChanged: onChanged,
            ),
    );
  }
}
