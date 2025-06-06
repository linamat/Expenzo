import 'package:expenzo/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CategoryDropdownButton extends StatefulWidget {
  const CategoryDropdownButton({super.key, required this.onItemSelected});
  final Function(String?) onItemSelected;

  @override
  State<CategoryDropdownButton> createState() => _CategoryDropdownButtonState();
}

List<String> list = [
  'food',
  'communal',
  'transportation',
];

String dropdownValue = list.first;

class _CategoryDropdownButtonState extends State<CategoryDropdownButton> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(
        Icons.arrow_drop_down_rounded,
        color: containerColor,
      ),
      elevation: 16,
      style: const TextStyle(color: containerColor),
      underline: Container(
        height: 2,
        color: primaryColor,
      ),
      onChanged: (String? value) {
        setState(() {
          dropdownValue = value!;
        });
        widget.onItemSelected(value);
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
