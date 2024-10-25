import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/features/restaurant_page/persentation/bloc/restaurant_bloc.dart';
import 'package:food_delivery/features/restaurant_page/persentation/bloc/restaurant_event.dart';
import 'package:food_delivery/features/restaurant_page/persentation/bloc/restaurant_state.dart';
import 'package:food_delivery/features/restaurant_page/persentation/widgets/mcdonalds_menu.dart';
import 'package:food_delivery/features/restaurant_page/persentation/widgets/pizza_card.dart';

class RestaurantScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RestaurantBloc(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text('Fast Food'),
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'McDonald\'s Menu',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            // Sort By Dropdown (Controlled by BLoC)
            BlocBuilder<RestaurantBloc, RestaurantState>(
              builder: (context, state) {
                return _buildSortBy(context, state.sortBy);
              },
            ),
            // List of McDonald's Products (Dynamic)
            Expanded(
              child: ListView(
                children: McDonaldsMenu.products.entries.map((entry) {
                  final productName = entry.key;
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
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              if (newValue != null) {
                context.read<RestaurantBloc>().add(ChangeSortByEvent(newValue));
              }
            },
          ),
        ],
      ),
    );
  }
}
