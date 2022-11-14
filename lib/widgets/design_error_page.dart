import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pingo/constants/design_images.dart';

class DesignErrorPage extends StatelessWidget {
  const DesignErrorPage({
    Key? key,
    required this.title,
    required this.description,
    required this.image,
    required this.onPressed,
  }) : super(key: key);

  final String title;
  final String description;
  final String image;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Container(
          //   width: Get.width * 0.8,
          //   height: Get.width * 0.8,
          //   decoration: BoxDecoration(
          //     image: DecorationImage(
          //       image: NetworkImage(image),
          //     ),
          //   ),
          // ),
          Text(title),
          Text(description),
          TextButton(
            onPressed: onPressed,
            child: const Text('Ir para as configurações'),
          ),
        ],
      ),
    );
  }
}
