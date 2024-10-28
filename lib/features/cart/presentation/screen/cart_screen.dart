import 'package:flutter/material.dart';
import 'package:food_delivery/features/cart/presentation/widgets/cart_item_tile.dart';
import 'package:food_delivery/features/cart/presentation/widgets/promo_code_field.dart';
import 'package:food_delivery/features/home/persentation/screen/home_screen.dart';
import 'package:lottie/lottie.dart';

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

    double taxAndFees = subtotal * 0.12;
    double deliveryCost = 5.0;
    double total = subtotal + taxAndFees + deliveryCost;

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
                _showCheckoutDialog(context, total);
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

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            'Success',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset('assets/lotties/success.json'),
              SizedBox(height: 10),
              Text(
                'Successful payment!',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          HomeScreen()), 
                  (_) => false, 
                ); 
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.green, 
              ),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showCheckoutDialog(BuildContext context, double total) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), 
          ),
          title: Text('Checkout Receipt',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                for (var item in cartItems)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${item['title']} (x${item['quantity']})',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                        Text(
                          '\$${((item['price'] as double) * (item['quantity'] as int)).toStringAsFixed(2)}',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                Divider(thickness: 1, height: 32), 
                _buildTotalRow(
                    'Subtotal',
                    total -
                        (total * 0.12) -
                        5.0), 
                _buildTotalRow('Tax and Fees', total * 0.12), 
                _buildTotalRow('Delivery Cost', 5.00), 
                Divider(thickness: 1, height: 32), 
                Text(
                  'Total: \$${total.toStringAsFixed(2)}',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); 
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor:
                    Colors.red, 
              ),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); 
                print('Purchase Completed');
                _showSuccessDialog(context); 
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor:
                    Colors.green, 
              ),
              child: Text('Buy'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTotalRow(String label, double amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          Text(
            '\$${amount.toStringAsFixed(2)}',
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
        ],
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
