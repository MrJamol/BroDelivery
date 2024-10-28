import 'package:equatable/equatable.dart';

abstract class RestaurantEvent extends Equatable {
  const RestaurantEvent();

  @override
  List<Object> get props => [];
}

class ChangeSortByEvent extends RestaurantEvent {
  final String sortBy;

  const ChangeSortByEvent(this.sortBy);

  @override
  List<Object> get props => [sortBy];
}
