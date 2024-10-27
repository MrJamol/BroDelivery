import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:food_delivery/features/cart/presentation/widgets/cart_item_tile.dart';
import 'package:food_delivery/features/cart/presentation/widgets/promo_code_field.dart';

class CartScreen extends StatefulWidget {
  final List<Map<String, Object>> initialCartItems; // Accept cart items as a parameter

  CartScreen({super.key, required this.initialCartItems});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final Box<Map<String, Object>> cartBox = Hive.box<Map<String, Object>>('cart'); // Access the cart box
  final TextEditingController promoCodeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _saveCartItemsToHive(widget.initialCartItems);
  }

  void _saveCartItemsToHive(List<Map<String, Object>> items) {
    for (var item in items) {
      cartBox.add(item); // Add each item to the Hive box
    }
  }

  @override
  Widget build(BuildContext context) {
    double subtotal = 0;
    double tax = 0; // You can set this based on your requirements
    double delivery = 0; // You can set this based on your requirements

    // Retrieve cart items from Hive
    List<Map<String, Object>> cartItems = List<Map<String, Object>>.from(cartBox.values);

    // Calculate subtotal
    subtotal = cartItems.fold(0, (sum, item) => sum + (item['price'] as double )* (item['quantity'] as int));

    double total = subtotal + tax + delivery;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Cart', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: cartItems.isNotEmpty
                  ? ListView.builder(
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        final item = cartItems[index];
                        return CartItemTile(
                          imagePath: item['imagePath'] as String,
                          title: item['title'] as String,
                          description: item['description'] as String,
                          price: item['price'] as double,
                          quantity: item['quantity'] as int,
                          onIncrement: () {
                            // Increment logic
                            item['quantity'] = (item['quantity'] as int) + 1;
                            cartBox.putAt(index, item); // Update the item in Hive
                            setState(() {}); // Update the UI
                          },
                          onDecrement: () {
                            // Decrement logic
                            if (item['quantity'] as int > 1) {
                              item['quantity'] = (item['quantity'] as int) - 1;
                              cartBox.putAt(index, item); // Update the item in Hive
                              setState(() {}); // Update the UI
                            }
                          },
                        );
                      },
                    )
                  : Center(child: Text('Your cart is empty.')),
            ),
            PromoCodeField(
              controller: promoCodeController,
              onApply: () {
                // Handle promo code application logic here
                print('Promo Code Applied: ${promoCodeController.text}');
              },
            ),
            SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSummaryRow('Subtotal', subtotal),
                _buildSummaryRow('Tax and Fees', tax),
                _buildSummaryRow('Delivery', delivery),
                Divider(thickness: 1, height: 32),
                _buildSummaryRow('Total', total, isTotal: true),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Handle checkout logic
              },
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
      ),
    );
  }

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
