import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pingo/constants/design_size.dart';
import 'package:pingo/core/extensions.dart';
import 'package:pingo/features/place/models/place.dart';
import 'package:pingo/features/rating/pages/rating_page.dart';
import 'package:pingo/widgets/design_appbar.dart';
import 'package:pingo/widgets/design_button.dart';
import 'package:pingo/widgets/design_read_image.dart';

class PlaceReadPage extends StatefulWidget {
  const PlaceReadPage({Key? key, required this.place}) : super(key: key);

  final Place place;

  @override
  State<PlaceReadPage> createState() => _PlaceReadPageState();
}

class _PlaceReadPageState extends State<PlaceReadPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(DesignSize.appBarHeight),
        child: DesignAppBar(
          title: widget.place.name,
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DesignReadImage(image: widget.place.image),
          Text(widget.place.name),
          Text(widget.place.distance.metricSystem),
          if (widget.place.description != null) Text(widget.place.description!),
          DesignButton(
            onPressed: () => Get.to(RatingPage(ratedId: widget.place.uuid)),
            title: 'Avaliar',
          )
        ],
      ),
    );
  }
}
