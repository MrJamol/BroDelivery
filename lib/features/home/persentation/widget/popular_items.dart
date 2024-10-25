import 'package:flutter/material.dart';
import 'package:food_delivery/features/home/persentation/bloc/restourant_model.dart';

class PopularItems extends StatelessWidget {
  final List<PopularItemModel> items;

  PopularItems({required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Popular Items', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return ListTile(
              title: Text(item.name),
              subtitle: Text('\$${item.price}'),
            );
          },
        ),
      ],
    );
  }
}
