import 'package:flutter/material.dart';
import 'package:pingo/constants/design_color.dart';

// ignore: must_be_immutable
class DesignCheckBox extends StatefulWidget {
  const DesignCheckBox({
    Key? key,
    required this.isChecked,
    required this.onChanged,
  }) : super(key: key);

  final bool isChecked;
  final Function(bool?) onChanged;

  @override
  State<DesignCheckBox> createState() => _DesignCheckBoxState();
}

class _DesignCheckBoxState extends State<DesignCheckBox> {
  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return DesignColor.primary700;
      }
      return DesignColor.primary500;
    }

    return SizedBox(
      width: 24,
      child: Checkbox(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(4),
          ),
        ),
        checkColor: Colors.white,
        fillColor: MaterialStateProperty.resolveWith(getColor),
        value: widget.isChecked,
        onChanged: widget.onChanged,
      ),
    );
  }
}
