import 'package:custom_map_markers/custom_map_markers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pingo/constants/design_color.dart';
import 'package:pingo/models/user.dart';

class DesignUserMarker extends StatelessWidget {
  DesignUserMarker({Key? key}) : super(key: key);

  final User user = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 54),
      height: 36,
      width: 36,
      decoration: BoxDecoration(
        image: user.image != null
            ? DecorationImage(
            image: NetworkImage(user.image!.image),
            fit: BoxFit.cover)
            : null,
        color: DesignColor.primary500,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.white,
          width: 4,
        ),
      ),
    );
  }
}
