import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pingo/constants/design_color.dart';
import 'package:pingo/constants/design_text_style.dart';
import 'package:pingo/core/extensions.dart';
import 'package:pingo/models/selectable.dart';
import 'package:pingo/widgets/design_search_input.dart';
import 'package:pingo/widgets/design_text_input.dart';

class DesignSelectionInput<T extends Selectable?> extends StatefulWidget {
  const DesignSelectionInput({
    Key? key,
    this.value,
    required this.hint,
    required this.items,
    required this.onChanged,
    this.isValid = false,
  }) : super(key: key);

  final T? value;
  final String hint;
  final List<T> items;
  final Function(T?) onChanged;
  final bool isValid;

  @override
  State<DesignSelectionInput<T>> createState() =>
      _DesignSelectionInputState<T>();
}

class _DesignSelectionInputState<T extends Selectable?>
    extends State<DesignSelectionInput<T>> {
  final controller = SearchController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showSelectionDialog(context),
      child: Stack(
        children: [
          DesignTextInput(
            hint: widget.hint,
            isValid: widget.isValid,
            textEditingController: TextEditingController(
              text: widget.value?.text,
            ),
          ),
          Container(
            height: 42,
            width: double.infinity,
            color: Colors.green.withOpacity(0),
          )
        ],
      ),
    );
  }

  Future<void> showSelectionDialog(BuildContext context) async {
    final T? result = await showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      builder: (_) => Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.fromLTRB(16, 16, 16, 6),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16)),
                child: Column(
                  children: [
                    DesignSearchInput(
                      hint: 'Search',
                      onChanged: controller.setSearch,
                    ),
                    Expanded(
                      child: Obx(
                        () {
                          List<T> list = widget.items;
                          if (controller.search.value.isNotEmpty) {
                            list = list
                                .where((t) =>
                                    t != null &&
                                    t.text.clean.contains(
                                        controller.search.value.clean))
                                .toList();
                          }
                          return ListView.builder(
                            itemCount: list.length,
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            itemBuilder: (context, i) {
                              return Column(
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(list[i]);
                                    },
                                    child: Text(
                                      list[i]?.text ?? 'Nao encontrado',
                                      style: DesignTextStyle.bodySmall12Bold
                                          .apply(color: DesignColor.text400),
                                    ),
                                  ),
                                  if (list[i] != list.last)
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Container(
                                        color: DesignColor.text200
                                            .withOpacity(0.2),
                                        height: 0.75,
                                        width: double.infinity,
                                      ),
                                    ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(16, 6, 16, 16),
              width: double.infinity,
              alignment: Alignment.center,
              height: 42,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(16)),
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Cancelar',
                  style: DesignTextStyle.bodySmall12Bold
                      .apply(color: DesignColor.red),
                ),
              ),
            ),
          ],
        ),
      ),
    );
    if (result != null) widget.onChanged(result);
  }
}

class SearchController extends GetxController {
  var search = ''.obs;

  void setSearch(String v) => search(v);
}
