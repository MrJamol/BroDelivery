import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/core/constants/colors/app_colors.dart';
import 'package:food_delivery/features/detail/presentation/bloc/detail_bloc.dart';
import 'package:food_delivery/features/detail/presentation/bloc/detail_state.dart';
import 'package:food_delivery/features/detail/presentation/widget/add_ones.dart';
import 'package:food_delivery/features/home/persentation/widget/restourant_card.dart';

class DetailScreen extends StatefulWidget {
  final String restaurantName;
  final String imagePath;
  final double stars;
  final int reviews;
  final int price;
  final String description;
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
    required this.price,
    required this.description,
  });

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool isHeartFilled = false; // Heart state (unfilled by default)
  int quantity = 1; // State variable for quantity

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ItemDetailBloc(),
      child: Scaffold(
        body: BlocBuilder<ItemDetailBloc, ItemDetailState>(
          builder: (context, state) {
            return Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Container to properly position the image with padding
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 40, horizontal: 16),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Image.asset(
                              widget.imagePath,
                              width: 323,
                              height: 206,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 16,
                            left: 16,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                padding: const EdgeInsets.all(8),
                                child: const Icon(
                                  Icons.arrow_back,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 16,
                            right: 16,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  isHeartFilled =
                                      !isHeartFilled; // Toggle heart state
                                });
                              },
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                padding: const EdgeInsets.all(8),
                                child: Icon(
                                  isHeartFilled
                                      ? Icons.favorite // Filled heart
                                      : Icons.favorite_border, // Outlined heart
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Restaurant Name
                          Text(
                            widget.restaurantName,
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          // Rating Row
                          Row(
                            children: [
                              const Icon(Icons.star,
                                  color: Colors.orange, size: 20),
                              Text('${widget.stars} (${widget.reviews})',
                                  style: const TextStyle(color: Colors.grey)),
                              TextButton(
                                style: ButtonStyle(),
                                onPressed: () {},
                                child: Text(
                                  'See Review',
                                  style: TextStyle(
                                      color: AppColors.instance.kPrimary),
                                ),
                              )
                            ],
                          ),
                          // Price and Quantity Control
                          Row(
                            children: [
                              Text(
                                '\$',
                                style: TextStyle(
                                    color: AppColors.instance.kPrimary),
                              ),
                              Text(
                                '${widget.price}', // Display total price
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.instance.kPrimary),
                              ),

                              Spacer(), // Space between price and quantity controls
                              // Minus Button
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (quantity > 1) {
                                      quantity--; // Decrease quantity
                                    }
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.instance.white,
                                    border: Border.all(
                                        color: AppColors.instance.kPrimary,
                                        width: 2), // Set border color here
                                    shape: BoxShape.circle,
                                  ),
                                  padding: const EdgeInsets.all(10),
                                  child: Icon(
                                    Icons.remove,
                                    color: AppColors.instance
                                        .kPrimary, // Change icon color if desired
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8), // Space between buttons
                              Text(
                                '$quantity',
                                style: TextStyle(fontSize: 25),
                              ),
                              const SizedBox(width: 8), // Space between buttons
                              // Plus Button
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    quantity++; // Increase quantity
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.instance.kPrimary,
                                    shape: BoxShape.circle,
                                  ),
                                  padding: const EdgeInsets.all(10),
                                  child: Icon(
                                    Icons.add,
                                    color: AppColors.instance.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                              height: 8), // Space between price and description
                          // Description
                          Text(
                            widget.description, // Display description
                            style: const TextStyle(
                                fontSize: 16, color: Colors.black87),
                          ),
                          const SizedBox(height: 16),
                          // Free Delivery Info
                          Text(
                            widget.freeDelivery
                                ? 'Free Delivery'
                                : 'Fast Delivery',
                            style: const TextStyle(
                                fontSize: 28, color: Colors.orange),
                          ),
                          const SizedBox(height: 8),
                          // Preparation Time
                          Text(
                            'Preparation Time: ${widget.prepTime[0]}-${widget.prepTime[1]} mins',
                            style: const TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(height: 16),
                          // Category Chips
                          Wrap(
                            spacing: 3,
                            runSpacing: 3,
                            children: widget.categories.map((category) {
                              return CategoryChip(
                                  label: category.toUpperCase());
                            }).toList(),
                          ),
                          const SizedBox(height: 16),
                          // Add to Cart Button
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                // Add to cart functionality
                              },
                              child: const Text('ADD TO CART'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
