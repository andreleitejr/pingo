import 'package:custom_map_markers/custom_map_markers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pingo/constants/design_color.dart';

import 'package:flutter/services.dart' show rootBundle;
import 'package:pingo/features/place/models/place.dart';
import 'package:pingo/services/map_controller.dart';
import 'package:pingo/widgets/design_destination_marker.dart';
import 'package:pingo/widgets/design_user_marker.dart';

class DesignMap extends StatefulWidget {
  const DesignMap({
    Key? key,
    required this.place,
  }) : super(key: key);

  final Place place;

  @override
  State<DesignMap> createState() => _DesignMapState();
}

class _DesignMapState extends State<DesignMap> {
  late MapController controller;
  late String _mapStyle;

  @override
  void initState() {
    controller = Get.put(MapController(widget.place));
    super.initState();

    rootBundle.loadString('assets/map/style.txt').then((string) {
      _mapStyle = string;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomGoogleMapMarkerBuilder(
      customMarkers: [
        MarkerData(
          marker: controller.placeMarker,
          child: DesignDestionationMarker(
            image: controller.place.image!.image,
          ),
        ),
        MarkerData(
          marker: controller.userMarker,
          child: DesignUserMarker(),
        ),
      ],
      builder: (BuildContext context, Set<Marker>? markers) {
        if (markers == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return Container(
          color: DesignColor.text200,
          alignment: Alignment.center,
          child: GoogleMap(
            initialCameraPosition: controller.placePosition,
            onMapCreated: (GoogleMapController mapController) {
              mapController = mapController;
              mapController.setMapStyle(_mapStyle);
            },
            markers: markers,
          ),
        );
      },
    );
  }
}
