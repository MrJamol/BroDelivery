import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/features/detail/presentation/bloc/detail_event.dart';
import 'package:food_delivery/features/detail/presentation/bloc/detail_state.dart';

class ItemDetailBloc extends Bloc<ItemDetailEvent, ItemDetailState> {
  ItemDetailBloc() : super(ItemDetailState(quantity: 1, price: 9.50, selectedAddons: []));

  @override
  Stream<ItemDetailState> mapEventToState(ItemDetailEvent event) async* {
    if (event is IncreaseQuantity) {
      yield ItemDetailState(
        quantity: state.quantity + 1,
        price: state.price,
        selectedAddons: state.selectedAddons,
      );
    } else if (event is DecreaseQuantity) {
      yield ItemDetailState(
        quantity: state.quantity > 1 ? state.quantity - 1 : 1,
        price: state.price,
        selectedAddons: state.selectedAddons,
      );
    } else if (event is ToggleAddon) {
      List<String> updatedAddons = List.from(state.selectedAddons);
      if (updatedAddons.contains(event.addon)) {
        updatedAddons.remove(event.addon);
      } else {
        updatedAddons.add(event.addon);
      }
      yield ItemDetailState(
        quantity: state.quantity,
        price: state.price,
        selectedAddons: updatedAddons,
      );
    }
  }
}
