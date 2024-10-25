import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/features/detail/presentation/bloc/detail_bloc.dart';
import 'package:food_delivery/features/detail/presentation/bloc/detail_event.dart';
import 'package:food_delivery/features/detail/presentation/bloc/detail_state.dart';
import 'package:food_delivery/features/detail/presentation/widget/add_ones.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ItemDetailBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Ground Beef Tacos'),
        ),
        body: BlocBuilder<ItemDetailBloc, ItemDetailState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/images/tacobell.jpg',
                    width: 200,
                    height: 200,
                  ), // Replace with actual image
                  SizedBox(height: 16),
                  Text(
                    'Ground Beef Tacos',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.orange, size: 20),
                      Text('4.5 (30+)', style: TextStyle(color: Colors.grey)),
                      Spacer(),
                      TextButton(onPressed: () {}, child: Text('See Review'))
                    ],
                  ),
                  Text(
                    '\$${state.price.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 28, color: Colors.orange),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Brown the beef better. Lean ground beef - I like to use 85% lean angus. Garlic - use fresh chopped...',
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Text('Quantity:'),
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          // context.read<ItemDetailBloc>().add(DecreaseQuantity());
                        },
                      ),
                      Text(state.quantity.toString()),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          // context.read<ItemDetailBloc>().add(IncreaseQuantity());
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text('Choice of Add On', style: TextStyle(fontSize: 18)),
                  AddOnTile(
                    name: 'Pepper Julienned',
                    price: 2.30,
                    selected: state.selectedAddons.contains('Pepper Julienned'),
                    onSelected: () {
                      // context.read<ItemDetailBloc>().add(ToggleAddon('Pepper Julienned'));
                    },
                  ),
                  AddOnTile(
                    name: 'Baby Spinach',
                    price: 4.70,
                    selected: state.selectedAddons.contains('Baby Spinach'),
                    onSelected: () {
                      // context.read<ItemDetailBloc>().add(ToggleAddon('Baby Spinach'));
                    },
                  ),
                  Spacer(),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // context.read<ItemDetailBloc>().add(AddToCart());
                      },
                      child: Text('ADD TO CART'),
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
