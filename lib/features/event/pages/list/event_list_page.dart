import 'package:flutter/material.dart';
import 'package:pingo/constants/design_size.dart';
import 'package:pingo/core/extensions.dart';
import 'package:pingo/features/event/models/event.dart';
import 'package:pingo/widgets/design_appbar.dart';
import 'package:pingo/widgets/design_list_tile.dart';

class EventListPage extends StatelessWidget {
  const EventListPage({
    Key? key,
    this.title,
    required this.events,
    this.showLeading = true,
  }) : super(key: key);

  final String? title;
  final List<Event> events;
  final bool showLeading;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(DesignSize.appBarHeight),
        child: DesignAppBar(
          showLeading: showLeading,
          title: title ?? 'Events',
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: ListView.builder(
        itemCount: events.length,
        itemBuilder: (BuildContext context, int index) {
          final place = events[index];

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
