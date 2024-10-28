import 'package:equatable/equatable.dart';

class RestaurantState extends Equatable {
  final String sortBy;

  const RestaurantState({required this.sortBy});

  @override
  List<Object> get props => [sortBy];
}
