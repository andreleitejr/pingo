import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pingo/constants/design_color.dart';
import 'package:pingo/constants/design_size.dart';
import 'package:pingo/features/event/models/event.dart';
import 'package:pingo/features/event/pages/list/event_list_controller.dart';
import 'package:pingo/features/event/pages/read/event_read_page.dart';
import 'package:pingo/widgets/design_appbar.dart';
import 'package:pingo/widgets/design_category_bullet_list.dart';
import 'package:pingo/widgets/design_event_best_match_item.dart';
import 'package:pingo/widgets/design_event_item.dart';
import 'package:pingo/widgets/design_event_list_tile.dart';
import 'package:pingo/widgets/design_search_input.dart';
import 'package:pingo/widgets/design_section_title.dart';
import 'package:pingo/widgets/design_space.dart';

// ignore: must_be_immutable
class EventListPage extends StatefulWidget {
  EventListPage({
    Key? key,
    required this.events,
    this.showLeading = true,
  }) : super(key: key);

  List<Event>? events;
  final bool showLeading;

  @override
  State<EventListPage> createState() => _EventListPageState();
}

class _EventListPageState extends State<EventListPage> {
  late EventListController controller;

  @override
  void initState() {
    controller = Get.put(EventListController(widget.events!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: DesignAppBar(
                showLeading: widget.showLeading,
                title: 'Eventos',
              ),
            ),
            SliverAppBar(
              primary: false,
              pinned: true,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              elevation: 0.4,
              shadowColor: DesignColor.text300.withOpacity(0.5),
              toolbarHeight: 48,
              title: DesignSearchInput(
                hint: 'Busque os melhores eventos',
                onChanged: controller.setSearch,
              ),
            ),
            SliverToBoxAdapter(
              child: Obx(
                () {
                  if (!controller.category.showAll ||
                      controller.search.value.isNotEmpty) {
                    return Container();
                  }
                  return const DesignSectionTitle(
                    title: 'Eventos com seu perfil',
                    padding: EdgeInsets.symmetric(
                        horizontal: DesignSize.mediumSpace),
                    actionTitle: '',
                  );
                },
              ),
            ),
            const SliverToBoxAdapter(
              child: DesignSpace(size: DesignSize.smallSpace),
            ),
            SliverToBoxAdapter(
              child: Obx(
                () {
                  if (!controller.category.showAll ||
                      controller.search.value.isNotEmpty) {
                    return Container();
                  }
                  return SizedBox(
                    height: 175,
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(
                          horizontal: DesignSize.mediumSpace),
                      itemCount: controller.bestMatch.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        final bestMatch = controller.bestMatch[index];
                        return DesignEventBestMatchItem(
                          bestMatch: bestMatch,
                          width: Get.width * 0.8,
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            SliverToBoxAdapter(
              child: Obx(
                () {
                  if (!controller.category.showAll ||
                      controller.search.value.isNotEmpty) {
                    return Container();
                  }
                  return const DesignSpace();
                },
              ),
            ),
            SliverToBoxAdapter(
              child: Obx(
                () => DesignCategoryBulletList(
                  categories: controller.categories,
                  value: controller.category.category.value,
                  onItemPressed: controller.category.setCategory,
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: DesignSpace(size: DesignSize.smallSpace),
            ),
            SliverToBoxAdapter(
              child: Obx(
                () {
                  if (!controller.category.showAll ||
                      controller.search.value.isNotEmpty) {
                    return Container();
                  }
                  return DesignSectionTitle(
                    title: 'Principais eventos na cidade',
                    onActionPressed: () => Get.to(
                      () => EventListPage(
                        events: controller.events,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: DesignSize.mediumSpace),
                    actionTitle: '',
                  );
                },
              ),
            ),
            SliverToBoxAdapter(
              child: Obx(
                () {
                  if (!controller.category.showAll ||
                      controller.search.value.isNotEmpty) {
                    return Container();
                  }
                  return SizedBox(
                    height: 184,
                    child: ListView.builder(
                      padding: const EdgeInsets.only(
                        left: DesignSize.mediumSpace,
                      ),
                      itemCount: controller.events.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DesignEventItem(
                              event: controller.events[index],
                            ),
                            const DesignSpace(
                              orientation: DesignSpaceOrientation.horizontal,
                            ),
                          ],
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            SliverToBoxAdapter(
              child: Obx(
                () {
                  if (!controller.category.showAll ||
                      controller.search.value.isNotEmpty) {
                    return Container();
                  }
                  return const DesignSpace();
                },
              ),
            ),
            const SliverToBoxAdapter(
              child: DesignSectionTitle(
                title: 'Eventos próximos',
                padding: EdgeInsets.symmetric(
                  horizontal: DesignSize.mediumSpace,
                ),
                actionTitle: '',
              ),
            ),
            const SliverToBoxAdapter(
                child: DesignSpace(size: DesignSize.smallSpace)),
            Obx(
              () => SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    final event = controller.bestMatch[index];

                    return DesignEventListTile(
                      event: event,
                      onPressed: () =>
                          Get.to(() => EventReadPage(event: event)),
                    );
                  },
                  childCount: controller.bestMatch.length, // 1000 list items
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
