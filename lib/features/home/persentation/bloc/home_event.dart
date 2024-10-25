abstract class HomeEvent {}

class SelectCategoryEvent extends HomeEvent {
  final String category;

  SelectCategoryEvent(this.category);
}
