// blocs/cart/cart_event.dart
import 'package:equatable/equatable.dart';

abstract class CartEvent extends Equatable {
  @override
  List<Object> get props => [];
}
// cart_event.dart
class AddToCartEvent extends CartEvent {
  final String title;
  final String imagePath;
  final String description;
  final double price;

  AddToCartEvent({
    required this.title,
    required this.imagePath,
    required this.description,
    required this.price,
  });
}


// Event to load the initial cart items
class LoadCartEvent extends CartEvent {}

// Event to update the quantity of a cart item
class UpdateQuantityEvent extends CartEvent {
  final int index;
  final bool increment; // true to add, false to remove

  UpdateQuantityEvent(this.index, this.increment);

  @override
  List<Object> get props => [index, increment];
}

// Event to apply a promo code
class ApplyPromoCodeEvent extends CartEvent {
  final String promoCode;

  ApplyPromoCodeEvent(this.promoCode);

  @override
  List<Object> get props => [promoCode];
}
