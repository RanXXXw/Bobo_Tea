import 'package:flutter/material.dart';

class ChoiceChipGroup extends StatelessWidget {
  final String title;
  final List<Enum> options;
  final Enum selectedValue;
  final Function(Enum) onSelectionChanged;

  const ChoiceChipGroup({
    super.key,
    required this.title,
    required this.options,
    required this.selectedValue,
    required this.onSelectionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 15),
      width: 600,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 12.0,
            runSpacing: 12.0,
            children: options
                .map((option) => ChoiceChip(
                      padding: const EdgeInsets.all(10.0),
                      showCheckmark: false,
                      backgroundColor: Colors.grey[100],
                      selectedColor: Colors.deepPurple[100],
                      shape: const StadiumBorder(
                          side: BorderSide(style: BorderStyle.none)),
                      labelStyle: TextStyle(
                        color: selectedValue == option
                            ? Colors.white
                            : Colors.black,
                        fontSize: 16.0,
                      ),
                      label: Text(option.toString().split('.').last),
                      selected: selectedValue == option,
                      onSelected: (bool selected) {
                        if (selected) {
                          onSelectionChanged(option);
                        }
                      },
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
