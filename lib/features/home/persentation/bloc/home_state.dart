abstract class HomeState {}

class HomeInitialState extends HomeState {}

class CategorySelectedState extends HomeState {
  final String selectedCategory;

  CategorySelectedState(this.selectedCategory);
}
