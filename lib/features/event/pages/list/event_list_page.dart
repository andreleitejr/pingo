import 'package:flutter/material.dart';
import 'package:pingo/constants/design_size.dart';
import 'package:pingo/features/event/models/event.dart';
import 'package:pingo/features/event/pages/list/event_list_fragment.dart';
import 'package:pingo/widgets/design_appbar.dart';

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
      body: EventListFragment(events: events),
    );
  }
}
