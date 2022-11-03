// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class DesignLazyWidget extends StatefulWidget {
//   DesignLazyWidget(
//       {Key? key,
//       required this.widget,
//       this.isLoading = true,
//       required this.globalKey})
//       : super(key: key);
//
//   final Widget widget;
//   final bool isLoading;
//   final GlobalKey globalKey;
//
//   @override
//   State<DesignLazyWidget> createState() => _DesignLazyWidgetState();
// }
//
// class _DesignLazyWidgetState extends State<DesignLazyWidget> {
//   final _size = 0.toDouble();
//   final _globalKey = GlobalKey();
//
//   @override
//   void initState() {
//     super.initState();
//
//     WidgetsBinding.instance.addPostFrameCallback(_getWidgetInfo);
//   }
//
//   Future<void> _getWidgetInfo(Duration duration) async {
//     await Future.delayed(duration);
//     final RenderBox renderBox =
//         widget.globalKey.currentContext?.findRenderObject() as RenderBox;
//
//     widget.globalKey.currentContext?.size;
//
//     final Size size = renderBox.size;
//
//     print('Size: ${size.width}, ${size.height}');
//
//     final Offset offset = renderBox.localToGlobal(Offset.zero);
//
//     print('Offset: ${offset.dx}, ${offset.dy}');
//
//     print(
//         'Position: ${(offset.dx + size.width) / 2}, ${(offset.dy + size.height) / 2}');
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: FutureBuilder(
//         future: _getWidgetInfo(const Duration(seconds: 4)),
//         builder: (BuildContext context, _) {
//           return Container(
//             key: widget.widget.key,
//             width: _size,
//             height: _size,
//             color: Colors.teal,
//             child: widget.widget,
//           );
//         },
//       ),
//     );
//   }
// }
