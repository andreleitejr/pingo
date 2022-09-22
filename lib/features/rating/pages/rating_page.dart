import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pingo/constants/design_color.dart';
import 'package:pingo/constants/design_size.dart';
import 'package:pingo/features/rating/pages/rating_controller.dart';
import 'package:pingo/features/rating/services/nps_color.dart';
import 'package:pingo/widgets/design_appbar.dart';
import 'package:pingo/widgets/design_button.dart';
import 'package:pingo/widgets/design_space.dart';
import 'package:pingo/widgets/design_text_area.dart';
import 'package:pingo/widgets/design_title_with_subtitle.dart';

class RatingPage extends StatefulWidget {
  const RatingPage({Key? key, required this.ratedId}) : super(key: key);

  final String ratedId;

  @override
  State<RatingPage> createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  late RatingController controller;

  @override
  void initState() {
    controller = Get.put(RatingController(widget.ratedId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(DesignSize.appBarHeight),
        child: DesignAppBar(
          title: 'Rating',
          showLeading: false,
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const DesignTitleWithSubtitle(
            title: 'Rating',
            subtitle:
                'From 0 to 10, what probability you indicate this place to a friend?',
          ),
          const DesignSpace(),
          Container(
            padding: const EdgeInsets.all(DesignSize.mediumSpace),
            height: 68,
            width: double.infinity,
            child: Wrap(
              children: [
                for (var i = 1; i <= 10; i++) ...[
                  Obx(() {
                    final isSelected = i == controller.nps.value;

                    return GestureDetector(
                      onTap: () => controller.setNps(i),
                      child: Container(
                        height: (Get.width - 32) * 0.1,
                        width: (Get.width - 32) * 0.1,
                        padding: EdgeInsets.all(isSelected ? 0 : 4),
                        child: Container(
                          decoration: BoxDecoration(
                              color: i > controller.nps.value
                                  ? DesignColor.text300
                                  : NpsColor.get(i),
                              borderRadius: BorderRadius.circular(50)),
                          alignment: Alignment.center,
                          child: Text(i.toString()),
                        ),
                      ),
                    );
                  }),
                ],
              ],
            ),
          ),
          const DesignSpace(),
          DesignTextArea(
            hint: 'Diga o que pensa desse lugar...',
            onChanged: controller.setMessage,
          ),
          Expanded(child: Container()),
          SizedBox(
            height: DesignSize.buttonHeight,
            child: DesignButton(
              onPressed: () async => await controller.save().then((_) => Get.back()),
              title: 'Sign In',
              isActive: true,
              // isActive: controller.isAuthFormValid,
            ),
          ),
          const DesignSpace(),
        ],
      ),
    );
  }
}
