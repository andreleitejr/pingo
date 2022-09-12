import 'package:flutter/material.dart';
import 'package:pingo/constants/design_size.dart';
import 'package:pingo/widgets/design_horizontal_medium_divider.dart';

class DesignTextInput extends StatefulWidget {
  DesignTextInput({
    Key? key,
    required this.hint,
    required this.onChanged,
    this.obscureText = false,
    this.prefixIcon,
    this.isValid = false,
  }) : super(key: key);

  final String hint;
  final Function(String) onChanged;
  final Widget? prefixIcon;
  bool obscureText;
  final bool isValid;

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
      onChanged: widget.onChanged,
      obscureText: widget.obscureText,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
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
