import 'package:flutter/material.dart';
import 'package:pingo/constants/design_size.dart';

// ignore: must_be_immutable
class DesignTextInput extends StatefulWidget {
  DesignTextInput({
    Key? key,
    this.initialValue,
    required this.hint,
    required this.onChanged,
    this.obscureText = false,
    this.prefixIcon,
    this.isValid = false,
    this.textInputType = TextInputType.text,
    this.textEditingController,
  }) : super(key: key);

  final String? initialValue;
  final String hint;
  final Function(String) onChanged;
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
    return TextFormField(
      controller: widget.textEditingController,
      initialValue: widget.initialValue,
      onChanged: widget.onChanged,
      obscureText: widget.obscureText,
      keyboardType: widget.textInputType,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DesignSize.borderRadius),
        ),
        hintText: widget.hint,
        suffixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.isValid)
              Container(
                height: 16,
                width: 16,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(32),
                ),
              ),
            if (isPassword)
              TextButton(
                onPressed: () {
                  setState(() {
                    widget.obscureText = !widget.obscureText;
                  });
                },
                child: Text(
                  widget.obscureText ? 'Show' : 'Hide',
                ),
              ),
          ],
        ),
      ),
    );
  }
}
