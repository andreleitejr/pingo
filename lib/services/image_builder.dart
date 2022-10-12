import 'package:flutter/material.dart';
import 'package:pingo/repositories/database_repository.dart';
import 'package:pingo/repositories/storage_repository.dart';

class ImageBuilder extends StatelessWidget {
  ImageBuilder({Key? key, required this.imagePath}) : super(key: key);

  final String imagePath;
  final repository = StorageReporitory(name: 'places');

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: repository.download(imagePath),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data.toString());
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
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
