import 'package:flutter/material.dart';
import 'package:pingo/repositories/storage_repository.dart';

class ImageBuilder extends StatelessWidget {
  ImageBuilder({Key? key, required this.imagePath}) : super(key: key);

  final String imagePath;
  final repository = StorageRepository(name: 'places');

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: repository.download(imagePath),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  snapshot.data.toString(),
                ),
              ),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
