class ImageBlurHash {
  final String image;
  final String blurHash;

  ImageBlurHash({required this.image, required this.blurHash});

  ImageBlurHash.fromJson(Map<String, dynamic> json)
      : image = json['image'],
        blurHash = json['blurHash'];

  Map<String, dynamic> toJson() => {'image': image, 'blurHash': blurHash};
}
