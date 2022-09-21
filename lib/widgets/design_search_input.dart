import 'package:flutter/material.dart';
import 'package:pingo/constants/design_size.dart';

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
      height: 40,
      child: TextFormField(
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(
            top: DesignSize.smallSpace,
            left: DesignSize.mediumSpace,
          ),
          border: const OutlineInputBorder(),
          hintText: widget.hint,
          suffixIcon: Icon(Icons.filter_list)
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
