import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:pingo/constants/design_color.dart';
import 'package:pingo/constants/design_icons.dart';
import 'package:pingo/constants/design_size.dart';
import 'package:pingo/constants/design_text_style.dart';
import 'package:pingo/core/extensions.dart';

class DesignDateInput extends StatefulWidget {
  const DesignDateInput({
    Key? key,
    required this.onPressed,
    required this.hint,
    this.value,
    this.isValid = false,
  }) : super(key: key);
  final Function(DateTime) onPressed;
  final DateTime? value;
  final String hint;
  final bool isValid;

  @override
  State<DesignDateInput> createState() => _DesignDateInputState();
}

class _DesignDateInputState extends State<DesignDateInput> {
  final minAgeAccepted = DateTime.now().legalAge;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: selectDate,
      child: Container(
        padding: const EdgeInsets.only(left: DesignSize.mediumSpace),
        alignment: Alignment.centerLeft,
        height: 42,
        width: double.infinity,
        decoration: BoxDecoration(
          color: DesignColor.text100,
          border: Border.all(
            width: 0.5,
            color: DesignColor.text200,
          ),
          borderRadius: BorderRadius.circular(DesignSize.borderRadius),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                widget.value?.yMMMMd ?? widget.hint,
                style: DesignTextStyle.bodySmall12.apply(
                  color: DesignColor.text300,
                ),
              ),
            ),
            if (widget.isValid)
              Container(
                height: 16,
                width: 16,
                margin: const EdgeInsets.only(right: DesignSize.mediumSpace),
                child: Image.asset(DesignIcons.valid),
              ),
          ],
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
        decorationDateSelected: const BoxDecoration(
            color: DesignColor.primary500, shape: BoxShape.circle),
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
