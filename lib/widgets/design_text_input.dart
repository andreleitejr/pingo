import 'package:flutter/material.dart';
import 'package:pingo/constants/design_color.dart';
import 'package:pingo/constants/design_icons.dart';
import 'package:pingo/constants/design_size.dart';
import 'package:pingo/constants/design_text_style.dart';
import 'package:pingo/widgets/design_icon.dart';

// ignore: must_be_immutable
class DesignTextInput extends StatefulWidget {
  DesignTextInput({
    Key? key,
    this.initialValue,
    required this.hint,
    this.onChanged,
    this.obscureText = false,
    this.prefixIcon,
    this.isValid = false,
    this.textInputType = TextInputType.text,
    this.textEditingController,
  }) : super(key: key);

  final String? initialValue;
  final String hint;
  final Function(String)? onChanged;
  final Widget? prefixIcon;
  bool obscureText;
  final bool isValid;
  final TextInputType textInputType;
  final TextEditingController? textEditingController;

  @override
  State<DesignTextInput> createState() => _DesignTextInputState();
}

class _DesignTextInputState extends State<DesignTextInput> {
  bool isPassword = false;

  @override
  void initState() {
    isPassword = widget.obscureText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: TextFormField(
        controller: widget.textEditingController,
        initialValue: widget.initialValue,
        onChanged: widget.onChanged,
        obscureText: widget.obscureText,
        keyboardType: widget.textInputType,
        style: DesignTextStyle.bodySmall12Bold
            .apply(color: DesignColor.text400),
        decoration: InputDecoration(
          hintStyle: DesignTextStyle.bodySmall12.apply(
            color: DesignColor.text300,
          ),
          filled: true,
          fillColor: DesignColor.text100,
          contentPadding: const EdgeInsets.only(
            left: DesignSize.mediumSpace,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              DesignSize.borderRadius,
            ),
            borderSide: const BorderSide(
              width: 0.5,
              color: DesignColor.text200,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              DesignSize.borderRadius,
            ),
            borderSide: const BorderSide(
              width: 0.5,
              color: DesignColor.text200,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              DesignSize.borderRadius,
            ),
            borderSide: const BorderSide(
              width: 0.75,
              color: DesignColor.primary500,
            ),
          ),
          hintText: widget.hint,
          suffixIcon: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isPassword)
                TextButton(
                  onPressed: () {
                    setState(() {
                      widget.obscureText = !widget.obscureText;
                    });
                  },
                  child: Text(
                    widget.obscureText ? 'Show' : 'Hide',
                    style: DesignTextStyle.bodySmall12
                        .apply(color: DesignColor.primary500),
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
