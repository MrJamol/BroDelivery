// screens/cart_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:food_delivery/features/cart/presentation/bloc/cart_event.dart';
import 'package:food_delivery/features/cart/presentation/bloc/cart_state.dart';
import 'package:food_delivery/features/cart/presentation/widgets/cart_item_tile.dart';
import 'package:food_delivery/features/cart/presentation/widgets/promo_code_field.dart';

class CartScreen extends StatelessWidget {
  final promoCodeController = TextEditingController();

  CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartBloc()..add(LoadCartEvent()),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Cart', style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {},
          ),
        ),
        body: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.cartItems.length,
                      itemBuilder: (context, index) {
                        final item = state.cartItems[index];
                        return CartItemTile(
                          imagePath: item['imagePath'],
                          title: item['title'],
                          description: item['description'],
                          price: item['price'],
                          quantity: item['quantity'],
                          onIncrement: () => BlocProvider.of<CartBloc>(context)
                              .add(UpdateQuantityEvent(index, true)),
                          onDecrement: () => BlocProvider.of<CartBloc>(context)
                              .add(UpdateQuantityEvent(index, false)),
                        );
                      },
                    ),
                  ),
                  // SizedBox(height: 16),
                  PromoCodeField(
                    controller: promoCodeController,
                    onApply: () {
                      BlocProvider.of<CartBloc>(context).add(
                        ApplyPromoCodeEvent(promoCodeController.text),
                      );
                    },
                  ),
                  SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSummaryRow('Subtotal', state.subtotal),
                      _buildSummaryRow('Tax and Fees', state.tax),
                      _buildSummaryRow('Delivery', state.delivery),
                      Divider(thickness: 1, height: 32),
                      _buildSummaryRow('Total', state.total, isTotal: true),
                    ],
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      'CHECKOUT',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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

  // Helper method to build summary rows
  Widget _buildSummaryRow(String label, double amount, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: isTotal ? 18 : 16, fontWeight: isTotal ? FontWeight.bold : FontWeight.normal),
          ),
          Text(
            '\$${amount.toStringAsFixed(2)} USD',
            style: TextStyle(fontSize: isTotal ? 18 : 16, fontWeight: isTotal ? FontWeight.bold : FontWeight.normal),
          ),
        ],
      ),
    );
  }
}
