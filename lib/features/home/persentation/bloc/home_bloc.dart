import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/features/home/persentation/bloc/home_event.dart';
import 'package:food_delivery/features/home/persentation/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitialState()) {
    on<SelectCategoryEvent>((event, emit) {
      emit(CategorySelectedState(event.category));
    });
  }
}
