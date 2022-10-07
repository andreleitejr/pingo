import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pingo/constants/design_color.dart';

import 'package:flutter/services.dart' show rootBundle;

class DesignMap extends StatefulWidget {
  const DesignMap({Key? key, required this.position, required this.completer, required this.markers})
      : super(key: key);

  final CameraPosition position;
  final Completer<GoogleMapController> completer;
  final Map<MarkerId, Marker> markers;

  @override
  State<DesignMap> createState() => _DesignMapState();
}

class _DesignMapState extends State<DesignMap> {
  late String _mapStyle;

  @override
  void initState() {
    super.initState();

    rootBundle.loadString('assets/map/style.txt').then((string) {
      _mapStyle = string;
    });
  }

  @override
  Widget build(BuildContext context) {
    GoogleMapController controller;
    return Container(
      color: DesignColor.text200,
      alignment: Alignment.center,
      child: GoogleMap(
        initialCameraPosition: widget.position,
        onMapCreated: (GoogleMapController mapController) {
          controller = mapController;
          // widget.completer.complete(mapController);
          controller.setMapStyle(_mapStyle);
        },
        markers: widget.markers.values.toSet(),
      ),
    );
  }
}
