import 'dart:io';
import 'package:blurhash/blurhash.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:pingo/models/image_blurhash.dart';
import 'package:pingo/repositories/storage_repository.dart';

class BlurHashController {
  Future<String> encode(File file) async {
    Uint8List pixels = await file.readAsBytes();
    final blurHash = await BlurHash.encode(pixels, 4, 3);
    return blurHash;
  }

  Future<File?> decode(String blurHash) async {
    Uint8List imageDataBytes;
    try {
      imageDataBytes = await BlurHash.decode(blurHash, 20, 12);
      final file = File.fromRawPath(imageDataBytes);
      return file;
    } on PlatformException catch (e) {
      debugPrint(e.message);
      return null;
    }
  }

  Future<ImageBlurHash?> buildImageBlurHash(
      File file, String repositoryName) async {
    final blurHash = await encode(file);
    final url = await uploadAndGetUrl(file, repositoryName);
    if (blurHash.isNotEmpty && url != null && url.isNotEmpty) {
      return ImageBlurHash(image: url, blurHash: blurHash);
    }
    return null;
  }

  Future<String?> uploadAndGetUrl(File file, String repositoryName) async {
    final repository = StorageRepository(name: repositoryName);

    await repository.upload(file);
    final downloadUrl = await repository.download(basename(file.path));
    return downloadUrl;
  }
}
