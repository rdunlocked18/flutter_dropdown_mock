import 'package:flutter/material.dart';
import 'package:flutter_dropdown_mock/core/utils/constants.dart';
import 'package:flutter_dropdown_mock/features/home/data/models/place.dart';

class CommonDropdown extends StatelessWidget {
  final Place? selection;
  final List<Place> items;
  final Function(Place?)? onChanged;
  final String hint;
  final String errorMessage;

  const CommonDropdown({
    super.key,
    required this.selection,
    required this.items,
    required this.onChanged,
    this.hint = '',
    this.errorMessage = 'Invalid',
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<Place>(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value != null) {
          return null;
        } else {
          return errorMessage;
        }
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Constants.radius_12),
        ),
        contentPadding: const EdgeInsets.all(Constants.padding_16),
      ),
      value: selection,
      hint: Text(hint),
      icon: const Icon(Icons.keyboard_arrow_down),
      items: items.map((Place items) {
        return DropdownMenuItem(
          value: items,
          child: Text(items.value ?? ''),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
