import 'package:equatable/equatable.dart';

class CartState extends Equatable {
  final List<dynamic> cartItems;
  final double subtotal;
  final double tax;
  final double delivery;
  final double total;

  const CartState({
    required this.cartItems,
    required this.subtotal,
    required this.tax,
    required this.delivery,
    required this.total,
  });

  // Initial state with empty values
  factory CartState.initial() {
    return const CartState(
      cartItems: [],
      subtotal: 0.0,
      tax: 0.0,
      delivery: 0.0,
      total: 0.0,
    );
  }

  @override
  List<Object> get props => [cartItems, subtotal, tax, delivery, total];

  // CopyWith method for immutability
  CartState copyWith({
    List<dynamic>? cartItems,
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
