import 'package:flutter/material.dart';
import 'package:pingo/constants/design_size.dart';
import 'package:pingo/core/extensions.dart';
import 'package:pingo/features/place/models/place.dart';
import 'package:pingo/widgets/design_appbar.dart';
import 'package:pingo/widgets/design_list_tile.dart';

class PlaceListPage extends StatelessWidget {
  const PlaceListPage({
    Key? key,
    required this.title,
    required this.places,
  }) : super(key: key);

  final String title;
  final List<Place> places;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(DesignSize.appBarHeight),
        child: DesignAppBar(
          title: title,
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: ListView.builder(
        itemCount: places.length,
        itemBuilder: (BuildContext context, int index) {
          final place = places[index];

          return DesignListTile(
            image: place.image,
            title: place.name,
            subtitle: place.description,
            trailing: place.distance.metricSystem,
          );
        },
      ),
    );
  }
}
