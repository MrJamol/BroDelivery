abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final String userName;
  final String email;

  ProfileLoaded(this.userName, this.email);
}
