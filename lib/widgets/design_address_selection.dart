import 'dart:ffi';

import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';

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
    GlobalKey<CSCPickerState> _cscPickerKey = GlobalKey();

    return Center(
      key: _cscPickerKey,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        height: 600,
        child: Column(
          children: [
            ///Adding CSC Picker Widget in app
            CSCPicker(
              ///Enable disable state dropdown [OPTIONAL PARAMETER]
              showStates: true,

              /// Enable disable city drop down [OPTIONAL PARAMETER]
              showCities: true,

              ///Enable (get flag with country name) / Disable (Disable flag) / ShowInDropdownOnly (display flag in dropdown only) [OPTIONAL PARAMETER]
              flagState: CountryFlag.DISABLE,

              ///Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER] (USE with disabledDropdownDecoration)
              dropdownDecoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade300, width: 1)),

              ///Disabled Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER]  (USE with disabled dropdownDecoration)
              disabledDropdownDecoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.grey.shade300,
                  border: Border.all(color: Colors.grey.shade300, width: 1)),

              ///placeholders for dropdown search field
              countrySearchPlaceholder: "Country",
              stateSearchPlaceholder: "State",
              citySearchPlaceholder: "City",

              ///labels for dropdown
              countryDropdownLabel: "*Country",
              stateDropdownLabel: "*State",
              cityDropdownLabel: "*City",

              ///Default Country
              //defaultCountry: DefaultCountry.India,

              ///Disable country dropdown (Note: use it with default country)
              //disableCountry: true,

              ///selected item style [OPTIONAL PARAMETER]
              selectedItemStyle: TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),

              ///DropdownDialog Heading style [OPTIONAL PARAMETER]
              dropdownHeadingStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.bold),

              ///DropdownDialog Item style [OPTIONAL PARAMETER]
              dropdownItemStyle: TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),

              ///Dialog box radius [OPTIONAL PARAMETER]
              dropdownDialogRadius: 10.0,

              ///Search bar radius [OPTIONAL PARAMETER]
              searchBarRadius: 10.0,
              onCountryChanged: (value) {
                setState(() {
                  ///store value in country variable
                  countryValue = value;
                });
                // widget.onCountryChanged(value);
              },

              ///triggers once state selected in dropdown
              onStateChanged: (value) {
                // widget.onStateChanged(value);
                setState(() {
                  ///store value in state variable
                  if(value != null) stateValue = value;
                });
              },

              ///triggers once city selected in dropdown
              onCityChanged: (value) {
                // widget.onCityChanged(value);
                setState(() {
                  ///store value in city variable
                  if(value != null) cityValue = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
