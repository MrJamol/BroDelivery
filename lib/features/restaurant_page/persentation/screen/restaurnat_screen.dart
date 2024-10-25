// screens/restaurant_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/restaurant_bloc.dart';
import '../bloc/restaurant_event.dart';
import '../bloc/restaurant_state.dart';
import '../widgets/pizza_card.dart';

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
                '80 types of pizza',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            // Sort By Dropdown (Controlled by BLoC)
            BlocBuilder<RestaurantBloc, RestaurantState>(
              builder: (context, state) {
                return _buildSortBy(context, state.sortBy);
              },
            ),
            // List of Pizzas (Hardcoded)
            Expanded(
              child: ListView(
                children: [
                  PizzaCard(
                    image: 'assets/images/pizza1.png',
                    price: 10.35,
                    name: 'Chicken Hawaiian',
                    description: 'Chicken, Cheese and Pineapple',
                    rating: 4.5,
                  ),
                  PizzaCard(
                    image: 'assets/images/pizza2.png',
                    price: 10.35,
                    name: 'Vegetarian Pizza',
                    description: 'Tomatoes, Mushrooms, Peppers',
                    rating: 4.5,
                  ),
                ],
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
