import 'package:flutter/material.dart';

class DesignSearchInput extends StatefulWidget {
  const DesignSearchInput({
    Key? key,
    this.hint,
  }) : super(key: key);

  final String? hint;

  @override
  State<DesignSearchInput> createState() => _DesignSearchInputState();
}

class _DesignSearchInputState extends State<DesignSearchInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
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
