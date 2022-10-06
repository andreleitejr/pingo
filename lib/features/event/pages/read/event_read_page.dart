import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pingo/constants/design_size.dart';
import 'package:pingo/core/extensions.dart';
import 'package:pingo/features/event/models/event.dart';
import 'package:pingo/features/rating/pages/rating_page.dart';
import 'package:pingo/widgets/design_appbar.dart';
import 'package:pingo/widgets/design_button.dart';
import 'package:pingo/widgets/design_read_image.dart';

class EventReadPage extends StatefulWidget {
  const EventReadPage({Key? key, required this.event}) : super(key: key);

  final Event event;

  @override
  State<EventReadPage> createState() => _EventReadPageState();
}

class _EventReadPageState extends State<EventReadPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(DesignSize.appBarHeight),
        child: DesignAppBar(
          title: widget.event.name,
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DesignAvatarImage(image: widget.event.image),
          Text(widget.event.name),
          Text(widget.event.distance.metricSystem),
          if (widget.event.description != null) Text(widget.event.description!),
          DesignButton(
            onPressed: () => Get.to(RatingPage(ratedId: widget.event.uuid)),
            title: 'Avaliar',
          )
        ],
      ),
    );
  }
}
