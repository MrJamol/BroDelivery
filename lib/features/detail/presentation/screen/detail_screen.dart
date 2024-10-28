import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/core/constants/colors/app_colors.dart';
import 'package:food_delivery/features/cart/presentation/screen/cart_screen.dart';
import 'package:food_delivery/features/detail/presentation/bloc/detail_bloc.dart';
import 'package:food_delivery/features/detail/presentation/bloc/detail_state.dart';
import 'package:food_delivery/features/home/persentation/widget/restourant_card.dart';

class DetailScreen extends StatefulWidget {
  final String restaurantName;
  final String imagePath;
  final double stars;
  final int reviews;
  final double price;
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
  bool isHeartFilled = false;
  int quantity = 1; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.instance.white,
      body: BlocBuilder<DetailBloc, DetailState>(
        builder: (context, state) {
          return Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                                    !isHeartFilled; 
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
                                    ? Icons.favorite 
                                    : Icons.favorite_border, 
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
                        Text(
                          widget.restaurantName,
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
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
                        Row(
                          children: [
                            Text(
                              '\$',
                              style:
                                  TextStyle(color: AppColors.instance.kPrimary),
                            ),
                            Text(
                              '${widget.price}', 
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.instance.kPrimary),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text('per pc'),
                            Spacer(), 
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (quantity > 1) {
                                    quantity--; 
                                  }
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.instance.white,
                                  border: Border.all(
                                      color: AppColors.instance.kPrimary,
                                      width: 2), 
                                  shape: BoxShape.circle,
                                ),
                                padding: const EdgeInsets.all(10),
                                child: Icon(
                                  Icons.remove,
                                  color: AppColors.instance
                                      .kPrimary, 
                                ),
                              ),
                            ),
                            const SizedBox(width: 8), 
                            Text(
                              '$quantity',
                              style: TextStyle(fontSize: 25),
                            ),
                            const SizedBox(width: 8), 
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  quantity++; 
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
                            height: 8), 
                        Text(
                          widget.description, 
                          style: const TextStyle(
                              fontSize: 16, color: Colors.black87),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          widget.freeDelivery
                              ? 'Free Delivery'
                              : 'Fast Delivery',
                          style: const TextStyle(
                              fontSize: 28, color: Colors.orange),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Preparation Time: ${widget.prepTime[0]}-${widget.prepTime[1]} mins',
                          style: const TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(height: 16),
                        Wrap(
                          spacing: 3,
                          runSpacing: 3,
                          children: widget.categories.map((category) {
                            return CategoryChip(label: category.toUpperCase());
                          }).toList(),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Total: ${((widget.price * quantity).toStringAsFixed(2))} Usd', // Display total price rounded to 2 decimal places
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: AppColors.instance.kPrimary,
                          ),
                        ),

                        SizedBox(
                          height: 50,
                        ),

                        Center(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.instance.kPrimary,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 32.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            onPressed: () {
                              final cartItem = {
                                'title': widget.restaurantName,
                                'imagePath': widget.imagePath,
                                'description': widget.description,
                                'price': widget.price *
                                    quantity
                                        .toDouble(), 
                                'quantity':
                                    quantity, 
                              };
                              print(cartItem);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CartScreen(
                                      newCartItems: [
                                        cartItem
                                      ]), 
                                ),
                              );
                            },
                            child: Text(
                              'ADD TO CART',
                              style: TextStyle(color: AppColors.instance.white),
                            ),
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
    );
  }
}
