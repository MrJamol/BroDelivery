import 'package:flutter_bloc/flutter_bloc.dart';
import 'restaurant_event.dart';
import 'restaurant_state.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  RestaurantBloc() : super(RestaurantState(sortBy: 'Popular')) {
    on<ChangeSortByEvent>((event, emit) {
      emit(RestaurantState(sortBy: event.sortBy));
    });
  }
}
