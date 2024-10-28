import 'package:flutter/material.dart';

class AddOnTile extends StatelessWidget {
  final String name;
  final double price;
  final bool selected;
  final VoidCallback onSelected;

  const AddOnTile({super.key, required this.name, required this.price, required this.selected, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name),
      trailing: Text('+${price.toStringAsFixed(2)}'),
      leading: Radio(
        value: selected,
        groupValue: true,
        onChanged: (value) => onSelected(),
      ),
    );
  }
}
