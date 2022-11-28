import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pingo/features/event/models/event.dart';
import 'package:pingo/features/event/pages/read/event_read_page.dart';
import 'package:pingo/widgets/design_event_list_tile.dart';

class EventListFragment extends StatelessWidget {
  const EventListFragment({Key? key, required this.events}) : super(key: key);

  final List<Event> events;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: events.length,
      itemBuilder: (BuildContext context, int index) {
        final event = events[index];

        return GestureDetector(
          onTap: () => Get.to(() => EventReadPage(event: event)),
          child: DesignEventListTile(
            event: event,
          ),
        );
      },
    );
  }
}
