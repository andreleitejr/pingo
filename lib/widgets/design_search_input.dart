import 'package:flutter/material.dart';
import 'package:pingo/constants/design_size.dart';

class DesignSearchInput extends StatefulWidget {
  const DesignSearchInput({
    Key? key,
    this.value,
    this.hint,
    this.onChanged,
    this.onFilter,
    this.autoFocus = false,
  }) : super(key: key);

  final String? value;
  final String? hint;
  final Function(String)? onChanged;
  final Function()? onFilter;
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
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(
            top: DesignSize.smallSpace,
            left: DesignSize.mediumSpace,
          ),
          border: const OutlineInputBorder(),
          hintText: widget.hint,
          suffixIcon: GestureDetector(
            onTap: widget.onFilter,
            child: const Icon(Icons.filter_list),
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
