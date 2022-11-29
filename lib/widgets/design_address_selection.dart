import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:flutter/material.dart';
import 'package:pingo/constants/design_color.dart';
import 'package:pingo/constants/design_text_style.dart';

class DesignAddressSelection extends StatefulWidget {
  const DesignAddressSelection({
    Key? key,
    required this.country,
    required this.onCountryChanged,
    required this.state,
    required this.onStateChanged,
    required this.city,
    required this.onCityChanged,
  }) : super(key: key);

  final String country;
  final Function(String) onCountryChanged;

  final String state;
  final Function(String?) onStateChanged;
  final String city;
  final Function(String?) onCityChanged;

  @override
  State<DesignAddressSelection> createState() => _DesignAddressSelectionState();
}

class _DesignAddressSelectionState extends State<DesignAddressSelection> {
  String countryValue = "";
  String stateValue = "";
  String cityValue = "";
  String address = "";

  @override
  Widget build(BuildContext context) {
    return Center(
      child:  SelectState(
        onCountryChanged: widget.onCountryChanged,
        onStateChanged: widget.onStateChanged,
        onCityChanged: widget.onCityChanged,
        style: DesignTextStyle.bodySmall12Bold
            .apply(color: DesignColor.text400),
      ),
    );
  }
}
