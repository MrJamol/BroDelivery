import 'package:flutter/material.dart';
import 'package:food_delivery/core/constants/colors/app_colors.dart';

class CartItemTile extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
  final double price;
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final Function(int)? onQuantityChanged; // Callback for quantity change
  final VoidCallback? onRemove;

  const CartItemTile({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
    required this.price,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
    this.onQuantityChanged, // Optional callback for quantity changes
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          // Rounded Image with ClipRRect
          ClipRRect(
            borderRadius: BorderRadius.circular(12.0), // Rounded corners
            child: Image.asset(
              imagePath,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    // 'X' button, only shown if onRemove is provided
                    if (onRemove != null)
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.red),
                        onPressed: onRemove,
                      ),
                  ],
                ),
                Text(description, style: const TextStyle(color: Colors.grey)),
                Text(
                  '\$${price.toStringAsFixed(2)}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Row(
            children: [
              GestureDetector(
                onTap: onDecrement,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.instance.white,
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(6),
                  child: Icon(
                    Icons.remove,
                    size: 20,
                    color: AppColors.instance.kPrimary,
                  ),
                ),
              ),
              const SizedBox(width: 8), // Space between buttons
              // Editable quantity field
              SizedBox(
                width: 40, // Set a fixed width for the input
                child: TextField(
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  controller: TextEditingController(text: quantity.toString()),
                  onChanged: (value) {
                    // Parse input and update the quantity
                    int? newQuantity = int.tryParse(value);
                    if (newQuantity != null && newQuantity >= 0) {
                      if (onQuantityChanged != null) {
                        onQuantityChanged!(newQuantity);
                      }
                    }
                  },
                  decoration: const InputDecoration(
                    border: InputBorder.none, // No border
                    hintText: '0', // Optional hint text
                  ),
                ),
              ),
              const SizedBox(width: 8), // Space between buttons
              GestureDetector(
                onTap: onIncrement,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.instance.kPrimary,
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(6),
                  child: Icon(
                    Icons.add,
                    size: 20,
                    color: AppColors.instance.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
