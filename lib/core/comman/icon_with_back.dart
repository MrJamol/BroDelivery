import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget iconWithBackground({String iconPath = '', bool isSvg = false, required VoidCallback onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: 15,
      height: 15,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: isSvg
            ? SvgPicture.asset(iconPath, height: 26, width: 26)
            : Image.asset(iconPath, height: 15, width: 15),
      ),
    ),
  );
}
