// blocs/cart/cart_state.dart
import 'package:equatable/equatable.dart';

class CartState extends Equatable {
  final List<Map<String, dynamic>> cartItems;
  final double subtotal;
  final double tax;
  final double delivery;
  final double total;

  CartState({
    required this.cartItems,
    required this.subtotal,
    required this.tax,
    required this.delivery,
    required this.total,
  });

  // Initial state with hardcoded values
  factory CartState.initial() {
    List<Map<String, dynamic>> initialItems = [
      {
        "imagePath": "assets/images/apple_pie.jpg",
        "title": "Red n hot pizza",
        "description": "Spicy chicken, beef",
        "price": 15.30,
        "quantity": 2,
      },
      {
        "imagePath": "assets/images/chipotle.jpg",
        "title": "Greek salad",
        "description": "with baked salmon",
        "price": 12.00,
        "quantity": 2,
      },
    ];

    double subtotal = initialItems.fold(
        0, (sum, item) => sum + (item['price'] * item['quantity']));
    double tax = 5.30;
    double delivery = 1.00;
    double total = subtotal + tax + delivery;

    return CartState(
      cartItems: initialItems,
      subtotal: subtotal,
      tax: tax,
      delivery: delivery,
      total: total,
    );
  }

  @override
  List<Object> get props => [cartItems, subtotal, tax, delivery, total];

  // CopyWith method for immutability
  CartState copyWith({
    List<Map<String, dynamic>>? cartItems,
    double? subtotal,
    double? tax,
    double? delivery,
    double? total,
  }) {
    return CartState(
      cartItems: cartItems ?? this.cartItems,
      subtotal: subtotal ?? this.subtotal,
      tax: tax ?? this.tax,
      delivery: delivery ?? this.delivery,
      total: total ?? this.total,
    );
  }
}
