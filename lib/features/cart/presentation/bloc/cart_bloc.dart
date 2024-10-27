// blocs/cart/cart_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/features/cart/presentation/bloc/cart_event.dart';
import 'package:food_delivery/features/cart/presentation/bloc/cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState.initial()) {
    on<LoadCartEvent>(_onLoadCart);
    on<UpdateQuantityEvent>(_onUpdateQuantity);
    on<ApplyPromoCodeEvent>(_onApplyPromoCode);
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

    // Recalculate totals
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
