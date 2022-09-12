import 'package:flutter/material.dart';
import 'package:pingo/constants/design_size.dart';

class DesignVerticalSpace extends StatelessWidget {
  const DesignVerticalSpace({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(height: DesignSize.mediumSpace);
  }
}
