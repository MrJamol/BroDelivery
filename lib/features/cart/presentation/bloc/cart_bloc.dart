import 'package:flutter_bloc/flutter_bloc.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState(cartItems: <Map<String, dynamic>>[], subtotal: 0, tax: 0, delivery: 0, total: 0)) {

    on<AddToCartEvent>(_onAddToCart);
    on<LoadCartEvent>(_onLoadCart);
    on<UpdateQuantityEvent>(_onUpdateQuantity);
    on<ApplyPromoCodeEvent>(_onApplyPromoCode);
  }

  void _onAddToCart(AddToCartEvent event, Emitter<CartState> emit) {
    final updatedCartItems = List.from(state.cartItems)
      ..add({
        'title': event.title,
        'imagePath': event.imagePath,
        'description': event.description,
        'price': event.price,
        'quantity': 1,
      });
    
    emit(state.copyWith(cartItems: updatedCartItems));
  }

  void _onLoadCart(LoadCartEvent event, Emitter<CartState> emit) {
    emit(CartState.initial());
  }

  void _onUpdateQuantity(UpdateQuantityEvent event, Emitter<CartState> emit) {
    final updatedItems = List<Map<String, dynamic>>.from(state.cartItems);
    final item = updatedItems[event.index];
    final currentQuantity = item['quantity'];

    if (event.increment) {
      item['quantity'] = currentQuantity + 1;
    } else if (currentQuantity > 1) {
      item['quantity'] = currentQuantity - 1;
    }

    double subtotal = updatedItems.fold(0, (sum, item) => sum + (item['price'] * item['quantity']));
    double total = subtotal + state.tax + state.delivery;

    emit(state.copyWith(cartItems: updatedItems, subtotal: subtotal, total: total));
  }

  void _onApplyPromoCode(ApplyPromoCodeEvent event, Emitter<CartState> emit) {
    double discount = 5.0;
    double newTotal = state.total - discount;
    emit(state.copyWith(total: newTotal));
  }
}
