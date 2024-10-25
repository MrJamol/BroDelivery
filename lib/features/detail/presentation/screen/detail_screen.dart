import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/features/detail/presentation/bloc/detail_bloc.dart';
import 'package:food_delivery/features/detail/presentation/bloc/detail_state.dart';
import 'package:food_delivery/features/home/persentation/widget/restourant_card.dart';

class DetailScreen extends StatelessWidget {
  final String restaurantName;
  final String imagePath;
  final double stars;
  final int reviews;
  final bool freeDelivery;
  final List<int> prepTime;
  final List<String> categories;

  const DetailScreen({
    super.key,
    required this.restaurantName,
    required this.imagePath,
    required this.stars,
    required this.reviews,
    required this.freeDelivery,
    required this.prepTime,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ItemDetailBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(restaurantName), // Show the restaurant name
        ),
        body: BlocBuilder<ItemDetailBloc, ItemDetailState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    imagePath, // Display the restaurant image
                    width: 200,
                    height: 200,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    restaurantName, // Restaurant name
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.orange, size: 20),
                      Text('$stars ($reviews)', style: const TextStyle(color: Colors.grey)),
                      const Spacer(),
                      TextButton(onPressed: () {}, child: const Text('See Review')),
                    ],
                  ),
                  Text(
                    freeDelivery ? 'Free Delivery' : 'Fast Delivery',
                    style: const TextStyle(fontSize: 28, color: Colors.orange),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Preparation Time: ${prepTime[0]}-${prepTime[1]} mins',
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 3,
                    runSpacing: 3,
                    children: categories.map((category) {
                      return CategoryChip(label: category.toUpperCase());
                    }).toList(),
                  ),
                  const Spacer(),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                      },
                      child: const Text('ADD TO CART'),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
