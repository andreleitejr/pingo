// import 'package:flutter/material.dart';
// import 'package:flutter_blurhash/flutter_blurhash.dart';
// import 'package:pingo/constants/design_color.dart';
// import 'package:pingo/widgets/design_shimmer_widget.dart';
//
// class DesignAvatarImage extends StatelessWidget {
//   const DesignAvatarImage({
//     Key? key,
//     required this.image,
//     this.blurHash,
//     this.isLoading = false,
//   }) : super(key: key);
//
//   final String? image;
//   final String? blurHash;
//   final bool isLoading;
//
//   @override
//   Widget build(BuildContext context) {
//     if (isLoading || image == null) {
//       return DesignShimmerWidget(
//         child: Container(
//           height: 24,
//           width: 24,
//           decoration: BoxDecoration(
//             color: Colors.black,
//             borderRadius: BorderRadius.circular(24),
//           ),
//         ),
//       );
//     }
//     return SizedBox(
//       width: 24,
//       height: 24,
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(12),
//         child: BlurHash(
//           imageFit: BoxFit.cover,
//           image: image,
//           hash: blurHash ?? 'LEHLk~WB2yk8pyo0adR*.7kCMdnj',
//         ),
//       ),
//     );
//   }
// }
