import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pingo/constants/design_color.dart';
import 'package:pingo/constants/design_icons.dart';
import 'package:pingo/constants/design_text_style.dart';
import 'package:pingo/features/home/components/filter/filter_modal.dart';
import 'package:pingo/features/home/home_controller.dart';
import 'package:pingo/features/place/pages/edit/place_edit_page.dart';
import 'package:pingo/services/current_location.dart';
import 'package:pingo/services/current_weather.dart';
import 'package:pingo/widgets/design_icon_button.dart';
import 'package:pingo/widgets/design_shimmer_widget.dart';

class DesignHomeAppBar extends StatelessWidget {
  DesignHomeAppBar({Key? key}) : super(key: key);

  final HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildImage(),
              Expanded(
                child: _buildText(),
              ),
              _buildIcon(context),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    if (controller.loading.value) {
      return DesignShimmerWidget(
        child: Container(
          height: 32,
          width: 32,
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: DesignColor.text200,
            borderRadius: BorderRadius.circular(64),
          ),
        ),
      );
    } else {
      return GestureDetector(
        onTap: () => Get.to(PlaceEditPage()),
        child: SizedBox(
          height: 64,
          width: 64,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(64),
            child: Image.network(
              controller.icon.value,
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    }
  }

  Widget _buildText() {
    if (controller.loading.value) {
      return DesignShimmerWidget(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 100,
              height: 12,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 4),
            Container(
              width: double.infinity,
              height: 16,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ],
        ),
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(
                    () => Text(
                      controller.temperature.toString(),
                      style: DesignTextStyle.labelSmall10.apply(
                        color: DesignColor.text400,
                      ),
                    ),
                  ),
                  Text(
                    '°C',
                    style: DesignTextStyle.labelSmall8.apply(
                      color: DesignColor.text400,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 4),
              Center(
                child: Container(
                  width: 3,
                  height: 3,
                  decoration: BoxDecoration(
                    color: DesignColor.text300,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              const SizedBox(width: 4),
              Text(
                DateFormat.EEEE().format(DateTime.now()),
                style: DesignTextStyle.labelSmall10.apply(
                  color: DesignColor.text400,
                ),
              ),
            ],
          ),
          Obx(
            () => Text(
              controller.address.value,
              style: DesignTextStyle.bodySmall12.apply(
                color: DesignColor.text500,
              ),
            ),
          ),
        ],
      );
    }
  }

  Widget _buildIcon(BuildContext context) {
    if (controller.loading.value) {
      return DesignShimmerWidget(
        child: Container(
          height: 32,
          width: 32,
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: DesignColor.text200,
            borderRadius: BorderRadius.circular(64),
          ),
        ),
      );
    } else {
      return DesignIconButton(
        icon: DesignIcons.filter,
        onPressed: () {
          showModalBottomSheet<void>(
            isScrollControlled: true,
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            backgroundColor: Colors.white,
            builder: (BuildContext context) {
              return FilterModal();
            },
          );
        },
      );
    }
  }
}
