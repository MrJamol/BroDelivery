// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:food_delivery/features/cart/presentation/bloc/item_model.dart';
import 'package:hive/hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************



class CartItemAdapter extends TypeAdapter<CartItem> {
  @override
  final int typeId = 0;

  @override
  CartItem read(BinaryReader reader) {
    final fields = <int, dynamic>{
      for (var i = 0; i < 5; i++) i: reader.read(),
    };
    return CartItem(
      imagePath: fields[0] as String,
      title: fields[1] as String,
      description: fields[2] as String,
      price: fields[3] as double,
      quantity: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, CartItem obj) {
    writer
      ..write(obj.imagePath)
      ..write(obj.title)
      ..write(obj.description)
      ..write(obj.price)
      ..write(obj.quantity);
  }
}
