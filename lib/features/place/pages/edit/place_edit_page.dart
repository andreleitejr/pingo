import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pingo/constants/design_size.dart';
import 'package:pingo/core/keyword.dart';
import 'package:pingo/features/place/pages/edit/place_edit_controller.dart';
import 'package:pingo/widgets/design_appbar.dart';
import 'package:pingo/widgets/design_button.dart';
import 'package:pingo/features/keyword/pages/keyword_selection_page.dart';
import 'package:pingo/widgets/design_keyword_selection_box.dart';
import 'package:pingo/widgets/design_text_input.dart';

import '../../../../widgets/design_space.dart';

class PlaceEditPage extends StatelessWidget {
  PlaceEditPage({Key? key}) : super(key: key);

  final controller = PlaceEditController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(DesignSize.appBarHeight),
        child: DesignAppBar(
          title: 'Create Place',
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(DesignSize.padding),
        child: ListView(
          children: [
            Obx(
              () => DesignTextInput(
                hint: 'Name',
                onChanged: controller.setName,
                isValid: controller.nameValid,
              ),
            ),
            const DesignSpace(),
            Obx(
              () => DesignTextInput(
                hint: 'Description',
                onChanged: controller.setDescription,
                isValid: controller.descriptionValid,
              ),
            ),
            const DesignSpace(),
            Obx(
              () => DesignTextInput(
                textInputType: TextInputType.emailAddress,
                hint: 'E-mail',
                onChanged: controller.setEmail,
                isValid: controller.emailValid,
              ),
            ),
            const DesignSpace(),
            DesignTextInput(
              hint: 'Image',
              onChanged: controller.setImage,
            ),
            // const DesignSpace(),
            // SizedBox(
            //   height: 54,
            //   child: Row(
            //     children: [
            //       Expanded(
            //         child: DesignTextInput(
            //           textInputType: TextInputType.number,
            //           hint: 'Open Hour',
            //           onChanged: controller.setOpenHour,
            //         ),
            //       ),
            //       const DesignSpace(
            //         orientation: DesignSpaceOrientation.horizontal,
            //       ),
            //       Expanded(
            //         child: DesignTextInput(
            //           textInputType: TextInputType.number,
            //           hint: 'Open Minute',
            //           onChanged: controller.setOpenHour,
            //         ),
            //       )
            //     ],
            //   ),
            // ),
            // const DesignSpace(),
            // SizedBox(
            //   height: 54,
            //   child: Row(
            //     children: [
            //       Expanded(
            //         child: DesignTextInput(
            //           textInputType: TextInputType.number,
            //           hint: 'Close Hour',
            //           onChanged: controller.setCloseHour,
            //         ),
            //       ),
            //       const DesignSpace(
            //         orientation: DesignSpaceOrientation.horizontal,
            //       ),
            //       Expanded(
            //         child: DesignTextInput(
            //           textInputType: TextInputType.number,
            //           hint: 'Close Minute',
            //           onChanged: controller.setCloseMinute,
            //         ),
            //       )
            //     ],
            //   ),
            // ),
            const DesignSpace(),
            SizedBox(
              height: 54,
              child: Row(
                children: [
                  Expanded(
                    child: DesignTextInput(
                      textInputType: TextInputType.number,
                      hint: 'Latitude',
                      onChanged: controller.setLatitude,
                    ),
                  ),
                  const DesignSpace(
                    orientation: DesignSpaceOrientation.horizontal,
                  ),
                  Expanded(
                    child: DesignTextInput(
                      textInputType: TextInputType.number,
                      hint: 'Longitude',
                      onChanged: controller.setLongitude,
                    ),
                  )
                ],
              ),
            ),
            const DesignSpace(),
            Obx(
              () => DesignButton(
                onPressed: () async {
                  if (controller.isValid) {
                    await controller.save().then(
                          (value) => Get.back(),
                        );
                  }
                },
                title: 'Save',
                isActive: controller.isValid,
              ),
            ),
            const DesignSpace(),
            DesignKeywordSelectionBox(
              title: 'Select Category',
              list: places,
              keywords: controller.categories,
              onKeywordSelected: controller.addCategory,
              isValid: true,
            ),
            const DesignSpace(),
            DesignKeywordSelectionBox(
              title: 'Select Keywords',
              list: foods + musics + miscellaneous,
              keywords: controller.miscellaneous,
              onKeywordSelected: controller.addMiscellaneous,
              isValid: true,
            ),
          ],
        ),
      ),
    );
  }
}
