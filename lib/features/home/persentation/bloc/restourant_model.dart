class RestaurantModel {
  final String name;
  final double rating;
  final String type;

  RestaurantModel({required this.name, required this.rating, required this.type});
}

class PopularItemModel {
  final String name;
  final double price;

  PopularItemModel({required this.name, required this.price});
}
