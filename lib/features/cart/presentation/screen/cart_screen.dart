import 'package:flutter/material.dart';
import 'package:food_delivery/features/cart/presentation/widgets/cart_item_tile.dart';
import 'package:food_delivery/features/cart/presentation/widgets/promo_code_field.dart';

class CartScreen extends StatefulWidget {
  final List<Map<String, dynamic>>? newCartItems;

  const CartScreen({super.key, this.newCartItems});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Map<String, dynamic>> cartItems = [];
  final TextEditingController promoCodeController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Initialize cartItems with newCartItems if provided
    if (widget.newCartItems != null && widget.newCartItems!.isNotEmpty) {
      cartItems.addAll(widget.newCartItems!);
    }
  }

  @override
  Widget build(BuildContext context) {
    double subtotal = cartItems.fold(
      0,
      (sum, item) =>
          sum + (item['price'] as double) * (item['quantity'] as int),
    );

    double taxAndFees = subtotal * 0.12; // Calculate tax and fees
    double deliveryCost = 5.0; // Fixed delivery cost
    double total = subtotal + taxAndFees + deliveryCost; // Total calculation

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
                            setState(() {
                              item['quantity'] = (item['quantity'] as int) + 1;
                            });
                          },
                          onDecrement: () {
                            if (item['quantity'] as int > 1) {
                              setState(() {
                                item['quantity'] =
                                    (item['quantity'] as int) - 1;
                              });
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
                print('Promo Code Applied: ${promoCodeController.text}');
              },
            ),
            SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSummaryRow('Subtotal', subtotal),
                _buildSummaryRow('Tax and Fees', taxAndFees),
                _buildSummaryRow('Delivery Cost', deliveryCost),
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
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
            style: TextStyle(
              fontSize: isTotal ? 18 : 16,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            '\$${amount.toStringAsFixed(2)} USD',
            style: TextStyle(
              fontSize: isTotal ? 18 : 16,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
