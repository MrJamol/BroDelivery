import 'package:flutter/material.dart';
import 'package:food_delivery/core/constants/colors/app_colors.dart';

class CategoryIconWidget extends StatelessWidget {
  final String categoryName;
  final String iconPath;
  final bool isSelected;
  final VoidCallback onSelected;

  const CategoryIconWidget({
    Key? key,
    required this.categoryName,
    required this.iconPath,
    required this.isSelected,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelected,
      child: Container(
        width: 60,
        height: 100,
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.instance.kPrimary
              : AppColors.instance.white,
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 5,
            ),
            Image.asset(
              iconPath,
              height: 50,
              width: 50,
            ),
            SizedBox(height: 4),
            Text(
              categoryName,
              style: TextStyle(
                fontSize: 12,
                color: isSelected
                    ? AppColors.instance.white
                    : AppColors.instance.black,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
