import 'package:equatable/equatable.dart';

abstract class CartEvent extends Equatable {
  @override
  List<Object> get props => [];
}
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


class LoadCartEvent extends CartEvent {}

class UpdateQuantityEvent extends CartEvent {
  final int index;
  final bool increment;

  UpdateQuantityEvent(this.index, this.increment);

  @override
  List<Object> get props => [index, increment];
}

class ApplyPromoCodeEvent extends CartEvent {
  final String promoCode;

  ApplyPromoCodeEvent(this.promoCode);

  @override
  List<Object> get props => [promoCode];
}
