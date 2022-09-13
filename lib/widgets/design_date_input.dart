import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:pingo/constants/design_color.dart';
import 'package:pingo/constants/design_size.dart';
import 'package:pingo/constants/design_text_style.dart';
import 'package:pingo/core/extensions.dart';
import 'package:pingo/widgets/design_horizontal_medium_divider.dart';

class DesignDateInput extends StatefulWidget {
  const DesignDateInput(
      {Key? key, required this.onPressed, required this.hint, this.value})
      : super(key: key);
  final Function(DateTime) onPressed;
  final DateTime? value;
  final String hint;

  @override
  State<DesignDateInput> createState() => _DesignDateInputState();
}

class _DesignDateInputState extends State<DesignDateInput> {
  final minAgeAccepted = DateTime(DateTime.now().year - 18);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: selectDate,
      child: Container(
        padding: const EdgeInsets.only(left: DesignSize.padding),
        alignment: Alignment.centerLeft,
        height: DesignSize.buttonHeight,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(
            color: DesignColor.text300,
          ),
          borderRadius: BorderRadius.circular(DesignSize.borderRadius),
        ),
        child: Text(
          widget.value?.format ?? widget.hint,
          style: DesignTextStyle.bodyMedium16.apply(color: DesignColor.text400),
        ),
      ),
    );
  }

  Future<void> selectDate() async {
    DateTime? pickedDate = await showRoundedDatePicker(
      height: 300,
      styleDatePicker: MaterialRoundedDatePickerStyle(
        textStyleDayButton: DesignTextStyle.bodyMedium16,
        textStyleYearButton: DesignTextStyle.bodyLarge18Bold
            .apply(color: DesignColor.primary700),

        textStyleDayHeader: DesignTextStyle.bodyMedium16Bold,

        paddingDatePicker: EdgeInsets.zero,
        paddingMonthHeader: const EdgeInsets.all(16),
        sizeArrow: DesignSize.mediumSpace,
        textStyleButtonNegative:
            DesignTextStyle.bodySmall14.apply(color: DesignColor.text400),
        textStyleButtonPositive:
            DesignTextStyle.bodySmall14.apply(color: DesignColor.primary500),
        decorationDateSelected: const
            BoxDecoration(color: DesignColor.primary500, shape: BoxShape.circle),
        backgroundPicker: Colors.white,
        backgroundHeader: Colors.white,
        backgroundActionBar: Colors.white,
        backgroundHeaderMonth: Colors.white,

      ),
      styleYearPicker: MaterialRoundedYearPickerStyle(
        textStyleYear:
            DesignTextStyle.bodyMedium16.apply(color: DesignColor.text500),
        textStyleYearSelected:
            DesignTextStyle.bodyMedium16.apply(color: DesignColor.primary500),
      ),
      textPositiveButton: 'Select Date'.toUpperCase(),
      context: context,
      initialDate: minAgeAccepted,
      firstDate: DateTime(1900),
      lastDate: minAgeAccepted,
    );

    if (pickedDate != null && pickedDate != widget.value) {
      widget.onPressed(pickedDate);
    }
  }

  bool disableDate(DateTime day) {
    if (day.isAfter(minAgeAccepted)) {
      return true;
    }
    return false;
  }
}
