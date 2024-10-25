import 'package:flutter/material.dart';
import 'package:food_delivery/core/constants/colors/app_colors.dart';
import 'package:food_delivery/features/home/persentation/widget/restourant_list.dart';

class FoodCardWidget extends StatelessWidget {
  const FoodCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: RestaurantList.restaurants.entries.map((entry) {
          final restaurantName = entry.key;
          final restaurantData = entry.value;

          final double stars = restaurantData[0];
          final int reviews = restaurantData[1];
          final bool freeDelivery = restaurantData[2];
          final List<int> prepTime = restaurantData[3];
          final List<String> categories = restaurantData[4];
          final String imagePath = restaurantData[5];

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: RestaurantCard(
              restaurantName: restaurantName,
              stars: stars,
              reviews: reviews,
              freeDelivery: freeDelivery,
              prepTime: prepTime,
              categories: categories,
              imagePath: imagePath,
            ),
          );
        }).toList(),
      ),
    );
  }
}

class RestaurantCard extends StatefulWidget {
  final String restaurantName;
  final double stars;
  final int reviews;
  final bool freeDelivery;
  final List<int> prepTime;
  final List<String> categories;
  final String imagePath;

  const RestaurantCard({
    super.key,
    required this.restaurantName,
    required this.stars,
    required this.reviews,
    required this.freeDelivery,
    required this.prepTime,
    required this.categories,
    required this.imagePath,
  });

  @override
  _RestaurantCardState createState() => _RestaurantCardState();
}

class _RestaurantCardState extends State<RestaurantCard> {
  bool isFavorited = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      height: 340,
      child: Card(
        elevation: 6,
        shadowColor: Colors.black,
        color: AppColors.instance.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.asset(
                    widget.imagePath,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Text(
                          widget.stars.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const Icon(
                          Icons.star,
                          color: Colors.orange,
                          size: 16,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          '(${widget.reviews})',
                          style: TextStyle(
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isFavorited = !isFavorited;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isFavorited ? Icons.favorite : Icons.favorite_border,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        widget.restaurantName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 5),
                      const Icon(
                        Icons.verified,
                        color: Colors.green,
                        size: 16,
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(Icons.delivery_dining,
                          size: 16, color: AppColors.instance.kPrimary),
                      const SizedBox(width: 4),
                      Text(
                        widget.freeDelivery ? 'Free delivery' : 'Fast delivery',
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(width: 10),
                      const Icon(Icons.access_time,
                          size: 16, color: Colors.red),
                      const SizedBox(width: 4),
                      Text(
                        '${widget.prepTime[0]}-${widget.prepTime[1]} mins',
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 3,
                    runSpacing: 3,
                    children: widget.categories.take(3).map((category) {
                      return CategoryChip(label: category.toUpperCase());
                    }).toList(),
                  ),
                  if (widget.categories.length > 3)
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                        '+ ${widget.categories.length - 3} more',
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryChip extends StatelessWidget {
  final String label;

  const CategoryChip({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Text(
          label,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
