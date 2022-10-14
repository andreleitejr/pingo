import 'package:flutter/material.dart';
import 'package:pingo/constants/design_color.dart';
import 'package:pingo/constants/design_size.dart';
import 'package:pingo/constants/design_text_style.dart';

class DesignSearchInput extends StatefulWidget {
  const DesignSearchInput({
    Key? key,
    this.value,
    this.hint,
    this.onChanged,
    this.autoFocus = false,
  }) : super(key: key);

  final String? value;
  final String? hint;
  final Function(String)? onChanged;
  final bool autoFocus;

  @override
  State<DesignSearchInput> createState() => _DesignSearchInputState();
}

class _DesignSearchInputState extends State<DesignSearchInput> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextFormField(
        autofocus: widget.autoFocus,
        initialValue: widget.value,
        onChanged: widget.onChanged,
        style: DesignTextStyle.bodySmall14.apply(color: DesignColor.text500),
        decoration: InputDecoration(
          hintStyle:
              DesignTextStyle.bodySmall14.apply(color: DesignColor.text300),
          filled: true,
          fillColor: DesignColor.text100,
          contentPadding: const EdgeInsets.only(
            top: DesignSize.smallSpace,
            left: DesignSize.mediumSpace,
          ),
          focusColor: DesignColor.primary500,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide:
                const BorderSide(width: 0.5, color: DesignColor.text200),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide:
                const BorderSide(width: 0.5, color: DesignColor.text200),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide:
                const BorderSide(width: 0.75, color: DesignColor.primary500),
          ),
          hintText: widget.hint,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
      ),
    );
  }
}
