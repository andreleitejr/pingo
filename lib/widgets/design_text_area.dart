import 'package:flutter/material.dart';
import 'package:pingo/constants/design_size.dart';

class DesignTextArea extends StatelessWidget {
  const DesignTextArea({
    Key? key,
    required this.hint,
    required this.onChanged,
  }) : super(key: key);

  final String hint;
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      maxLines: 5,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DesignSize.borderRadius),
        ),
        hintText: hint,
      ),
    );
  }
}
