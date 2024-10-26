import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_delivery/core/constants/colors/app_colors.dart';
import 'package:food_delivery/features/restaurant_page/persentation/bloc/restaurant_bloc.dart';
import 'package:food_delivery/features/restaurant_page/persentation/bloc/restaurant_event.dart';
import 'package:food_delivery/features/restaurant_page/persentation/bloc/restaurant_state.dart';
import 'package:food_delivery/features/restaurant_page/persentation/widgets/mcdonalds_menu.dart';
import 'package:food_delivery/features/restaurant_page/persentation/widgets/pizza_card.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RestaurantBloc(),
      child: Scaffold(
        backgroundColor: AppColors.instance.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Custom Header
            Container(
              height: 200, // Define height for the header
              child: Stack(
                children: [
                  // Back Button
                  Positioned(
                    left: 16,
                    top: 35,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.instance.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.black),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ),
                  // Image on the top right corner
                  Positioned(
                    right: -60,
                    top: -30,
                    child: Image.asset(
                      'assets/images/piza.png', // Change to your image path
                      width: 250, // Adjust width as needed
                      height: 250, // Adjust height as needed
                    ),
                  ),
                ],
              ),
            ),
            // Menu Title
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'McDonald\'s\nMenu',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            BlocBuilder<RestaurantBloc, RestaurantState>(
              builder: (context, state) {
                return _buildSortBy(context, state.sortBy);
              },
            ),
            Expanded(
              child: ListView(
                children: McDonaldsMenu.products.entries.map((entry) {
                  final productDetails = entry.value;
                  return PizzaCard(
                    image: productDetails[1],
                    price: productDetails[0],
                    name: productDetails[2],
                    description: productDetails[3],
                    rating: productDetails[4],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSortBy(BuildContext context, String currentSortBy) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Text('Sort by: ', style: TextStyle(fontSize: 16)),
          DropdownButton<String>(
            value: currentSortBy,
            items: ['Popular', 'Price'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: TextStyle(color: AppColors.instance.kPrimary),
                ),
              );
            }).toList(),
            onChanged: (String? newValue) {
              if (newValue != null) {
                context.read<RestaurantBloc>().add(ChangeSortByEvent(newValue));
              }
            },
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {},
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
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
                  child: SvgPicture.asset('assets/icons/filter.svg',
                      height: 20, width: 20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
