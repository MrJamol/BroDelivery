import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/features/detail/presentation/bloc/detail_event.dart';
import 'package:food_delivery/features/detail/presentation/bloc/detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  DetailBloc() : super(DetailState(quantity: 1, price: 9.50, selectedAddons: []));

  Stream<DetailState> mapEventToState(DetailEvent event) async* {
    if (event is IncreaseQuantity) {
      yield DetailState(
        quantity: state.quantity + 1,
        price: state.price,
        selectedAddons: state.selectedAddons,
      );
    } else if (event is DecreaseQuantity) {
      yield DetailState(
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
      yield DetailState(
        quantity: state.quantity,
        price: state.price,
        selectedAddons: updatedAddons,
      );
    }
  }
}
