import 'package:hive/hive.dart';


@HiveType(typeId: 0) 
class CartItem {
  @HiveField(0)
  final String imagePath;
  
  @HiveField(1)
  final String title;
  
  @HiveField(2)
  final String description;
  
  @HiveField(3)
  final double price;
  
  @HiveField(4)
  final int quantity;

  CartItem({
    required this.imagePath,
    required this.title,
    required this.description,
    required this.price,
    required this.quantity,
  });
}
