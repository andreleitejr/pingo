import 'package:flutter/material.dart';

class DesignProgressIndicator extends StatelessWidget {
  const DesignProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
