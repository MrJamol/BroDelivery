import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/features/home/persentation/bloc/home_event.dart';
import 'package:food_delivery/features/home/persentation/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitialState()) {
    // Register the event handler here
    on<SelectCategoryEvent>((event, emit) {
      // Emit the new state with the selected category
      emit(CategorySelectedState(event.category));
    });
  }
}
