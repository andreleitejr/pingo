import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class StorageReporitory {
  StorageReporitory({
    required this.name,
  });

  final String name;
  final storage = FirebaseStorage.instance;

  final reference = FirebaseStorage.instance.ref();

  Future upload(File image) async {
    final fileName = basename(image.path);

    try {
      final ref = storage.ref(name).child(fileName);
      await ref.putFile(image);
    } catch (e) {
      print('error occured');
    }
  }

  Future<String?> download(String fileName) async {
    try {
      final path = "$name/$fileName";

      final imageUrl = await reference.child(path).getDownloadURL();
      return imageUrl;
    } catch (e) {
      print('error occured');
      return null;
    }
  }
}
