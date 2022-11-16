import 'package:flutter/material.dart';
import 'package:pingo/constants/design_color.dart';
import 'package:pingo/constants/design_icons.dart';
import 'package:pingo/constants/design_size.dart';
import 'package:pingo/constants/design_text_style.dart';
import 'package:pingo/widgets/design_icon.dart';
import 'package:pingo/widgets/design_shimmer_widget.dart';

class DesignSearchInput extends StatefulWidget {
  const DesignSearchInput({
    Key? key,
    this.value,
    this.hint,
    this.onChanged,
    this.autoFocus = false,
    this.isLoading = false,
  }) : super(key: key);

  final String? value;
  final String? hint;
  final Function(String)? onChanged;
  final bool autoFocus;
  final bool isLoading;

  @override
  State<DesignSearchInput> createState() => _DesignSearchInputState();
}

class _DesignSearchInputState extends State<DesignSearchInput> {
  @override
  Widget build(BuildContext context) {
    if (widget.isLoading) {
      return DesignShimmerWidget(
        child: Container(
          height: 40,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(40),
          ),
        ),
      );
    }
    return SizedBox(
      height: 40,
      child: TextFormField(
        autofocus: widget.autoFocus,
        initialValue: widget.value,
        onChanged: widget.onChanged,
        style:
            DesignTextStyle.bodySmall12Bold.apply(color: DesignColor.text400),
        decoration: InputDecoration(
          prefixIcon: const Padding(
            padding: EdgeInsets.all(DesignSize.mediumSpace),
            child: Opacity(
              opacity: 0.25,
              child: DesignIcon(
                icon: DesignIcons.search,
                width: 12,
                height: 12,
              ),
            ),
          ),
          hintStyle:
              DesignTextStyle.bodySmall12.apply(color: DesignColor.text300),
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
