import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/features/profile/persentation/bloc/profile_event.dart';
import 'package:food_delivery/features/profile/persentation/bloc/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<LoadProfileEvent>((event, emit) {
      emit(ProfileLoaded("Farion Wick", "farionwick@gmail.com"));
    });
  }
}
