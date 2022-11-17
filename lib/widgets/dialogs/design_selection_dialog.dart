import 'package:flutter/material.dart';

// ignore: depend_on_referenced_packages
import 'package:get/get.dart';
import 'package:pingo/models/selectable.dart';
import 'package:pingo/widgets/design_text_input.dart';

class DesignSelectionInput<T extends Selectable?> extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showSelectionDialog(context),
      child: Stack(
        children: [
          DesignTextInput(
            hint: hint,
            isValid: isValid,
            textEditingController: TextEditingController(
              text: value?.text,
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
    final filtered =
        items.where((i) => i!.text.isNotEmpty && i.enabled).toList();

    final T? result = await showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      builder: (_) => Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(16, 16, 16, 6),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(16)),
            child: ListView.builder(
              itemCount: filtered.length,
              shrinkWrap: true,
              itemBuilder: (context, i) {
                return TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(filtered[i]);
                  },
                  child: Text(
                    filtered[i]?.text ?? 'Nao encontrado',
                  ),
                );
              },
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
              child: Text('Cancelar'),
            ),
          ),
        ],
      ),
    );
    if (result != null) onChanged(result);
  }
}
