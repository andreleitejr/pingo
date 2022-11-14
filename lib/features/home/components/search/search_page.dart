import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pingo/constants/design_icons.dart';
import 'package:pingo/constants/design_size.dart';
import 'package:pingo/core/extensions.dart';
import 'package:pingo/features/home/home_controller.dart';
import 'package:pingo/widgets/design_category_bullet_list.dart';
import 'package:pingo/widgets/design_icon_button.dart';
import 'package:pingo/widgets/design_list_tile.dart';
import 'package:pingo/widgets/design_search_input.dart';
import 'package:pingo/widgets/design_space.dart';

class SearchPage extends StatelessWidget {
  SearchPage({
    Key? key,
  }) : super(key: key);

  final HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(DesignSize.appBarHeight),
          child: SizedBox(
            height: 100,
            width: double.infinity,
            child: Row(
              children: [
                const DesignSpace(
                  orientation: DesignSpaceOrientation.horizontal,
                ),
                Expanded(
                  child: DesignSearchInput(
                    autoFocus: true,
                    value: controller.search.text.value,
                    hint: 'Search the best around you ',
                    onChanged: controller.search.setSearch,
                  ),
                ),
                DesignIconButton(
                  icon: DesignIcons.close,
                  height: 14,
                  width: 14,
                  alignment: Alignment.center,
                  onPressed: () => controller.search.closeSearch(),
                ),
              ],
            ),
          ),
        ),
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Obx(
              () => DesignCategoryBulletList(
                value: controller.category.category.value,
                onItemPressed: controller.category.setCategory,
              ),
            ),
            const DesignSpace(),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: controller.places.length,
                  itemBuilder: (BuildContext context, int index) {
                    final place = controller.places[index];

                    return DesignListTile(
                      image: place.image,
                      title: place.name,
                      subtitle: place.description,
                      trailing: place.distance.metricSystem,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
