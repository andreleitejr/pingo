import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pingo/constants/design_size.dart';
import 'package:pingo/core/extensions.dart';
import 'package:pingo/features/place/models/place.dart';
import 'package:pingo/features/place/pages/read/place_read_page.dart';
import 'package:pingo/widgets/design_appbar.dart';
import 'package:pingo/widgets/design_list_tile.dart';

class PlaceListPage extends StatelessWidget {
  const PlaceListPage({
    Key? key,
    this.title,
    required this.places,
    this.showLeading = true,
  }) : super(key: key);

  final String? title;
  final List<Place> places;
  final bool showLeading;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(DesignSize.appBarHeight),
        child: DesignAppBar(
          showLeading: showLeading,
          title: title ?? 'Places',
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: ListView.builder(
        itemCount: places.length,
        itemBuilder: (BuildContext context, int index) {
          final place = places[index];

          return GestureDetector(
            onTap: ()=> Get.to(()=> PlaceReadPage(place: place)),
            child: DesignListTile(
              image: place.image,
              title: place.name,
              subtitle: place.description,
              trailing: place.distance.metricSystem,
            ),
          );
        },
      ),
    );
  }
}
